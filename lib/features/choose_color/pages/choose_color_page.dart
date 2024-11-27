import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app/constants/app_constant.dart';
import '../../overview/constants/overview_constant.dart';
import '../../theme_manager/containers/theme_manager_container.dart';
import '../../theme_manager/helpers/colorize_vector_helper.dart';
import '../../translate_manager/containers/translate_manager_container.dart';
import '../../translate_manager/stores/translate_manager_store.dart';
import '../constants/choose_color_constant.dart';

@immutable
class ChooseColorPage extends StatefulWidget {
  final List<Color> colors;

  const ChooseColorPage({
    super.key,
    this.colors = const [
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
    ],
  });

  @override
  State<ChooseColorPage> createState() => _ChooseColorPageState();
}

class _ChooseColorPageState extends State<ChooseColorPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    setController();
    setAnimation();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void setController() {
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: ChooseColorConstant.defaultAnimationDuration,
      ),
      vsync: this,
    );
  }

  void setAnimation() {
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget getImage() => Center(
        child: SizedBox(
          width: double.infinity,
          child: ScaleTransition(
            scale: _animation,
            child: SvgPicture(
              width: MediaQuery.of(context).size.height / 3,
              SvgAssetLoader(
                '${AppConstant.resourcePath}/images/undraw_color_palette_re_dwy7.svg',
                colorMapper: ColorizeVectorHelper(
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
      );

  Widget getTitle(
      TranslateManagerStore translateManagerStore, TextStyle? style) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        translateManagerStore.fetchLocalizedStrings('choose_your_color.title'),
        style: style,
      ),
    );
  }

  Widget getDescription(
      TranslateManagerStore translateManagerStore, TextStyle? style) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        translateManagerStore
            .fetchLocalizedStrings('choose_your_color.description'),
        style: style,
      ),
    );
  }

  void onColorSelectedHandler(BuildContext context, Color color) {
    ThemeManagerContainer.of(context).themeManagerStore.accentColor = color;
  }

  Widget getColors(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 3.0,
        runSpacing: 3.0,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: widget.colors
            .map(
              (Color color) => InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () => onColorSelectedHandler(context, color),
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  margin: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: color,
                  ),
                  child: ThemeManagerContainer.of(context)
                              .themeManagerStore
                              .accentColor ==
                          color
                      ? Container(
                          margin: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                          ),
                          child: const Icon(
                            Icons.done,
                            size: 16.0,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void onColorPickerButtonPressedHandler(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (context) => getColors(context),
    );
  }

  Widget getColorPickerButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => onColorPickerButtonPressedHandler(context),
      icon: const Icon(Icons.palette_outlined),
      label: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        children: [
          Text(TranslateManagerContainer.of(context)
              .translateManagerStore
              .fetchLocalizedStrings('choose_your_color.custom_color')),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16.0,
          ),
        ],
      ),
    );
  }

  void onNavigateNextButtonPressedHandler(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, OverviewConstant.routeName);
    }
  }

  Widget getNavigateNextButton() {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 2.0), end: Offset.zero)
          .animate(_controller),
      child: FloatingActionButton(
        onPressed: () => onNavigateNextButtonPressedHandler(context),
        child: const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getNavigateNextButton(),
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 24.0,
          runSpacing: 24.0,
          children: [
            getImage(),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                getTitle(
                    TranslateManagerContainer.of(context).translateManagerStore,
                    Theme.of(context).textTheme.headlineMedium),
                getDescription(
                    TranslateManagerContainer.of(context).translateManagerStore,
                    Theme.of(context).textTheme.bodyLarge),
                getColorPickerButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
