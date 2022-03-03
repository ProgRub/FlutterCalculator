// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Calculator'),
        ),
        body: GridView.count(crossAxisCount: 3,children:List.generate(9, (index)  {return TextButton(onPressed: () => {registerNumber(index)}, child: Text(index.toString()));}))

        // new Center(
        //   child: TextButton(onPressed: () => {registerNumber(1)}, child: Text('1')),
        // ),
      ),
    );
  }

  void registerNumber(int number){
    print(number);
  }
}