# bloc-student-internship
**Simple example project for student interns**

This project is meant to simply explain and show in example how bloc pattern should be used in Flutter applications.

BLoC pattern is based on separation of concerns principle and separates code in three major layers.
  - Data layer (repository, models, etc.)
  - Business logic layer
  - Presentation layer(UI

![image](https://github.com/zmesinger/bloc-student-internship/assets/51672341/b811c8ba-bef2-431d-a41e-c2fc897182b1)

### Main idea
As shown in the figure above, main idea of UI is to respond to states that are result of events trigerred by UI\

E.g. User pressed "Log in" button which triggers log in event and sends it to BLoC, after response from login service, bloc emitts successfull state or failed state and UI rebuilds according to emitted state.

### BLoC structure
Each BLoC consists of three main components:
  - Event
  - State
  - Bloc

Event part consists of all the events that can be used within corresponding bloc, Event can have variables assigned via constructor and used in event handling

State part consists of all the state that UI can react to. States can have variables containing data that needs to be presented to the user.

Bloc is main part where Events and States combine. Events are handled in bloc and states are emitted inside the events.

E.g. StartLoginEvent is trigerred and inside that event first we emit LoginInitialized state, and after we get response from login service we emit SuccessfullLogin or FailedLogin state

Important widgets to understand: 
  - BlocProvider: Used for creating and injecting BLoC instances(ensures that only one instance of given BLoC is used through the app)
  - BlocBuilder: Used for rebuilding UI according to states(should be used on the lowest possible element in widget tree)
  - BlocListener: Most often used for displaying Snackbars and Toast messages(note that unlike BlocBuilder, this widget is only called once per state change)

Important conecpts to understand:
  - Adding events: Most often events are actions that are trigerred by users, although it should be noted that events can be trigerred in BLoC by using add() method
  - Emitting state from BLoC: We want the user to know why is he waiting so usually we emit Initialized state which is followed by Success or Failed state that is emitted after some aciton is finished

### Reacting to state:
Our UI needs to respond to state, we can achieve that using the BlocBuilder widget from flutter_bloc package. 

In code below, we are reacting to state emitted by ExampleBloc, each time state or its values change, screen is rebuilded.
```
 BlocBuilder<ExampleBloc, ExampleState>(
          bloc: BlocProvider.of<ExampleBloc>(context),
          builder: (context, state) {
              if(state is ActionStarted) {
                return _buildWaitingScreen();
              } else if(state is ActionSuccessful) {
                return _buildSuccessScreen(state.dataToBePresented);
              } else if(state is ActionFailed) {
                return _buildFailedScreen(state.errorMessage);
              } else {
                return Container();
              }
          }
      )
```

### Project structure

Usage of this app is simple, user enters two numbers inside input fields and addition of those numbers is displayed on the screen. If user enters invalid data, UI displays error message. Reset button resets the UI to initial state.

In this demo project you will find two directories that are important for now.
  - bloc is where bloc files are bundled in calculator_bloc directory
  - ui has only one file which is main screen of this simple app

**App flow** 
1. When user uses the "Calculate" button, CalculatePressed event is added using `BlocProvider.of<CalculatorBloc>(context).add(CalculatePressed(firstNumberController.text, secondNumberController.text));` line of code.
  - This Event class needs to have two variables initialized, firstNumber and secondNumber
2. Event is passed bny BlocProvider to the bloc repsonsible for its handling(CalculatorBloc)
3. Calculate event is handled by CalculatorBloc, first the CalculationInitialized state is emitted, UI rebuilds and CircularProgressIndicator is displayed to the user(note: `await Future.delayed(Duration(seconds:3));` is only used to show how UI responds to state changes)
4. After three seconds pass, code inside try block is executed, if it executes without errors, CalculationFinished is emitted and UI displays the result that is being passed inside state consturctor.
5. In case calculation inside try block failes, catch block is executed and CalculationFailed is emitted and error message is displayed to the user.

```
  FutureOr<void> _calculate(CalculatePressed event, Emitter<CalculatorBlocState> emit) async {

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
```

6. User triggers ResetPressed event by pressing the "Reset" button: `BlocProvider.of<CalculatorBloc>(context).add(const ResetPressed());`
7. Event is once again passed by BlocProvider to CalculatorBloc, in which event is handled by simply emitting CalculatorInitial state.
```
  FutureOr<void> _reset(ResetPressed event, Emitter<CalculatorBlocState> emit) {
    emit(const CalculatorInitial());
  }
```



