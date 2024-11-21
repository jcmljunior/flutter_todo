import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_todo/features/overview/models/overview_item_model.dart';
import 'package:flutter_todo/features/overview/states/overview_state.dart';
import 'package:flutter_todo/features/overview/stores/overview_store.dart';

import '../../mock_data/mock.data.dart';

void main() {
  test('isLoading setter deve atualizar o estado.', () {
    final OverviewStore overviewStore = OverviewStore(const OverviewInitial());
    final bool isLoading = !overviewStore.isLoading;

    overviewStore.isLoading = isLoading;

    expect(overviewStore.isLoading, isLoading);
  });

  test('isScrolling setter deve atualizar o estado.', () {
    final OverviewStore overviewStore = OverviewStore(const OverviewInitial());
    final bool isScrolling = !overviewStore.isScrolling;

    overviewStore.isScrolling = isScrolling;

    expect(overviewStore.isScrolling, isScrolling);
  });

  test('index setter deve atualizar o estado.', () {
    final OverviewStore overviewStore = OverviewStore(const OverviewInitial());
    final int index = overviewStore.index + 1;

    overviewStore.index = index;

    expect(overviewStore.index, index);
  });

  test('items setter deve atualizar o estado.', () {
    final OverviewStore overviewStore = OverviewStore(const OverviewInitial());
    final List<OverviewItemModel> items = [
      OverviewItemModel(
        id: MockData.generateInt(),
        title: MockData.generateString(length: 16),
        content: MockData.generateString(length: 16),
        image: MockData.generateString(length: 16),
      ),
    ];

    overviewStore.items = items;

    expect(overviewStore.items.contains(items.first), isTrue);
  });
}
