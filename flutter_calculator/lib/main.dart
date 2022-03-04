// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new Calculator()));
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CalculatorState();

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Calculator',
  //     home:
  //       // body: GridView.count(
  //       //     crossAxisCount: 3,
  //       //     children: List.generate(10, (index) {
  //       //       return TextButton(
  //       //           onPressed: () =>
  //       //               {registerNumber(index==9?0:(3 - index ~/ 3) * 3 - 2 + index % 3)},
  //       //           child: Text(
  //       //               (index==9?0:(3 - index ~/ 3) * 3 - 2 + index % 3).toString()));
  //       //     }))

  //       // new Center(
  //       //   child: TextButton(onPressed: () => {registerNumber(1)}, child: Text('1')),
  //       // ),
  //     ),
  //   );
  // }

}

class _CalculatorState extends State<Calculator> {
  late TextEditingController displayController;
  @override
  void initState() {displayController=TextEditingController();
  displayController.text="0";}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calculator'),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(controller: displayController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                readOnly: true),
          ),
          Row(children: [
            TextButton(onPressed: () => {registerNumber(7)}, child: Text('7')),
            TextButton(onPressed: () => {registerNumber(8)}, child: Text('8')),
            TextButton(onPressed: () => {registerNumber(9)}, child: Text('9'))
          ]),
          Row(children: [
            TextButton(onPressed: () => {registerNumber(4)}, child: Text('4')),
            TextButton(onPressed: () => {registerNumber(5)}, child: Text('5')),
            TextButton(onPressed: () => {registerNumber(6)}, child: Text('6'))
          ]),
          Row(children: [
            TextButton(onPressed: () => {registerNumber(1)}, child: Text('1')),
            TextButton(onPressed: () => {registerNumber(2)}, child: Text('2')),
            TextButton(onPressed: () => {registerNumber(3)}, child: Text('3'))
          ]),
          Row(children: [
            TextButton(
                onPressed: () => {clearNumber()}, child: Text("AC")),
            TextButton(onPressed: () => {registerNumber(0)}, child: Text('0'))
          ])
        ]));
  }

  void registerNumber(int number) {
    var text=displayController.text.split(" ").join("");
    var displayNumber=int.parse(text)*10+number;
    displayController.text=beautifyNumber(displayNumber);
  }

  void clearNumber(){
    displayController.text="0";
  }

  String beautifyNumber(int number){
    var numberTextCharArray=number.toString().characters.toList();
    var index=3;
    while (index<numberTextCharArray.length){
      numberTextCharArray.insert(index, ' ');
      index+=4;
    }
    return numberTextCharArray.join("");
  }
}
