import 'imports.dart';
import '../screen/screens.dart';

///we will need a screen to display the instructions of the first part of the test
class FASTManualRiverComprehension extends StatefulWidget {
  const FASTManualRiverComprehension({super.key});

  @override
  State<FASTManualRiverComprehension> createState() =>
      _FASTManualRiverComprehensionState();
}

class _FASTManualRiverComprehensionState
    extends State<FASTManualRiverComprehension> {
  int timerStart = 5,
      instructionNumber = 0,
      numberOfReplays = 3,
      numberOfTaps = 1 * 4;
  bool instructionStated = false, testComplete = false;
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
    await player.setAsset(riverOutputAudio[instructionNumber]);
    await player.play();
    if (instructionNumber != 0) {
      await Future.delayed(
          Duration(milliseconds: riverOutputAudioDuration[instructionNumber]));
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
      } else if (instructionNumber >= 2 && instructionNumber <= 4) {
        numberOfTaps = 2;
      } else {
        testComplete = true;
      }
      numberOfReplays = 3;
    });
    if (instructionNumber < 5) stateInstruction();
  }

  void checkOutputSingleTap(x, y) {
    debugPrint(" ");
    debugPrint("Instruction Number ${instructionNumber + 1}");
    debugPrint(" ");
    if (x >= riverComprehensionCheckingOneTap[instructionNumber][0][0] &&
        x <= riverComprehensionCheckingOneTap[instructionNumber][1][0] &&
        y >= riverComprehensionCheckingOneTap[instructionNumber][0][1] &&
        y <= riverComprehensionCheckingOneTap[instructionNumber][1][1]) {
      setState(() {
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

  void checkOutputDoubleTap(x, y, numberValue) {
    debugPrint(" ");
    debugPrint("Instruction Number ${instructionNumber + 1}");
    debugPrint(" ");
    if (numberValue == 1) {
      ///second tap
      if (x >=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][0][0]
                  [0] &&
          x <=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][0][1]
                  [0] &&
          y >=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][0][0]
                  [1] &&
          y <=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][0][1]
                  [1]) {
        debugPrint("Correct Tap");
        setState(() {
          fastComprehensionRightTap += 1;
        });
      } else {
        setState(() {
          fastComprehensionWrongTap += 1;
        });
        debugPrint("Wrong Tap");
      }
    } else if (numberValue == 0) {
      if (x >=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][1][0]
                  [0] &&
          x <=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][1][1]
                  [0] &&
          y >=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][1][0]
                  [1] &&
          y <=
              riverComprehensionCheckingDoubleTap[instructionNumber - 2][1][1]
                  [1]) {
        debugPrint("Correct tap");
        setState(() {
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
                                              : const Text("Replay instruction",
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
                                              : const Text("Next instruction",
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
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: Image.asset('assets/river.png',
                                  fit: BoxFit.fill),
                            ),
                            onTapDown: (details) => {
                                  if (numberOfTaps > 0)
                                    {
                                      setState(() {
                                        numberOfTaps -= 1;
                                      }),
                                      debugPrint(
                                          'x - coordinate ${details.globalPosition.dx}'),
                                      debugPrint(" "),
                                      debugPrint(
                                          'y - coordinate ${details.globalPosition.dy}'),
                                      debugPrint(" "),
                                      if (instructionNumber == 0 ||
                                          instructionNumber == 1)
                                        {
                                          checkOutputSingleTap(
                                              details.globalPosition.dx,
                                              details.globalPosition.dy),
                                        }
                                      else
                                        {
                                          checkOutputDoubleTap(
                                              details.globalPosition.dx,
                                              details.globalPosition.dy,
                                              numberOfTaps)
                                        }
                                    },
                                }),
                      ),
                    ]),
      floatingActionButton: Visibility(
          visible: testComplete,
          child: FloatingActionButton.extended(
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Next"),
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FASTManualShapesComprehensionInstructions(),
                        ))
                  })),
    );
  }
}
