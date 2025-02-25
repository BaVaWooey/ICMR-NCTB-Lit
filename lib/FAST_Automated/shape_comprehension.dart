import 'package:flutter/material.dart';
import 'imports.dart';

class FASTShapeComprehension extends StatefulWidget {
  const FASTShapeComprehension({super.key});

  @override
  State<FASTShapeComprehension> createState() => _FASTShapeComprehensionState();
}

class _FASTShapeComprehensionState extends State<FASTShapeComprehension> {
  ////definition of variables
  List<double> temp_list_first = [],
      temp_temp_list_second = [],
      temp_temp_list_third = [];
  List<List<double>> first_inputs = [],
      temp_list_second = [],
      temp_list_third = [];
  List<List<List<double>>> second_inputs = [], third_inputs = [];
  List<bool> loop_interrupted = [false, false, false, false, false, false];
  int numberOfReplays = 3,
      replays_total = 3,
      timerLeftForIns = 15,
      numberOfTaps = 1,
      instructionNumber = 0,
      timerStart = 5;
  bool instructionStating = false,
      testStarted = false,
      testComplete = false,
      previous_loop_interrupted = false;

  ////definition of functions
  @override
  void initState() {
    replays_total = 3;
    numberOfReplays = 3;
    timerLeftForIns = 15;
    numberOfTaps = 1;
    instructionStating = false;
    testStarted = false;
    super.initState();
    timerStartFunction();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void stateInstruction() async {
    ///what is very important is that when an instruction is being stated, everything must be greyed out.
    ///This includes the image and the buttons.
    setState(() {
      instructionStating = true;
    });
    debugPrint("First");
    await player.setAsset(shapeOutputAudio[instructionNumber]);
    await player.play();
    if (instructionNumber != 0) {
      await Future.delayed(
          Duration(milliseconds: shapeOutputAudioDuration[instructionNumber]));
    }
    debugPrint("Second");
    //this is where the instruction will be stated
    setState(() {
      debugPrint('$instructionNumber');
      debugPrint("This has been entred");
      instructionStating = false;
    });
  }

  ///timer for the first clock
  void timerStartFunction() async {
    while (timerStart > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timerStart -= 1;
      });
    }
    setState(() {
      testStarted = true;
      debugPrint("This marks the start of the test.");
    });

    ///here we will state the instruction
    stateInstruction();

    ///we will start the timer as well
    timerInstructionFunction(instructionNumber);
  }

  void timerInstructionFunction(insNumber) async {
    debugPrint("This starts everytime an instruction is being stated.");

    ///the timer function isn't properly working when this is being done
    setState(() {
      debugPrint("This has been entered.");
      previous_loop_interrupted = false;
      timerLeftForIns = 15;
    });
    while (timerLeftForIns > 0) {
      if (loop_interrupted[insNumber] == true) {
        debugPrint("This has been broken $insNumber");
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timerLeftForIns -= 1;
      });
    }
    if (loop_interrupted[insNumber] == false) {
      //push the results into the final list
      first_inputs.add(temp_list_first);
      second_inputs.add(temp_list_second);

      ///once this is complete, we will have to set the reset variables function
      resetVariables();
    }
  }

  ///this is for resetting all the variables once again
  void resetVariables() async {
    setState(() {
      instructionNumber += 1;
      if (instructionNumber < 5) {
        timerLeftForIns = 15;
        replays_total = 3;
        if (instructionNumber == 0 || instructionNumber == 1) {
          numberOfTaps = 1;
        } else if (instructionNumber == 2 || instructionNumber == 4) {
          numberOfTaps = 2;
        } else {
          numberOfTaps = 3;
        }
      }
    });
    if (instructionNumber < 5) {
      ///state the instruction here
      stateInstruction();
      debugPrint("This has been entered - checker ");
      while (instructionStating == true) {
        ///we will put an awaiting function here
        await Future.delayed(const Duration(milliseconds: 500));
      }

      ///the timer will start going off here as well
      timerInstructionFunction(instructionNumber);
    } else {
      ///here we will set state the test complete to true
      setState(() {
        testComplete = true;
      });
    }
  }

  ///definition of the return scaffold widget
  @override
  Widget build(BuildContext context) {
    //this is for what exactly?
    return Scaffold(
        body: testStarted == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    const Center(
                        child: Text("Test will start in",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold))),
                    Center(
                        child: Text("$timerStart",
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)))
                  ])
            : testComplete == true
                ? const Center(
                    child: Text("Test Complete.",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold)))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        ///the first will be a column that has all the elements stored in a column
                        Container(
                          width: 150,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ////Replay checking
                                    Center(
                                        child: TextButton.icon(
                                            style: ButtonStyle(
                                              backgroundColor: (testStarted ==
                                                      false)
                                                  ? MaterialStatePropertyAll<
                                                          Color>(
                                                      Colors.red.shade100)
                                                  : testComplete == true
                                                      ? MaterialStatePropertyAll<
                                                              Color>(
                                                          Colors.green.shade100)
                                                      : instructionStating ==
                                                              true
                                                          ? MaterialStatePropertyAll<
                                                                  Color>(
                                                              Colors.grey
                                                                  .shade100)
                                                          : MaterialStatePropertyAll<
                                                                  Color>(
                                                              Colors.amber
                                                                  .shade100),
                                            ),
                                            onPressed: () => {
                                                  debugPrint(
                                                      "The initial replay option entered"),
                                                  debugPrint('$replays_total'),
                                                  if (instructionStating ==
                                                          false &&
                                                      replays_total > 0)
                                                    {
                                                      debugPrint(
                                                          "replay option entered"),

                                                      ///here we give them the opportunity to state the inst
                                                      setState(() {
                                                        timerLeftForIns = 15;
                                                        replays_total -= 1;
                                                        if (instructionNumber ==
                                                                0 ||
                                                            instructionNumber ==
                                                                1) {
                                                          numberOfTaps = 1;
                                                        } else if (instructionNumber ==
                                                                2 ||
                                                            instructionNumber ==
                                                                4) {
                                                          numberOfTaps = 2;
                                                        } else {
                                                          numberOfTaps = 3;
                                                        }
                                                      }),
                                                      stateInstruction()
                                                    }

                                                  ///replay function whenever the code is running
                                                },
                                            icon: (testStarted == false)
                                                ? const Icon(Icons.close,
                                                    color: Colors.red, size: 25)
                                                : testComplete == true
                                                    ? const Icon(
                                                        Icons.thumb_up_sharp,
                                                        color: Colors.green,
                                                        size: 25)
                                                    : instructionStating == true
                                                        ? const Icon(
                                                            Icons.back_hand,
                                                            color: Colors.grey,
                                                            size: 25)
                                                        : Icon(Icons.replay,
                                                            color: Colors.amber
                                                                .shade800),
                                            label: testStarted == false
                                                ? const Text("Wait",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 25))
                                                : testComplete == true
                                                    ? const Text("Complete",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 25))
                                                    : instructionStating == true
                                                        ? const Text("Listen",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 25))
                                                        : const Text("Replay",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    25)))),

                                    ///Submit option button

                                    ////Number of taps
                                    Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: testComplete == true
                                                ? const Center(
                                                    child: Text(
                                                        "Test Completed!",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.green)))
                                                : instructionStating == true
                                                    ? Center(
                                                        child: Text(
                                                            "Instruction is being stated",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800)))
                                                    : Text(
                                                        'Number of taps left - $numberOfTaps',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                    Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: testComplete == true
                                                ? const Center(
                                                    child: Text(
                                                        "Test Completed!",
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Colors.green)))
                                                : instructionStating == true
                                                    ? Center(
                                                        child: Text(
                                                            "Instruction is being stated",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800)))
                                                    : Text(
                                                        "Number of replays left - $replays_total",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)))),
                                    ////Timer at the very bottom
                                    Center(

                                        ///we will have the indication of two timers
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                          Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Center(
                                                  child: timerStart > 0
                                                      ? const Text(
                                                          "The test will start in - ",
                                                          style: TextStyle(
                                                              fontSize: 25))
                                                      : testComplete == true
                                                          ? const Center(
                                                              child: Text(
                                                                  "Test is complete",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          25,
                                                                      color: Colors
                                                                          .green,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)))
                                                          : const Text(
                                                              "Time left - ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      25)))),
                                          Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: instructionStating == true &&
                                                      replays_total == 3
                                                  ? Center(
                                                      child: Text(
                                                          "Instruction is being stated",
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              color: Colors.grey
                                                                  .shade800)))
                                                  : testComplete == true
                                                      ? const Center(
                                                          child: Text(
                                                              "Test is complete",
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .green,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)))
                                                      : Center(
                                                          child: CircularProgressIndicator(
                                                              value: timerStart > 0
                                                                  ? timerStart / 5
                                                                  : timerLeftForIns / 15) //here we will have the timer
                                                          )),
                                          Center(
                                              child: TextButton.icon(
                                                  style: ButtonStyle(
                                                    backgroundColor: (testStarted ==
                                                            false)
                                                        ? MaterialStatePropertyAll<
                                                                Color>(
                                                            Colors.red.shade100)
                                                        : testComplete == true
                                                            ? MaterialStatePropertyAll<
                                                                    Color>(
                                                                Colors.green
                                                                    .shade100)
                                                            : instructionStating ==
                                                                    true
                                                                ? MaterialStatePropertyAll<
                                                                        Color>(
                                                                    Colors.grey
                                                                        .shade100)
                                                                : MaterialStatePropertyAll<
                                                                        Color>(
                                                                    Colors.green
                                                                        .shade100),
                                                  ),
                                                  onPressed: () => {
                                                        if (numberOfTaps == 0 &&
                                                            instructionNumber <
                                                                5)
                                                          {
                                                            first_inputs.add(
                                                                temp_list_first),
                                                            second_inputs.add(
                                                                temp_list_second),
                                                            loop_interrupted[
                                                                    instructionNumber] =
                                                                true,
                                                            resetVariables()
                                                          }

                                                        ///this is for submitting the final responses
                                                      },
                                                  icon: (testStarted == false)
                                                      ? const Icon(Icons.close,
                                                          color: Colors.red,
                                                          size: 25)
                                                      : testComplete == true
                                                          ? const Icon(Icons.thumb_up_sharp,
                                                              color:
                                                                  Colors.green,
                                                              size: 25)
                                                          : instructionStating ==
                                                                  true
                                                              ? Icon(Icons.stop,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                  size: 25)
                                                              : const Icon(
                                                                  Icons.check,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 25),
                                                  label: (testStarted == false)
                                                      ? const Text(
                                                          "Not available",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 25))
                                                      : testComplete == true
                                                          ? const Text(
                                                              "Complete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 25))
                                                          : instructionStating ==
                                                                  true
                                                              ? Text("Listen",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                      fontSize:
                                                                          25))
                                                              : const Text("Submit", style: TextStyle(color: Colors.green, fontSize: 25)))),
                                        ]))
                                  ])),
                        ),
                        GestureDetector(
                          child: testStarted == false
                              ? const Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text("Test hasn't started yet.",
                                          style: TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold))),
                                )
                              : instructionStating == true
                                  ? Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      child: Opacity(
                                          opacity: 0.5,
                                          child: Image.asset(
                                              'assets/shapes.png',
                                              fit: BoxFit.fill)),
                                    )
                                  : testComplete == true
                                      ? const Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Text("Test is completed.",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 50))))
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: Image.asset(
                                              'assets/shapes.png',
                                              fit: BoxFit.fill)),
                          onTapDown: (details) => {
                            ///reduce tap count
                            if (numberOfTaps > 0)
                              {
                                numberOfTaps -= 1,
                                if (instructionNumber == 0 ||
                                    instructionNumber == 1)
                                  {
                                    ///here we will push the points once, and we will push that into the final list upon submitting
                                    temp_list_first.clear(),
                                    temp_list_first
                                        .add(details.globalPosition.dx),
                                    temp_list_first
                                        .add(details.globalPosition.dy)
                                  }
                                else if (instructionNumber == 2 ||
                                    instructionNumber == 4)
                                  {
                                    ///in this case, we will just clear and add
                                    if (numberOfTaps == 2)
                                      {
                                        ///here we will have to clear the initial temp list
                                        temp_list_second.clear()
                                      },
                                    temp_temp_list_second.clear(),
                                    temp_temp_list_second
                                        .add(details.globalPosition.dx),
                                    temp_temp_list_second
                                        .add(details.globalPosition.dy),
                                    temp_list_second.add(temp_temp_list_second)
                                  }
                                else
                                  {
                                    if (numberOfTaps == 3)
                                      {temp_list_third.clear()},
                                    temp_temp_list_third.clear(),
                                    temp_temp_list_third
                                        .add(details.globalPosition.dx),
                                    temp_temp_list_third
                                        .add(details.globalPosition.dy),
                                    temp_list_third.add(temp_temp_list_third)
                                  }

                                ///second, we will push the values into a temporary list depending on the type of question (1 tap or 2 tap)
                              }
                          },
                        ),
                      ]),
        floatingActionButton: Visibility(
            visible: testComplete,
            child: FloatingActionButton.extended(
                label: const Text('Next'),
                onPressed: () => {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]),

                      ///we will need to push to the instruction screen of the next test
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FASTShapeComprehensionInstructions()))
                    },
                icon: const Icon(Icons.arrow_forward))));
  }
}
///0, 1 - one tap, 2, 4 - 2 tap, 3 - 3 tap 
