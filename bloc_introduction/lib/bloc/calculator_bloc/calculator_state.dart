import 'package:equatable/equatable.dart';

abstract class CalculatorBlocState extends Equatable {
  const CalculatorBlocState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorBlocState {
  const CalculatorInitial():super();
}

class CalculationInitialized extends CalculatorBlocState {
  const CalculationInitialized();
}

class CalculationFailed extends CalculatorBlocState {
  final String errorMessage;

  const CalculationFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CalculationFinished extends CalculatorBlocState {
  final double result;

  const CalculationFinished(this.result);

  @override
  List<Object> get props => [result];
}