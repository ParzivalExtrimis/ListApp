import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingStateNotifierProvider =
    StateNotifierProvider<LoadingStateNotifier, bool>(
        (ref) => LoadingStateNotifier());

class LoadingStateNotifier extends StateNotifier<bool> {
  LoadingStateNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}
