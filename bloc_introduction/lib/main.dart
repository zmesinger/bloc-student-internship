import 'package:bloc_introduction/bloc/calculator_bloc/calculator_bloc.dart';
import 'package:bloc_introduction/ui/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlocIntro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => CalculatorBloc(),
        child: const CalculatorScreen(),
      )
    );
  }
}



