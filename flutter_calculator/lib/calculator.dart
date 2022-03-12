import 'package:flutter/material.dart';
import 'package:spannable_grid/spannable_grid.dart';
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
  late ButtonStyle buttonOthersStyle, buttonDigitsStyle;
  static const TextStyle textStyleButtons =
      TextStyle(color: Colors.white, fontSize: 30.0);
  static const TextStyle textStyleDisplayNumbers =
      TextStyle(color: Colors.white, fontSize: 30.0);
  static const TextStyle textStyleDisplayOperations =
      TextStyle(color: Colors.white, fontSize: 15.0);
  static const Color blueAccent = Color.fromARGB(255, 0, 84, 174);
  static const Color greenAccent = Color.fromARGB(255, 12, 131, 2);
  static const Color redAccent = Color.fromARGB(255, 131, 2, 2);

  static const InputDecoration displayStyle = InputDecoration(
      border: InputBorder.none, filled: true, fillColor: blueAccent);

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
    buttonDigitsStyle = ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        )),
        backgroundColor:
            MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 0)));
    buttonOthersStyle = ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        )),
        backgroundColor: MaterialStateProperty.all(blueAccent));
    textStyleButtons;
    darkModeOn = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calculator'),
        ),
        body: Column(children: [
          TextField(
              textAlign: TextAlign.right,
              controller: displayOperationController,
              decoration: displayStyle,
              readOnly: true,
              style: textStyleDisplayOperations),
          TextField(
              textAlign: TextAlign.right,
              controller: displayNumbersController,
              decoration: displayStyle,
              readOnly: true,
              style: textStyleDisplayNumbers),
          Expanded(
            child: SpannableGrid(
              columns: 5,
              rows: 4,
              cells: [
                SpannableGridCellData(
                    id: 0,
                    column: 1,
                    row: 1,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(7)},
                        child: const Text('7', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 1,
                    column: 2,
                    row: 1,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(8)},
                        child: const Text('8', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 2,
                    column: 3,
                    row: 1,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(9)},
                        child: const Text('9', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 3,
                    column: 4,
                    row: 1,
                    child: TextButton(
                        style: buttonOthersStyle,
                        onPressed: () => {deleteDigit()},
                        child: const Text("DEL", style: textStyleButtons))),
                SpannableGridCellData(
                    id: 4,
                    column: 5,
                    row: 1,
                    child: TextButton(
                        style: buttonOthersStyle,
                        onPressed: () => {clearFunction()},
                        child: Text(clearButtonText, style: textStyleButtons))),
                SpannableGridCellData(
                    id: 5,
                    column: 1,
                    row: 2,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(4)},
                        child: const Text('4', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 6,
                    column: 2,
                    row: 2,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(5)},
                        child: const Text('5', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 7,
                    column: 3,
                    row: 2,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(6)},
                        child: const Text('6', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 8,
                    column: 4,
                    row: 2,
                    child: TextButton(
                        style: buttonOthersStyle,
                        onPressed: () => {addOperator(Operations.addition)},
                        child: const Text('+', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 9,
                    column: 5,
                    row: 2,
                    child: TextButton(
                        style: buttonOthersStyle,
                        onPressed: () => {addOperator(Operations.subtraction)},
                        child: const Text('-', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 10,
                    column: 1,
                    row: 3,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(1)},
                        child: const Text('1', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 11,
                    column: 2,
                    row: 3,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(2)},
                        child: const Text('2', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 12,
                    column: 3,
                    row: 3,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(3)},
                        child: const Text('3', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 13,
                    column: 4,
                    row: 3,
                    child: TextButton(
                        style: buttonOthersStyle,
                        onPressed: () =>
                            {addOperator(Operations.multiplication)},
                        child: const Text('x', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 14,
                    column: 5,
                    row: 3,
                    child: TextButton(
                        style: buttonOthersStyle,
                        onPressed: () => {addOperator(Operations.division)},
                        child: const Text('/', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 15,
                    column: 1,
                    row: 4,
                    columnSpan: 3,
                    child: TextButton(
                        style: buttonDigitsStyle,
                        onPressed: () => {registerNumber(0)},
                        child: const Text('0', style: textStyleButtons))),
                SpannableGridCellData(
                    id: 16,
                    column: 4,
                    row: 4,
                    columnSpan: 2,
                    child: TextButton(
                        style: buttonOthersStyle,
                        onPressed: () => {showResult(true)},
                        child: const Text('=', style: textStyleButtons)))
              ],
            ),
          )
          // Row(mainAxisSize: MainAxisSize.min,children: [
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(7)},
          //       child: const Text('7', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(8)},
          //       child: const Text('8', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(9)},
          //       child: const Text('9', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {deleteDigit()},
          //       child: const Text("DEL", style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {clearFunction()},
          //       child: Text(clearButtonText, style: textStyleButtons)),
          // ]),
          // Row(mainAxisSize: MainAxisSize.min,children: [
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(4)},
          //       child: const Text('4', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(5)},
          //       child: const Text('5', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(6)},
          //       child: const Text('6', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {addOperator(Operations.addition)},
          //       child: const Text('+', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {addOperator(Operations.subtraction)},
          //       child: const Text('-', style: textStyleButtons))
          // ]),
          // Row(mainAxisSize: MainAxisSize.min,children: [
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(1)},
          //       child: const Text('1', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(2)},
          //       child: const Text('2', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {registerNumber(3)},
          //       child: const Text('3', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {addOperator(Operations.multiplication)},
          //       child: const Text('x', style: textStyleButtons)),
          //   TextButton(
          //       style: buttonStyle,
          //       onPressed: () => {addOperator(Operations.division)},
          //       child: const Text('/', style: textStyleButtons))
          // ]),
          // Row(mainAxisSize: MainAxisSize.min,children: [
          //   Expanded(child: Padding(
          //       padding: const EdgeInsets.only(left: 56.0),
          //       child: TextButton(
          //           style: buttonStyle,
          //           onPressed: () => {registerNumber(0)},
          //           child: const Text('0', style: textStyleButtons)))),
          //   Padding(
          //       padding: const EdgeInsets.only(left: 112.0),
          //       child: TextButton(
          //           style: buttonStyle,
          //           onPressed: () => {showResult(true)},
          //           child: const Text('=', style: textStyleButtons)))
          // ])
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
