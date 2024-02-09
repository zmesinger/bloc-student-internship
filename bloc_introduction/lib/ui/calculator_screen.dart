import 'package:bloc_introduction/assets/constants.dart' as constants;
import 'package:bloc_introduction/bloc/calculator_bloc/calculator_bloc.dart';
import 'package:bloc_introduction/bloc/calculator_bloc/calculator_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calculator_bloc/calculator_state.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {



  final firstNumberController = TextEditingController();
  final secondNumberController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(constants.appTitle),
      ),
      body: BlocBuilder<CalculatorBloc, CalculatorBlocState>(
          bloc: BlocProvider.of<CalculatorBloc>(context),
          builder: (context, state) {
            debugPrint(state.toString());

            if(state is CalculatorInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      _buildInputField(firstNumberController, constants.firstEntryField),
                      _buildInputField(secondNumberController, constants.secondEntryField),
                    ],
                  ),
                  OutlinedButton(
                      onPressed: _calculate,
                      child: const Text(constants.calculateButton))
                ],
              );
            } else if(state is CalculationInitialized){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is CalculationFinished) {
              return _buildOutcomeWidget(state.result.toString(), isResult: true);

            } else if(state is CalculationFailed) {
              return _buildOutcomeWidget(state.errorMessage);

            } else {
              return Container();
            }
          }
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String title) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: TextField(
          decoration: InputDecoration(
              label: Text(title),
              border: const OutlineInputBorder()
          ),
          controller: controller,
        ),
      ),
    );
  }

  Widget _buildOutcomeWidget(String outcomeText, {bool isResult = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(isResult ? "${constants.resultText}$outcomeText" : outcomeText),
        ),
        OutlinedButton(
            onPressed: _reset,
            child: const Text(constants.resetButton))
      ],
    );
  }

  _calculate() {
    BlocProvider.of<CalculatorBloc>(context).add(CalculatePressed(firstNumberController.text, secondNumberController.text));
  }

  _reset() {
    BlocProvider.of<CalculatorBloc>(context).add(const ResetPressed());
  }
}
