import 'imports.dart';
import '../screen/screens.dart';

///we will need a screen to display the instructions of the first part of the test
class FASTManualRiverReading extends StatefulWidget {
  const FASTManualRiverReading({super.key});

  @override
  State<FASTManualRiverReading> createState() => _FASTManualRiverReadingState();
}

class _FASTManualRiverReadingState extends State<FASTManualRiverReading> {
  int timerStart = 5, instructionNumber = 0, numberOfTaps = 1;
  bool testComplete = false;
  @override
  ////INIT FUNCTION
  ////
  void initState() {
    timerStart = 5;
    instructionNumber = 0;
    testComplete = false;
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
  }

  void setTaps() {
    if (instructionNumber != 4) {
      setState(() {
        numberOfTaps = 3;
      });
    } else {
      numberOfTaps = 6;
    }
  }

  void resetValues() {
    ////RESETTING VALUES.
    ////IF INS NUMBER = 0 || 1, WE SET TAPS TO 1 and RESET to 3.
    ///ELSE, TAPS to 2 and RESET to 3.
    ///IF INS NUM == 5 WE SET TEST COMPLETE TO TRUE.
    setState(() {
      instructionNumber += 1;
      if (instructionNumber < 4) {
        numberOfTaps = 1;
      } else if (instructionNumber == 4) {
        numberOfTaps = 2;
      } else {
        testComplete = true;
      }
    });
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
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Center(
                            child: Text(
                                riverReadingInstructions[instructionNumber],
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /////
                          ///ADDING COLUMN FOR BUTTONS AND REPLAY DETAILS.
                          Container(
                            width: 150,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ///NUMBER OF TAPS LEFT.
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 100),
                                      child: Center(
                                          child: Text(
                                              "Number of taps left - $numberOfTaps",
                                              style: const TextStyle(
                                                  fontSize: 20)))),

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
                                                  : MaterialStatePropertyAll<Color>(
                                                      Colors.greenAccent
                                                          .shade100)),
                                          icon: numberOfTaps > 0
                                              ? const Icon(Icons.close,
                                                  color: Colors.red)
                                              : const Icon(Icons.arrow_forward,
                                                  color: Colors.green),
                                          label: numberOfTaps > 0
                                              ? const Text("Complete the taps",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20))
                                              : const Text("Next Instruction", style: TextStyle(color: Colors.green, fontSize: 20)),
                                          onPressed: () => {
                                                ///CHECKING TAPPING CONDITION
                                                if (numberOfTaps == 0 &&
                                                    instructionNumber < 5)
                                                  {
                                                    ///THEN WE PROCEED TO THE NEXT INSTRUCTION.
                                                    resetValues()
                                                  }
                                              }))
                                ]),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 70,
                            child: GestureDetector(
                                child: Image.asset('assets/river.png',
                                    fit: BoxFit.fill),
                                onTapDown: (details) => {
                                      if (numberOfTaps > 0)
                                        {
                                          setState(() {
                                            numberOfTaps -= 1;
                                          })
                                        }
                                    }),
                          ),
                        ]),
                  ],
                ),
      floatingActionButton: Visibility(
          visible: testComplete,
          child: FloatingActionButton.extended(
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Next"),
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FASTTestCompletion(),
                        ))
                  })),
    );
  }
}
