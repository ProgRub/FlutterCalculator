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
  late bool showingResult;
  late List<String> calculationsHistory;
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
    calculationsHistory=<String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calculator'),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
                controller: displayOperationController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                readOnly: true),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
                controller: displayNumbersController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                readOnly: true),
          ),
          Row(children: [
            TextButton(
                onPressed: () => {registerNumber(7)}, child: const Text('7')),
            TextButton(
                onPressed: () => {registerNumber(8)}, child: const Text('8')),
            TextButton(
                onPressed: () => {registerNumber(9)}, child: const Text('9')),
            TextButton(
                onPressed: () => {deleteDigit()}, child: const Text("DEL")),
            TextButton(
                onPressed: () => {clearFunction()},
                child: Text(clearButtonText)),
          ]),
          Row(children: [
            TextButton(
                onPressed: () => {registerNumber(4)}, child: const Text('4')),
            TextButton(
                onPressed: () => {registerNumber(5)}, child: const Text('5')),
            TextButton(
                onPressed: () => {registerNumber(6)}, child: const Text('6')),
            TextButton(
                onPressed: () => {addOperator(Operations.addition)},
                child: const Text('+')),
            TextButton(
                onPressed: () => {addOperator(Operations.subtraction)},
                child: const Text('-'))
          ]),
          Row(children: [
            TextButton(
                onPressed: () => {registerNumber(1)}, child: const Text('1')),
            TextButton(
                onPressed: () => {registerNumber(2)}, child: const Text('2')),
            TextButton(
                onPressed: () => {registerNumber(3)}, child: const Text('3')),
            TextButton(
                onPressed: () => {addOperator(Operations.multiplication)},
                child: const Text('x')),
            TextButton(
                onPressed: () => {addOperator(Operations.division)},
                child: const Text('/'))
          ]),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(left: 56.0),
                child: TextButton(
                    onPressed: () => {registerNumber(0)},
                    child: const Text('0'))),
            Padding(
                padding: const EdgeInsets.only(left: 112.0),
                child: TextButton(
                    onPressed: () => {showResult(true)},
                    child: const Text('=')))
          ])
        ]));
  }

  void deleteDigit() {
    if(previousSelectedOperation==Operations.equals) return;
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
    var index = numberTextCharArray.length-3;
    while (index >0) {
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
      calculationsHistory.add(displayOperationController.text+ " = "+beautifyNumber(runningResult));
      print(calculationsHistory);
    }
    displayNumbersController.text = beautifyNumber(runningResult);
  }
}
