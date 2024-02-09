
import 'dart:async';

import 'package:bloc_introduction/bloc/calculator_bloc/calculator_event.dart';
import 'package:bloc_introduction/bloc/calculator_bloc/calculator_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorBloc extends Bloc<CalculatorBlocEvent, CalculatorBlocState>  {
  CalculatorBloc() : super(const CalculatorInitial()) {
    on<CalculatePressed>(_calculate);
    on<ResetPressed>(_reset);
  }


  FutureOr<void> _calculate(CalculatePressed event, Emitter<CalculatorBlocState> emit) async{

    emit(const CalculationInitialized());
    await Future.delayed(const Duration(seconds: 3));
    try {

      var result = double.parse(event.firstNumber) + double.parse(event.secondNumber);
      emit(CalculationFinished(result));

    } catch (e) {
      debugPrint(e.toString());
      emit(const CalculationFailed("Failed in calculation, check your input"));

    }
  }

  FutureOr<void> _reset(ResetPressed event, Emitter<CalculatorBlocState> emit) {
    emit(const CalculatorInitial());
  }
}
