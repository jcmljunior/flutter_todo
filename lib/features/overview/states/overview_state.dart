import 'package:flutter/material.dart' show immutable;

import '../models/overview_item_model.dart';

@immutable
sealed class OverviewState {
  final bool? isLoading;
  final bool? isScrolling;
  final int? index;
  final List<OverviewItemModel>? items;

  const OverviewState({
    this.isLoading,
    this.isScrolling,
    this.index,
    this.items,
  });

  OverviewState copyWith({
    bool? isLoading,
    bool? isScrolling,
    int? index,
    List<OverviewItemModel>? items,
  });
}

@immutable
class OverviewInitial extends OverviewState {
  const OverviewInitial({
    bool? isLoading,
    bool? isScrolling,
    int? index,
    List<OverviewItemModel>? items,
  }) : super(
          isLoading: isLoading ?? false,
          isScrolling: isScrolling ?? false,
          index: index ?? 0,
          items: items ??
              const [
                OverviewItemModel(
                  id: 0,
                  title: 'Escolha o idioma',
                  content:
                      'Por favor, escolha o idioma de sua preferência para continuar.',
                  image: 'undraw_around_the_world_re_rb1p.svg',
                ),
                OverviewItemModel(
                  id: 1,
                  title: 'Escolha a sua cor',
                  content: 'Ajuste a cor padrão da sua aplicação.',
                  image: 'undraw_color_palette_re_dwy7.svg',
                ),
                OverviewItemModel(
                  id: 2,
                  title: 'Gerenciar tarefas',
                  content: 'Adicione, edite e conclua suas tarefas facilmente.',
                  image: 'undraw_completed_tasks_vs6q.svg',
                ),
                OverviewItemModel(
                  id: 3,
                  title: 'Planejar tarefas',
                  content:
                      'Organize suas atividades de forma eficaz criando um plano detalhado para suas tarefas.',
                  image: 'undraw_schedule_re_2vro.svg',
                ),
                OverviewItemModel(
                  id: 4,
                  title: 'Sincronizar dados',
                  content:
                      'Compartilhe seu progresso entre dispositivos local.',
                  image: 'undraw_sync_re_492g.svg',
                ),
              ],
        );

  @override
  OverviewState copyWith({
    bool? isLoading,
    bool? isScrolling,
    int? index,
    List<OverviewItemModel>? items,
  }) =>
      OverviewInitial(
        isLoading: isLoading ?? this.isLoading,
        isScrolling: isScrolling ?? this.isScrolling,
        index: index ?? this.index,
        items: items ?? this.items,
      );
}
