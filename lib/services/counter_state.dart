import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterState extends StateNotifier<int> {
  CounterState(int value) : super(value);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

final countProvider = StateNotifierProvider<CounterState, int>((ref) {
  return CounterState(0);
});
