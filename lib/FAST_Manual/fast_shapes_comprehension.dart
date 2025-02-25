import 'imports.dart';
import '../screen/screens.dart';

///we will need a screen to display the instructions of the first part of the test
class FASTManualShapesComprehension extends StatefulWidget {
  const FASTManualShapesComprehension({super.key});

  @override
  State<FASTManualShapesComprehension> createState() =>
      _FASTManualShapesComprehensionState();
}

class _FASTManualShapesComprehensionState
    extends State<FASTManualShapesComprehension> {
  int finalScore = 0,
      timerStart = 5,
      instructionNumber = 0,
      numberOfReplays = 3,
      numberOfTaps = 1;
  bool instructionStated = false,
      testComplete = false,
      arrow = false,
      squareFirst = false,
      squareSecond = false,
      cone = false,
      semi = false,
      hill = false,
      halfMoon = false;
  @override
  ////INIT FUNCTION
  ////
  void initState() {
    timerStart = 5;
    instructionNumber = 0;
    instructionStated = false;
    testComplete = false;
    numberOfReplays = 3;
    numberOfTaps = 1;
    super.initState();
    testStartTimer();
  }

  ////FUNCTION FOR COUNTING DOWN IN THE TEST.
  void testStartTimer() async {
    while (timerStart > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timerStart -= 1;
      });
    }
    stateInstruction();
  }

  void setTaps() {
    if (instructionNumber == 0 || instructionNumber == 1) {
      setState(() {
        numberOfTaps = 1;
      });
    } else if (instructionNumber == 3) {
      numberOfTaps = 3;
    } else {
      numberOfTaps = 2;
    }
  }

  void stateInstruction() async {
    setState(() {
      instructionStated = true;
    });
    ////THIS IS FOR STATING THE INSTRUCTION.
    ///ALL FUNCTIONS MUST FREEZE AT THIS POINT.
    await player.setAsset(shapeOutputAudio[instructionNumber]);
    await player.play();
    if (instructionNumber != 0) {
      await Future.delayed(
          Duration(milliseconds: shapeOutputAudioDuration[instructionNumber]));
    }

    ////SET INSTRUCTION STATED == FALSE
    setState(() {
      instructionStated = false;
    });
  }

  void resetValues() {
    ////RESETTING VALUES.
    ////IF INS NUMBER = 0 || 1, WE SET TAPS TO 1 and RESET to 3.
    ///ELSE, TAPS to 2 and RESET to 3.
    ///IF INS NUM == 5 WE SET TEST COMPLETE TO TRUE.
    setState(() {
      instructionNumber += 1;
      if (instructionNumber == 0 || instructionNumber == 1) {
        numberOfTaps = 1;
      } else if (instructionNumber == 2 || instructionNumber == 4) {
        numberOfTaps = 2;
      } else if (instructionNumber == 3) {
        numberOfTaps = 3;
      } else {
        testComplete = true;
      }
      numberOfReplays = 3;
    });
    if (instructionNumber < 5) stateInstruction();
  }

  void checkSingleTap(x, y) {
    debugPrint("$instructionNumber");
    debugPrint("$x $y");
    if (x >=
            shapeComprehensionCheckingOneTap[instructionNumber == 0 ? 0 : 1][0]
                [0] &&
        x <=
            shapeComprehensionCheckingOneTap[instructionNumber == 0 ? 0 : 1][1]
                [0] &&
        y >=
            shapeComprehensionCheckingOneTap[instructionNumber == 0 ? 0 : 1][0]
                [1] &&
        y <=
            shapeComprehensionCheckingOneTap[instructionNumber == 0 ? 0 : 1][1]
                [1]) {
      setState(() {
        finalScore += 1;
        fastComprehensionRightTap += 1;
      });
      debugPrint("Correct tap.");
    } else {
      setState(() {
        fastComprehensionWrongTap += 1;
      });
      debugPrint("Wrong tap.");
    }
  }

  void checkDoubleTap(x, y, numberValue) {
    if (instructionNumber == 2) {
      debugPrint("entered");
      if (numberValue == 2) {
        ///second tap
        if (x >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][0][0]
                    [0] &&
            x <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][0][1]
                    [0] &&
            y >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][0][0]
                    [1] &&
            y <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][0][1]
                    [1]) {
          debugPrint("Correct Tap");
          setState(() {
            arrow = true;
            fastComprehensionRightTap += 1;
          });
        } else {
          setState(() {
            fastComprehensionWrongTap += 1;
          });
          debugPrint("Wrong Tap");
        }
      } else if (numberValue == 1) {
        if (x >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][1][0]
                    [0] &&
            x <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][1][1]
                    [0] &&
            y >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][1][0]
                    [1] &&
            y <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 2][1][1]
                    [1]) {
          debugPrint("Correct tap");
          setState(() {
            squareFirst = true;
            fastComprehensionRightTap += 1;
          });
        } else {
          setState(() {
            fastComprehensionWrongTap += 1;
          });
          debugPrint("Wrong tap");
        }
        //first tap
      }
    } else {
      if (numberValue == 2) {
        ///second tap
        if (x >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][0][0]
                    [0] &&
            x <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][0][1]
                    [0] &&
            y >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][0][0]
                    [1] &&
            y <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][0][1]
                    [1]) {
          debugPrint("Correct Tap");
          setState(() {
            hill = true;
            fastComprehensionRightTap += 1;
          });
        } else {
          setState(() {
            fastComprehensionWrongTap += 1;
          });
          debugPrint("Wrong Tap");
        }
      } else if (numberValue == 1) {
        if (x >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][1][0]
                    [0] &&
            x <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][1][1]
                    [0] &&
            y >=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][1][0]
                    [1] &&
            y <=
                shapeComprehensionCheckingDoubleTap[instructionNumber - 3][1][1]
                    [1]) {
          debugPrint("Correct tap");
          setState(() {
            halfMoon = true;
            fastComprehensionRightTap += 1;
          });
        } else {
          setState(() {
            fastComprehensionWrongTap += 1;
          });
          debugPrint("Wrong tap");
        }
        //first tap
      }
    }
    return;
  }

  void checkTripleTap(x, y, value) {
    debugPrint("$value");
    if (x >= shapeComprehensionCheckingTripleTap[0][value][0][0] &&
        x <= shapeComprehensionCheckingTripleTap[0][value][1][0] &&
        y >= shapeComprehensionCheckingTripleTap[0][value][0][1] &&
        y <= shapeComprehensionCheckingTripleTap[0][value][1][1]) {
      debugPrint("Correct tap");
      setState(() {
        if (squareSecond == false) {
          squareSecond = true;
        } else if (cone == false) {
          cone = true;
        } else {
          semi = true;
        }
        fastComprehensionRightTap += 1;
      });
    } else {
      setState(() {
        fastComprehensionWrongTap += 1;
      });
      debugPrint("Wrong tap");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: timerStart > 0
          ? Center(
              child: Text('Test starts in $timerStart',
                  style: const TextStyle(
                      fontSize: 45, fontWeight: FontWeight.bold)))
          : testComplete == true
              ? const Center(
                  child: Text('Test Complete',
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold)))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      /////
                      ///ADDING COLUMN FOR BUTTONS AND REPLAY DETAILS.
                      Container(
                        width: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ///BUTTON FOR REPLAYING
                              Center(
                                  child: TextButton.icon(
                                      ////CONDITIONS FOR ICON
                                      ///IF INSTRUCTION BEING STATED = GREY, ICON = STOP, TEXT = LISTEN
                                      ///ELSE = AMBER, ICON = REPLAY, TEXT = REPLAY
                                      style: ButtonStyle(
                                          backgroundColor: numberOfReplays == 0
                                              ? MaterialStatePropertyAll<Color>(
                                                  Colors.redAccent.shade100)
                                              : instructionStated == true
                                                  ? MaterialStatePropertyAll<Color>(
                                                      Colors.grey.shade100)
                                                  : MaterialStatePropertyAll<Color>(
                                                      Colors.amberAccent
                                                          .shade100)),
                                      icon: numberOfReplays == 0
                                          ? const Icon(Icons.close,
                                              color: Colors.red)
                                          : instructionStated == true
                                              ? const Icon(Icons.stop,
                                                  color: Colors.grey)
                                              : const Icon(Icons.replay,
                                                  color: Colors.black),
                                      label: numberOfReplays == 0
                                          ? const Text("Replays exhausted",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20))
                                          : instructionStated == true
                                              ? const Text("Listen",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 20))
                                              : const Text("Replay",
                                                  style: TextStyle(color: Colors.black, fontSize: 20)),
                                      onPressed: () => {
                                            ///CHECKING REPLAY CONDITION.
                                            if (numberOfReplays > 0 &&
                                                instructionStated == false &&
                                                instructionNumber < 5)
                                              {
                                                setState(() {
                                                  numberOfReplays -= 1;
                                                }),
                                                stateInstruction(),
                                                setTaps(),
                                              }
                                          })),

                              ///NUMBER OF REPLAYS LEFT.
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text(
                                          "Number of replays left - $numberOfReplays",
                                          style:
                                              const TextStyle(fontSize: 20)))),

                              ///NUMBER OF TAPS LEFT.
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                      child: Text(
                                          "Number of taps left - $numberOfTaps",
                                          style:
                                              const TextStyle(fontSize: 20)))),

                              ///SUBMITTING/MOVING TO THE NEXT INSTRUCTION.
                              Center(
                                  child: TextButton.icon(
                                      ////CONDITIONS FOR ICON
                                      ///IF INSTRUCTION BEING STATED = GREY, ICON = STOP, TEXT = LISTEN
                                      ///ELSE = AMBER, ICON = REPLAY, TEXT = REPLAY
                                      style: ButtonStyle(
                                          backgroundColor: numberOfTaps > 0
                                              ? MaterialStatePropertyAll<Color>(
                                                  Colors.redAccent.shade100)
                                              : instructionStated == true
                                                  ? MaterialStatePropertyAll<Color>(
                                                      Colors.grey.shade100)
                                                  : MaterialStatePropertyAll<Color>(
                                                      Colors.greenAccent
                                                          .shade100)),
                                      icon: numberOfTaps > 0
                                          ? const Icon(Icons.close,
                                              color: Colors.red)
                                          : instructionStated == true
                                              ? const Icon(Icons.stop,
                                                  color: Colors.grey)
                                              : const Icon(Icons.arrow_forward,
                                                  color: Colors.green),
                                      label: numberOfTaps > 0
                                          ? const Text("Complete the taps",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20))
                                          : instructionStated == true
                                              ? const Text("Listen",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 20))
                                              : const Text("Next Instruction",
                                                  style: TextStyle(color: Colors.green, fontSize: 20)),
                                      onPressed: () => {
                                            ///CHECKING TAPPING CONDITION
                                            if (numberOfTaps == 0 &&
                                                instructionStated == false &&
                                                instructionNumber < 5)
                                              {
                                                ///THEN WE PROCEED TO THE NEXT INSTRUCTION.
                                                resetValues()
                                              }
                                          }))
                            ]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: GestureDetector(
                            child: Image.asset('assets/shapes.png',
                                fit: BoxFit.fill),
                            onTapDown: (details) => {
                                  debugPrint(
                                      '${details.globalPosition.dx} ${details.globalPosition.dy}'),
                                  if (numberOfTaps > 0)
                                    {
                                      setState(() {
                                        if (instructionNumber == 0 ||
                                            instructionNumber == 1) {
                                          checkSingleTap(
                                              details.globalPosition.dy,
                                              details.globalPosition.dx);
                                        } else if (instructionNumber == 2 ||
                                            instructionNumber == 4) {
                                          checkDoubleTap(
                                              details.globalPosition.dy,
                                              details.globalPosition.dx,
                                              numberOfTaps);
                                        } else {
                                          checkTripleTap(
                                              details.globalPosition.dy,
                                              details.globalPosition.dx,
                                              3 - numberOfTaps);
                                        }
                                        numberOfTaps -= 1;
                                      })
                                    }
                                }),
                      ),
                    ]),
      floatingActionButton: Visibility(
          visible: testComplete,
          child: FloatingActionButton.extended(
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Next"),
              onPressed: () => {
                    debugPrint("Hello"),
                    setState(() {
                      finalScore += (arrow && squareFirst) ? 1 : 0;
                      debugPrint(finalScore.toString());
                      finalScore += (squareSecond && cone && semi) ? 1 : 0;
                      debugPrint(finalScore.toString());
                      finalScore += (hill && halfMoon) ? 1 : 0;
                      debugPrint(finalScore.toString());
                      fastComprehensionShapeScore = finalScore;
                    }),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FASTManualExpressionInstructions()))
                  })),
    );
  }
}
