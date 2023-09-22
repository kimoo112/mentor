// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());
  int countValue = 0;

  increaseValue() {
    countValue++;
    emit(CounterIncreased());
  }

  decreaseValue() {
    countValue--;
    emit(CounterDecreased());

  }
}
