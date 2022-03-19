import 'package:flutter/material.dart';
import 'package:flutter_calculator/calculator.dart';

class CalcsHistory extends StatefulWidget {
  late List<String> history;
  CalcsHistory(List<String> history) {
    this.history = history;
  }
  @override
  State<StatefulWidget> createState() => _CalcsHistoryState(history);
}

class _CalcsHistoryState extends State<CalcsHistory> {
  final ScrollController _controller = ScrollController();
  late List<String> history;

  _CalcsHistoryState(List<String> history) {
    this.history = history;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Calculator'),
      ),
      body: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Expanded(
            child: Scrollbar(
                isAlwaysShown: true,
                controller: _controller,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  controller: _controller,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext, index) {
                    // Show your info
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(history[index]),
                    );
                  },
                  itemCount: history.length,
                  scrollDirection: Axis.vertical,
                )),
          )
        ],
      ),
    );
  }
}
