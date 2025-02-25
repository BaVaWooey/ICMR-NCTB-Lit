import 'imports.dart';
import '../screen/screens.dart';

class FASTManualRiverComprehensionDemo extends StatefulWidget {
  const FASTManualRiverComprehensionDemo({super.key});

  @override
  State<FASTManualRiverComprehensionDemo> createState() =>
      _FASTRiverComprehensionDemoState();
}

class _FASTRiverComprehensionDemoState
    extends State<FASTManualRiverComprehensionDemo> {
  bool instructionStating = false,
      instructionComplete = false,
      demoComplete = false;
  int timerCount = 5;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    instructionStating = false;
    instructionComplete = false;
    demoComplete = false;
    timerCount = 5;
    countDown();
    super.initState();
  }

  ///here we start countdown of the timer.
  void countDown() async {
    setState(() {
      instructionStating = true;
    });
    while (timerCount > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timerCount -= 1;
      });
    }
    setState(() {
      instructionStating = false;
      instructionComplete = true;
    });
    return;
  }

  ///stating the instruction
  void stateDummyInstruction() async {
    ///this will be activated whenever the button is tapped.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          ///we will need three components.
          ///Test starts in 5,4,3,2,1.
          ///The instruction itself will be told to the user.
          instructionComplete == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text('The test starts in - ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Text('$timerCount'),
                      )

                      ///variable that counts down.
                    ])
              : const Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Center(
                    child: Text('The test has begun.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )),
          GestureDetector(
              child: Container(
                  width: 650,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Image.asset('assets/river.png')),
              onTap: () => {
                    if (instructionStating == false &&
                        instructionComplete == true)
                      {
                        setState(() {
                          demoComplete = true;
                        })
                      }
                    //we will add something else to this later.
                  }),

          ///this will be a way to present the instruction to the user.
          Visibility(
            visible: instructionComplete,

            ///this will be a variable that takes care of instruction recitation.
            child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Center(
                    child: Text('Point to the river.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)))),
          )
        ]),
        floatingActionButton: Visibility(
          visible: demoComplete,
          child: FloatingActionButton.extended(
              label: const Text('Next'),
              onPressed: () => {
                    setState(() {
                      nextTest = "riverComprehension";
                    }),
                    super.dispose(),

                    ///we are pushing the page to the actual test.
                    ///
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FASTTransitionScreen()))
                  },
              icon: const Icon(Icons.arrow_forward)),
        ));
  }
}
