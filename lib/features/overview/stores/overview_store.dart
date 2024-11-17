import 'package:flutter/foundation.dart';

import '../../value_notifier/extensions/value_notifier_extension.dart';
import '../models/overview_item_model.dart';
import '../states/overview_state.dart';

class OverviewStore extends ValueNotifier<OverviewState> {
  OverviewStore(super.value);

  bool get isLoading => state.isLoading!;

  set isLoading(bool value) {
    if (isLoading == value) return;

    state = state.copyWith(
      isLoading: value,
    );
  }

  bool get isScrolling => state.isScrolling!;

  set isScrolling(bool value) {
    if (isScrolling == value) return;

    state = state.copyWith(
      isScrolling: value,
    );
  }

  int get index => state.index!;

  set index(int value) {
    if (index == value) return;

    state = state.copyWith(
      index: value,
    );
  }

  List<OverviewItemModel> get items => state.items!;

  set items(List<OverviewItemModel> value) {
    if (items == value) return;

    state = state.copyWith(
      items: value,
    );
  }
}
