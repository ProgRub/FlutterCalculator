import 'package:flutter/material.dart';
import 'operations.dart';

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late TextEditingController displayNumbersController,
      displayOperationController;
  @override
  void initState() {
    displayNumbersController = TextEditingController();
    displayNumbersController.text = "0";
    displayOperationController = TextEditingController();
    displayOperationController.text = "";
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
                onPressed: () => {clearNumber()}, child: const Text("DEL")),
            TextButton(
                onPressed: () => {clearNumber()}, child: const Text("AC")),
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
                child: const Text('X')),
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
                    onPressed: () => {clearNumber()}, child: const Text('=')))
          ])
        ]));
  }

  void registerNumber(int number) {
    var text = displayNumbersController.text.split(" ").join("");
    var displayNumber = int.parse(text) * 10 + number;
    displayNumbersController.text = beautifyNumber(displayNumber);
  }

  void clearNumber() {
    displayNumbersController.text = "0";
  }

  String beautifyNumber(int number) {
    var numberTextCharArray = number.toString().characters.toList();
    var index = 3;
    while (index < numberTextCharArray.length) {
      numberTextCharArray.insert(index, ' ');
      index += 4;
    }
    return numberTextCharArray.join("");
  }

  void addOperator(Operations operation) {}
}
