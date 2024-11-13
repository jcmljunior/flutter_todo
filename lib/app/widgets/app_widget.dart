import 'package:flutter/material.dart';

import '../../features/tasks/pages/today_page.dart';
import '../../features/theme_manager/constants/theme_manager_constant.dart';
import '../../features/theme_manager/containers/theme_manager_container.dart';
import '../../features/theme_manager/mixins/theme_manager_mixin.dart';
import '../../features/theme_manager/states/theme_manager_state.dart';
import '../../features/theme_manager/stores/theme_manager_store.dart';
import '../../features/translate_manager/containers/translate_manager_container.dart';
import '../../features/translate_manager/states/translate_manager_state.dart';
import '../../features/translate_manager/stores/translate_manager_store.dart';
import '../constants/app_constant.dart';
import '../containers/app_container.dart';
import '../states/app_state.dart';
import '../stores/app_store.dart';

@immutable
class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with ThemeManagerMixin {
  final AppStore appStore = AppStore(const AppInitial());
  final ThemeManagerStore themeManagerStore =
      ThemeManagerStore(const ThemeManagerInitial());
  final TranslateManagerStore translateManagerStore = TranslateManagerStore(
    const TranslateManagerInitial(),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Inicialização da captura do tema padrão no sistema.
    initializePlatformBrightness(context);

    // Define a inicialização inicial da aplicação.
    WidgetsBinding.instance.endOfFrame.then((_) {
      appStore.isInitialized = true;
    });
  }

  void initializePlatformBrightness(BuildContext context) {
    if (themeManagerStore.themeMode == ThemeMode.system &&
        !appStore.isInitialized) {
      themeManagerStore.brightness =
          View.of(context).platformDispatcher.platformBrightness;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appStore: appStore,
      themeManagerStore: themeManagerStore,
      translateManagerStore: translateManagerStore,
      child: ThemeManagerContainer(
        themeManagerStore: themeManagerStore,
        child: TranslateManagerContainer(
          translateManagerStore: translateManagerStore,
          child: AnimatedBuilder(
            animation: Listenable.merge([
              appStore,
              themeManagerStore,
            ]),
            builder: (BuildContext context, Widget? _) {
              handlePlatformBrightnessChanged(context);

              return MaterialApp(
                debugShowCheckedModeBanner:
                    AppConstant.defaultDebugShowCheckedModeBanner,
                title: AppConstant.appName,
                themeMode: themeManagerStore.themeMode,
                theme: ThemeData(
                  useMaterial3: ThemeManagerConstant.defaultUseMaterial3,
                  fontFamily: ThemeManagerConstant.defaultFontFamily,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: themeManagerStore.accentColor,
                    brightness: getBrightness(context),
                  ),
                  appBarTheme: ThemeManagerConstant.appBarTheme,
                  drawerTheme: ThemeManagerConstant.drawerTheme,
                  dialogTheme: ThemeManagerConstant.dialogTheme,
                  elevatedButtonTheme: ThemeManagerConstant.elevatedButtonTheme,
                  floatingActionButtonTheme:
                      ThemeManagerConstant.floatingActionButtonTheme,
                  textButtonTheme: ThemeManagerConstant.textButtonTheme,
                  checkboxTheme: ThemeManagerConstant.checkboxTheme,
                ),
                initialRoute: AppConstant.defaultInitialRoute,
                routes: {
                  AppConstant.defaultInitialRoute: (_) => const TodayPage(),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
