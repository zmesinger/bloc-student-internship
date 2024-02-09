import 'package:equatable/equatable.dart';

abstract class CalculatorBlocEvent extends Equatable {
  const CalculatorBlocEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class CalculatePressed extends CalculatorBlocEvent {
  final String firstNumber;
  final String secondNumber;

  const CalculatePressed(this.firstNumber, this.secondNumber);

  @override
  List<Object> get props => [firstNumber, secondNumber];
}

class ResetPressed extends CalculatorBlocEvent {
  const ResetPressed();

  @override
  List<Object> get props => [];
}