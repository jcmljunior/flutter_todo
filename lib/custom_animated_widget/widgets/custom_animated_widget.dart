import 'package:flutter/material.dart';
import '../mixins/custom_animated_widget_mixin.dart';
import '../states/custom_animated_widget_state.dart';
import '../stores/custom_animated_widget_store.dart';

// CustomAnimatedWidget é um StatefulWidget que fornece uma interface genérica para criar componentes animados.
// Ela gerencia internamente o estado da animação e controla a visibilidade do widget com base em uma lógica personalizada.
@immutable
class CustomAnimatedWidget extends StatefulWidget {
  // Um objeto Listenable externo que, quando alterado, dispara uma reconstrução do widget.
  // Isso é útil para sincronizar animações ou atualizações visuais com mudanças em outros estados da aplicação.
  final Listenable? listenable;

  // Uma função de callback que é chamada quando o estado do widget é inicializado.
  // Permite que widgets externos recebam o estado do componente, promovendo flexibilidade no controle e evitando o uso de GlobalKey.
  final void Function(CustomAnimatedWidgetState)? onInitState;

  // Uma função que define a aparência do widget.
  // Recebe o contexto e o estado atual da animação para renderizar o layout de forma personalizada.
  final Widget Function(BuildContext, CustomAnimatedWidgetState?) builder;

  const CustomAnimatedWidget({
    super.key,
    this.listenable,
    this.onInitState,
    required this.builder,
  });

  @override
  State<CustomAnimatedWidget> createState() => CustomAnimatedWidgetState();
}

class CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin, CustomAnimatedWidgetMixin {
  late final CustomAnimatedWidgetStore _store;
  late final AnimationController _controller;

  Listenable? get listenable => widget.listenable;

  @override
  CustomAnimatedWidgetStore get store => _store;

  @override
  AnimationController get controller => _controller;

  @override
  void initState() {
    setStore();
    setController();

    // Inicializa o ticker da animação.
    // Requerido para o controle do ticker externamente.
    _store.isVisible = true;
    _controller.forward();

    // Exporta o estado do componente para o widget externo.
    // Solução alternativa ao uso do GlobalKey oferecendo melhor performance.
    widget.onInitState?.call(this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void setStore() {
    _store = CustomAnimatedWidgetStore(const CustomAnimatedWidgetInitial());
  }

  void setController() {
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 1600,
      ),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: widget.key,
      animation: Listenable.merge([
        _store,
        _controller,
        listenable,
      ]),
      // O componente Visibility é usado aqui para controlar a exibição do widget animado
      // de forma que ele seja completamente removido da árvore de widgets quando não
      // estiver visível (_store.isVisible == false). Isso é importante porque, diferentemente
      // da opacidade (Opacity), que apenas torna o widget invisível mas mantém seu espaço
      // e funcionalidade (como eventos de clique), o Visibility impede que o usuário interaja
      // com o widget oculto. Esse comportamento é necessário para evitar que o componente
      // responda a cliques ou outras interações quando ele não deve estar visível.
      builder: (context, _) => Visibility(
        visible: _store.isVisible,
        child: widget.builder(
          context,
          this,
        ),
      ),
    );
  }
}
