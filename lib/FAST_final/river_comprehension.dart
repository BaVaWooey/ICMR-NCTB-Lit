import 'package:flutter/material.dart';
import 'imports.dart';

class FASTRiverComprehension extends StatefulWidget {
  const FASTRiverComprehension({super.key});

  @override
  State<FASTRiverComprehension> createState() => _FASTRiverComprehensionState();
}

class _FASTRiverComprehensionState extends State<FASTRiverComprehension> {
  ////definition of variables

  int numberOfReplays = 3,
      timerLeftForIns = 15,
      numberOfTaps = 1,
      timerStart = 5;
  bool instructionStating = false, testStarted = false, testComplete = false;

  ////definition of functions
  @override
  void initState() {
    numberOfReplays = 3;
    timerLeftForIns = 15;
    numberOfTaps = 1;
    instructionStating = false;
    testStarted = false;
    super.initState();
  }

  void stateInstruction() async {
    ///what is very important is that when an instruction is being stated, everything must be greyed out.
    ///This includes the image and the buttons.
    setState(() {
      instructionStating = true;
    });

    setState(() {
      instructionStating = false;
    });
  }

  ///definition of the return scaffold widget
  @override
  Widget build(BuildContext context) {
    //this is for what exactly?
    return Scaffold(
        body: Row(children: [
      ///the first will be a column that has all the elements stored in a column
      Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          child: Column(children: [
            ////Replay button
            Center(
                child: TextButton.icon(
                    onPressed: () => {
                      ///this is for the replay function 
                    },
                    icon: (testStarted == false || testComplete == true)
                        ? const Icon(Icons.close, color: Colors.red)
                        : instructionStating == true
                            ? const Icon(Icons.back_hand, color: Colors.grey)
                            : const Icon(Icons.replay, color: Colors.amber),
                    label: testStarted == false
                        ? const Text("Wait",
                            style: TextStyle(color: Colors.red))
                        : testComplete == true
                            ? const Text("Complete",
                                style: TextStyle(color: Colors.red))
                            : instructionStating == true
                                ? const Text("Listen",
                                    style: TextStyle(color: Colors.black))
                                : const Text("Replay",
                                    style: TextStyle(color: Colors.black)))),

            ///Submit option button
            Center(child: TextButton.icon(onPressed: () => {
              ///this is for the submitting function 
            },
            icon: (testStarted == false || testComplete == true) ? const Icon(Icons.close, color: Colors.red): instructionStating == true ? Icon(Icons.back_hand, color: Colors.grey.shade600) : const Icon(Icons.check, color: Colors.green),
            label : (testStarted == false || testComplete == true) ? const Text("Not available", style: TextStyle(color: Colors.red)) : instructionStating == true ? Text("Listen", style: TextStyle(color: Colors.grey.shade600)) : const Text("Submit", style: TextStyle(color: Colors.greens))))
            ////Number of taps
            ////Timer at the very bottom
          ])),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: GestureDetector(
            child: Image.asset('assets/river.png'),
            onTapDown: (details) => {
              ///we will do something here.
            },
          ))
    ]));
  }
}
