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
  static const Color blueAccent = Color.fromARGB(255, 0, 84, 174);
  static const Color greenAccent = Color.fromARGB(255, 12, 131, 2);
  static const Color redAccent = Color.fromARGB(255, 131, 2, 2);
  late Color selectedAccent = blueAccent;

  _CalcsHistoryState(this.history);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(Icons.arrow_back),
                  color: selectedAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedAccent = blueAccent;
                    });
                  },
                  child: const Text(""),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    primary: blueAccent, // <-- Button color
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedAccent = greenAccent;
                    });
                  },
                  child: const Text(""),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    primary: greenAccent, // <-- Button color
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedAccent = redAccent;
                    });
                  },
                  child: const Text(""),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    primary: redAccent, // <-- Button color
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(
                children: [
                  Scrollbar(
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
                            child: Text(
                              history[index],
                              style: TextStyle(
                                  color: selectedAccent, fontSize: 20.0),
                            ),
                          );
                        },
                        itemCount: history.length,
                        scrollDirection: Axis.vertical,
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
