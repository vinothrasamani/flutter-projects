import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationProviderNotifier extends StateNotifier<bool> {
  BottomNavigationProviderNotifier() : super(true);

  void scrollControl(ScrollController scrollController) {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      state = true;
    } else {
      state = false;
    }
  }
}

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationProviderNotifier, bool>((ref) {
  return BottomNavigationProviderNotifier();
});
