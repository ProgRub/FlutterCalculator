import 'package:flutter/material.dart';
import 'enums.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late TextEditingController displayNumbersController,
      displayOperationController;
  late DeleteMode deleteMode;
  late String clearButtonText;
  late int runningResult;
  late Operations previousSelectedOperation;
  late bool showingResult, darkModeOn;
  late List<String> calculationsHistory;
  late ButtonStyle buttonStyle;
  static const TextStyle textStyleButtons =
      TextStyle(color: Colors.white, fontSize: 15.0);
  static const TextStyle textStyleDisplays =
      TextStyle(color: Colors.white, fontSize: 15.0);

  static const InputDecoration displayStyle = InputDecoration(
      border: InputBorder.none, filled: true, fillColor: Color.fromARGB(255, 11, 41, 97));

  @override
  void initState() {
    displayNumbersController = TextEditingController();
    displayNumbersController.text = "0";
    displayOperationController = TextEditingController();
    displayOperationController.text = "";
    deleteMode = DeleteMode.clearNumber;
    clearButtonText = "AC";
    showingResult = false;
    runningResult = 0;
    previousSelectedOperation = Operations.equals;
    calculationsHistory = <String>[];
    buttonStyle = ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        )),
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 11, 41, 97)));
    textStyleButtons;
    darkModeOn = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calculator'),
        ),
        body: Column(children: [TextField(
                controller: displayOperationController,
                decoration: displayStyle,
                readOnly: true,
                style: textStyleDisplays),TextField(
                controller: displayNumbersController,
                decoration: displayStyle,
                readOnly: true,
                style: textStyleDisplays),
          Row(mainAxisSize: MainAxisSize.min,children: [
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(7)},
                child: const Text('7', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(8)},
                child: const Text('8', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(9)},
                child: const Text('9', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {deleteDigit()},
                child: const Text("DEL", style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {clearFunction()},
                child: Text(clearButtonText, style: textStyleButtons)),
          ]),
          Row(mainAxisSize: MainAxisSize.min,children: [
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(4)},
                child: const Text('4', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(5)},
                child: const Text('5', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(6)},
                child: const Text('6', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {addOperator(Operations.addition)},
                child: const Text('+', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {addOperator(Operations.subtraction)},
                child: const Text('-', style: textStyleButtons))
          ]),
          Row(mainAxisSize: MainAxisSize.min,children: [
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(1)},
                child: const Text('1', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(2)},
                child: const Text('2', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {registerNumber(3)},
                child: const Text('3', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {addOperator(Operations.multiplication)},
                child: const Text('x', style: textStyleButtons)),
            TextButton(
                style: buttonStyle,
                onPressed: () => {addOperator(Operations.division)},
                child: const Text('/', style: textStyleButtons))
          ]),
          Row(mainAxisSize: MainAxisSize.min,children: [
            Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 56.0),
                child: TextButton(
                    style: buttonStyle,
                    onPressed: () => {registerNumber(0)},
                    child: const Text('0', style: textStyleButtons)))),
            Padding(
                padding: const EdgeInsets.only(left: 112.0),
                child: TextButton(
                    style: buttonStyle,
                    onPressed: () => {showResult(true)},
                    child: const Text('=', style: textStyleButtons)))
          ])
        ]));
  }

  void deleteDigit() {
    if (previousSelectedOperation == Operations.equals) return;
    var text = displayNumbersController.text.split(" ").join("");
    var displayNumber = int.parse(text) ~/ 10;
    displayNumbersController.text = beautifyNumber(displayNumber);
    if (displayNumber == 0) changeDeleteMode(DeleteMode.clearOperation);
  }

  void registerNumber(int number) {
    var text = displayNumbersController.text.split(" ").join("");
    if (showingResult) {
      text = "0";
      showingResult = false;
    }
    var displayNumber = int.parse(text) * 10 + number;
    displayNumbersController.text = beautifyNumber(displayNumber);
    changeDeleteMode(DeleteMode.clearNumber);
  }

  void changeDeleteMode(DeleteMode mode) {
    deleteMode = mode;
    setState(() {
      if (deleteMode == DeleteMode.clearNumber) {
        clearButtonText = "C";
      } else {
        clearButtonText = "AC";
      }
    });
  }

  void clearFunction() {
    if (deleteMode == DeleteMode.clearNumber) {
      displayNumbersController.text = "0";
      changeDeleteMode(DeleteMode.clearOperation);
    } else {
      displayNumbersController.text = "0";
      displayOperationController.text = "";
      runningResult = 0;
    }
  }

  String beautifyNumber(int number) {
    var numberTextCharArray = number.toString().characters.toList();
    var index = numberTextCharArray.length - 3;
    while (index > 0) {
      numberTextCharArray.insert(index, ' ');
      index -= 3;
    }
    return numberTextCharArray.join("");
  }

  void addOperator(Operations operation) {
    var numberText = displayNumbersController.text.split(" ").join("");
    var number = int.parse(numberText);
    var numberToAdd = beautifyNumber(number);
    if (previousSelectedOperation == Operations.equals) {
      displayOperationController.text = "";
    }
    var operationClear = displayOperationController.text.isEmpty;
    displayOperationController.text += numberToAdd;
    if (operationClear) {
      runningResult = number;
    }
    switch (operation) {
      case Operations.addition:
        displayOperationController.text += " + ";
        break;
      case Operations.subtraction:
        displayOperationController.text += " - ";
        break;
      case Operations.multiplication:
        displayOperationController.text += " x ";
        break;
      case Operations.division:
        displayOperationController.text += " / ";
        break;
      case Operations.equals:
        // TODO: Handle this case.
        break;
    }
    switch (previousSelectedOperation) {
      case Operations.addition:
        runningResult += number;
        break;
      case Operations.subtraction:
        runningResult -= number;
        break;
      case Operations.multiplication:
        runningResult *= number;
        break;
      case Operations.division:
        runningResult ~/= number;
        break;
      case Operations.equals:
        changeDeleteMode(DeleteMode.clearNumber);
        break;
    }
    previousSelectedOperation = operation;
    clearFunction();
    showResult(false);
  }

  void showResult(bool fromEquals) {
    showingResult = true;
    if (fromEquals) {
      var numberText = displayNumbersController.text.split(" ").join("");
      var number = int.parse(numberText);
      displayOperationController.text += beautifyNumber(number);
      switch (previousSelectedOperation) {
        case Operations.addition:
          runningResult += number;
          break;
        case Operations.subtraction:
          runningResult -= number;
          break;
        case Operations.multiplication:
          runningResult *= number;
          break;
        case Operations.division:
          runningResult ~/= number;
          break;
        case Operations.equals:
          // TODO: Handle this case.
          break;
      }
      previousSelectedOperation = Operations.equals;
      changeDeleteMode(DeleteMode.clearOperation);
      calculationsHistory.add(displayOperationController.text +
          " = " +
          beautifyNumber(runningResult));
      print(calculationsHistory);
    }
    displayNumbersController.text = beautifyNumber(runningResult);
  }
}
