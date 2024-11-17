import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/constants/app_constant.dart';
import '../../animated_button/widgets/floating_action_button_widget.dart';
import '../../colorize_vectors/colorize_vector.dart';
import '../../theme_manager/containers/theme_manager_container.dart';
import '../../theme_manager/mixins/color_utilities_mixin.dart';
import '../../translate_manager/containers/translate_manager_container.dart';
import '../containers/overview_container.dart';
import '../states/overview_state.dart';
import '../stores/overview_store.dart';

@immutable
class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with TickerProviderStateMixin, ColorUtilitiesMixin {
  late final OverviewStore overviewStore;
  late final TabController tabController;
  late final PageController pageController;
  late final List<AnimationController> imageControllers;
  late final List<Animation> imageAnimations;

  @override
  void initState() {
    super.initState();

    setOverviewStore();
    setTabController();
    setPageController();
    setImageControllers();
    setImageAnimations();

    pageController.addListener(handlePageScrolling);
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.removeListener(handlePageScrolling);

    for (var controller in imageControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void setOverviewStore() {
    overviewStore = OverviewStore(
      const OverviewInitial(),
    );
  }

  void setTabController() {
    tabController = TabController(
      length: overviewStore.items.length,
      vsync: this,
    );
  }

  void setPageController() {
    pageController = PageController(
      initialPage: 0,
    );
  }

  void setImageControllers() {
    imageControllers = List.generate(
      overviewStore.items.length,
      (int index) => AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      ),
    );
  }

  void setImageAnimations() {
    imageAnimations = List.generate(
      overviewStore.items.length,
      (int index) => CurvedAnimation(
        parent: imageControllers[index],
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  bool _isScrollingBack(double pageOffset, int currentPage) {
    return pageOffset < 0.5 &&
        !overviewStore.isScrolling &&
        currentPage < overviewStore.index;
  }

  bool _isScrollingForward(double pageOffset, int currentPage) {
    return pageOffset > 0.5 &&
        !overviewStore.isScrolling &&
        overviewStore.index == currentPage;
  }

  void handlePageScrolling() {
    final int currentPage = pageController.page!.toInt();
    final double pageOffset = pageController.page! - currentPage;

    if (_isScrollingBack(pageOffset, currentPage)) {
      overviewStore.isScrolling = true;
      handleImageAnimation();
    }

    if (_isScrollingForward(pageOffset, currentPage)) {
      overviewStore.isScrolling = true;
      handleImageAnimation();
    }

    // Quando a animação da rolagem for concluída, atualiza o estado.
    if (pageOffset == 0.0) {
      overviewStore.index = currentPage;
      overviewStore.isScrolling = false;
    }
  }

  void handleImageAnimation() {
    for (var index = 0; index < imageControllers.length; index++) {
      if (index != pageController.page?.round()) {
        imageControllers[index].reset();
        continue;
      }

      imageControllers[index].forward();
    }
  }

  Widget buildWidget(int id) {
    switch (id) {
      case 0:
        return ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              showDragHandle: true,
              context: context,
              builder: (context) => const ChooseLanguage(),
            );
          },
          icon: const Icon(Icons.language_outlined),
          label: const Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            children: [
              Text('Português do Brasil'),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16.0,
              ),
            ],
          ),
        );

      case 1:
        return ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              showDragHandle: true,
              context: context,
              builder: (context) => ChooseColor(),
            );
          },
          icon: const Icon(Icons.palette_outlined),
          label: const Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            children: [
              Text('Cores Personalizadas'),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16.0,
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  List<Widget> getPages() => List.generate(
        overviewStore.items.length,
        (int index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ScaleTransition(
                    scale: imageControllers.elementAt(index).drive(
                          CurveTween(
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                    child: SvgPicture(
                      width: MediaQuery.of(context).size.height / 3,
                      SvgAssetLoader(
                        '${AppConstant.resourcePath}/images/${overviewStore.items[index].image}',
                        colorMapper: ColorizeVector(
                          targetColors: const [
                            Color(0xff6c63ff),
                          ],
                          replacementColors: [
                            Theme.of(context).colorScheme.primary,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '${overviewStore.items[index].title}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '${overviewStore.items[index].content}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              buildWidget(overviewStore.items[index].id!),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleImageAnimation();
    });

    return OverviewContainer(
      overviewStore: overviewStore,
      tabController: tabController,
      pageController: pageController,
      imageControllers: imageControllers,
      child: Scaffold(
        floatingActionButton: FloatingActionButtonWidget(
          onPressed: () {},
          child: const Icon(Icons.arrow_forward_rounded),
        ),
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Pular'),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: AnimatedBuilder(
                  animation: overviewStore,
                  builder: (BuildContext context, Widget? _) {
                    return PageView(
                      controller: pageController,
                      clipBehavior: Clip.none,
                      physics: overviewStore.isScrolling
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      children: getPages(),
                    );
                  },
                ),
              ),
            ),
            const PageIndicatorWidget(),
          ],
        ),
      ),
    );
  }
}

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        OverviewContainer.of(context).pageController;
    final int pageCount = OverviewContainer.of(context).tabController.length;

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      child: AnimatedBuilder(
        animation: pageController,
        builder: (BuildContext context, Widget? child) {
          final int currentPage = pageController.page?.round() ?? 0;

          return Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: List.generate(
              pageCount,
              (int index) => AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                curve: Curves.fastOutSlowIn,
                width: index == currentPage ? 24.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: index == currentPage
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final translateManagerStore =
        TranslateManagerContainer.of(context).translateManagerStore;
    final Locale deviceLocale = View.of(context).platformDispatcher.locale;
    final List<Locale> availableLocales =
        translateManagerStore.getAvailableLocalesOrderBy(deviceLocale);

    return SingleChildScrollView(
      child: Wrap(
        children: List.generate(
          availableLocales.length,
          (int index) => ListTile(
            leading: Checkbox(
              value: availableLocales[index] ==
                  translateManagerStore.currentLocale,
              onChanged: (bool? value) {},
            ),
            onTap: () {
              translateManagerStore
                  .updateLocaleHandler(availableLocales[index]);
              if (!Navigator.canPop(context)) return;
              Navigator.pop(context);
            },
            title: Text(
              translateManagerStore.fetchLocalizedStrings(
                  'choose_language.${availableLocales[index].toString()}'),
            ),
            subtitle: availableLocales[index] == deviceLocale
                ? Text(translateManagerStore
                    .fetchLocalizedStrings('choose_language.device_language'))
                : null,
          ),
        ),
      ),
    );
  }
}

class ChooseColor extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  ChooseColor({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManagerStore =
        ThemeManagerContainer.of(context).themeManagerStore;

    return AnimatedBuilder(
      animation: themeManagerStore,
      builder: (BuildContext context, Widget? _) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                for (var index = 0; index < colors.length; index++)
                  InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: () {
                      themeManagerStore.accentColor = colors[index];
                    },
                    child: Container(
                      width: 32.0,
                      height: 32.0,
                      margin: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: colors[index] == themeManagerStore.accentColor
                          ? const Icon(Icons.done)
                          : const SizedBox.shrink(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
