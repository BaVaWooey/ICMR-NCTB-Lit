import 'imports.dart';
import '../screen/screens.dart';

class FASTRiverReading extends StatefulWidget {
  const FASTRiverReading({super.key});

  @override
  State<FASTRiverReading> createState() => _FASTRiverReadingState();
}

///two ways to get outputs of the taps
///by submitting, and by letting time pass by.

class _FASTRiverReadingState extends State<FASTRiverReading> {
  List<double> tempFirst = [], tempTempSecond = [];
  List<List<double>> finalFirst = [], tempSecond = [];
  List<List<List<double>>> finalSecond = [];
  List<bool> breakTests = [false, false, false, false, false];
  bool testComplete = false;
  int instructionTime = 20,
      testStartTime = 5,
      instructionNumber = 0,
      numberOfTaps = 1;
  @override
  void initState() {
    testComplete = false;
    instructionTime = 20;
    testStartTime = 5;
    instructionNumber = 0;
    numberOfTaps = 1;
    testTimerCount();
    super.initState();
  }

  void testTimerCount() async {
    while (testStartTime > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        testStartTime -= 1;
      });
    }
    instructionTimerCount(instructionNumber);
  }

  void instructionTimerCount(insNumber) async {
    while (instructionTime > 0) {
      if (breakTests[insNumber] == true) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        instructionTime -= 1;
      });
    }
    if (breakTests[insNumber] == false) {
      ///This means that the time has passed since the instructions were issued.
      resetValues();
    }
  }

  void resetValues() {
    ///here we will setState all the values
    if (instructionNumber < 5) {
      setState(() {
        instructionNumber += 1;
        if (instructionNumber != 4) {
          setState(() {
            numberOfTaps = 1;
          });
        } else {
          setState(() {
            numberOfTaps = 2;
          });
        }
      });
    }
    if (instructionNumber < 5) {
      instructionTime = 20;

      ///we will have to push all the results here.
      finalSecond.add(tempSecond);
      finalFirst.add(tempFirst);
      tempSecond.clear();
      tempFirst.clear();

      ///then here we start the instruction timer count again
      instructionTimerCount(instructionNumber);
    } else {
      setState(() {
        testComplete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: testComplete == true
            ? const Center(
                child: Text("The test is complete.",
                    style:
                        TextStyle(fontSize: 45, fontWeight: FontWeight.bold)))
            : testStartTime > 0
                ? Center(
                    child: Text("The test begins in $testStartTime",
                        style: const TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold)))
                : Column(
                    children: [
                      ///instruction at the top.
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                          child: Text(
                              riverInstructionsReading[instructionNumber])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ///number of taps.
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                  child: Text(
                                      'Number of taps left - $numberOfTaps',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25))),

                              ///submit button.
                              Center(
                                  child: TextButton.icon(
                                icon: numberOfTaps > 0
                                    ? const Icon(Icons.close, color: Colors.red)
                                    : const Icon(Icons.arrow_forward,
                                        color: Colors.greenAccent),
                                label: numberOfTaps > 0
                                    ? const Text("Tap first.",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red))
                                    : const Text("Next Instruction",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.green)),
                                onPressed: () => {
                                  if (numberOfTaps == 0 &&
                                      instructionNumber < 5)
                                    {
                                      setState(() {
                                        breakTests[instructionNumber] = true;
                                      }),
                                      resetValues()
                                    }
                                },
                              )),
                              Container(
                                height: 50,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  value: instructionTime / 20,
                                )),
                              )
                            ],
                          ),
                          GestureDetector(
                              child: Container(
                                  width: 650,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Image.asset('assets/river.png')),
                              onTapDown: (details) => {
                                    if (numberOfTaps > 0)
                                      {
                                        setState(() {
                                          numberOfTaps -= 1;
                                        }),
                                        //we will add something else to this later.
                                        if (instructionNumber != 4)
                                          {
                                            setState(() {
                                              tempFirst.clear();
                                              tempFirst.add(
                                                  details.globalPosition.dx);
                                              tempFirst.add(
                                                  details.globalPosition.dy);
                                            })
                                          }
                                        else
                                          {
                                            setState(() {
                                              if (numberOfTaps == 1) {
                                                tempSecond.clear();
                                                tempTempSecond.clear();
                                                tempTempSecond.add(
                                                    details.globalPosition.dx);
                                                tempTempSecond.add(
                                                    details.globalPosition.dy);
                                                tempSecond.add(tempTempSecond);
                                              } else {
                                                tempTempSecond.clear();
                                                tempTempSecond.add(
                                                    details.globalPosition.dx);
                                                tempTempSecond.add(
                                                    details.globalPosition.dy);
                                                tempSecond.add(tempTempSecond);
                                              }
                                            }),
                                          }
                                      }
                                  })
                        ],
                      ),
                    ],
                  ));
  }
}
