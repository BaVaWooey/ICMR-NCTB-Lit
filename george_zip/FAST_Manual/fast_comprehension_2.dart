import 'imports.dart';
import '../screen/screens.dart';

///we will need a screen to display the instructions of the first part of the test
class FastShapesInstructions extends StatefulWidget {
  const FastShapesInstructions({super.key});

  @override
  State<FastShapesInstructions> createState() => _FastShapesInstructionsState();
}

class _FastShapesInstructionsState extends State<FastShapesInstructions> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              const Text('FAST - instructions', style: TextStyle(fontSize: 40)),
          toolbarHeight: 100,
          centerTitle: true),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
          child: Center(
            child: Text(
                'You will be shown a picture of some shapes. Upon proceeding further with the test, a set of instructions will be recited to you. Listen carefully and tap on the screen, indicating the things that you are told to point.',
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic)),
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Image.asset('assets/shapes.png')),
        )),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Center(
                child: Text(
                    'The test will begin once you press on the "Next" button below.',
                    style:
                        TextStyle(fontSize: 25, fontStyle: FontStyle.italic))))
      ]),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Next'),
          icon: const Icon(Icons.arrow_right),
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FastShapesTest()))
              }),
    );
  }
}

///we will need a screen/set of screens to actually proceed forth with the test
class FastShapesTest extends StatefulWidget {
  const FastShapesTest({super.key});

  @override
  State<FastShapesTest> createState() => _FastShapesTestState();
}

class _FastShapesTestState extends State<FastShapesTest> {
  int countDown = 5, currCheck = 0, tapCount = 0;
  bool tapCheck = false, testComplete = false;
  @override
  void initState() {
    testComplete = false;
    currCheck = 0;
    tapCount = 0;
    countDown = 5;
    startingFunction();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  ///define an initator function for when the test starts
  void startingFunction() async {
    while (countDown > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        countDown -= 1;
      });
    }
    await flutterTts.speak(shapesComprehensionInstructions[currCheck]);

    ///this is where the test starts
    ///
    return;
  }

  void checkTapPosition() async {
    if (currCheck == 5) {
      testComplete = true;
      return;
    } else if (currCheck == 3) {
      if (tapCount == 0 || tapCount == 1) {
        setState(() {
          tapCount += 1;
        });
      } else {
        setState(() {
          tapCount = 0;
        });
        setState(() {
          currCheck += 1;
        });
        if (currCheck != 5) {
          await flutterTts.speak(shapesComprehensionInstructions[currCheck]);
        } else {
          setState(() {
            testComplete = true;
          });
        }
      }
    } else if (currCheck == 2 || currCheck == 4) {
      debugPrint('This is test $currCheck');

      ///this is waiting for double tap instructions
      if (tapCount == 0) {
        setState(() {
          tapCount += 1;
        });
      }

      ///this is for the next tap
      else {
        setState(() {
          tapCount = 0;
        });
        setState(() {
          currCheck += 1;
        });
        if (currCheck != 5) {
          await flutterTts.speak(shapesComprehensionInstructions[currCheck]);
        } else {
          setState(() {
            testComplete = true;
          });
        }
      }
    } else {
      debugPrint('This is test $currCheck');

      ///this is every other case
      setState(() {
        currCheck += 1;
      });
      await flutterTts.speak(shapesComprehensionInstructions[currCheck]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: countDown != 0
                ? Text('$countDown', style: const TextStyle(fontSize: 40))
                : testComplete == true
                    ? const Text('Test is Complete!',
                        style: TextStyle(fontSize: 40))
                    : const Text('Test has started!',
                        style: TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              debugPrint('Testing');
              checkTapPosition();
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Image.asset('assets/shapes.png'),
              ),
            )),
        floatingActionButton: Visibility(
            visible: testComplete,
            child: FloatingActionButton.extended(
                onPressed: () => {
                      ///we will have to change the orientation as well.
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]),
                      super.dispose(),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FastSceneryReadingInstructions()))
                    },
                icon: const Icon(Icons.arrow_right),
                label: const Text('Next'))));
  }
}
