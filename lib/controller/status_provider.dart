import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vsd_scheduler/model/schedule.dart';

class StatusProviderNotifier extends StateNotifier<bool> {
  StatusProviderNotifier() : super(false);

  void toggleUpdate(Schedule item) {
    if (item.ischecked) state = !state;
  }
}

final statusProvider = StateNotifierProvider<StatusProviderNotifier, bool>(
  (ref) => StatusProviderNotifier(),
);
