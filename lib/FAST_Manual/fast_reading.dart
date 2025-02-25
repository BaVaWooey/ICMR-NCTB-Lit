import 'imports.dart';
import '../screen/screens.dart';

///we will need a screen to display the instructions of the first part of the test
class FastSceneryReadingInstructions extends StatefulWidget {
  const FastSceneryReadingInstructions({super.key});

  @override
  State<FastSceneryReadingInstructions> createState() =>
      _FastSceneryReadingInstructionsState();
}

class _FastSceneryReadingInstructionsState
    extends State<FastSceneryReadingInstructions> {
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
                'You will be shown a picture of a riverside. Upon proceeding further with the test, a set of instructions will be written on top of the screen. Read them carefully and tap on the screen, indicating the things that you are told to point.',
                style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic)),
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Container(
              height: 400,
              decoration: BoxDecoration(border: Border.all()),
              child: Image.asset('assets/river.png')),
        )),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Center(
                child: Text(
                    'The test will begin once you press on the "Next" button below.',
                    style:
                        TextStyle(fontSize: 25, fontStyle: FontStyle.italic)))),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Center(
                child: Text(
                    'Note that for this test, the instructions will be written on top of the screen.',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))))
      ]),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Next'),
          icon: const Icon(Icons.arrow_right),
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FastSceneryReadingTest()))
              }),
    );
  }
}

///we will need a screen/set of screens to actually proceed forth with the test
class FastSceneryReadingTest extends StatefulWidget {
  const FastSceneryReadingTest({super.key});

  @override
  State<FastSceneryReadingTest> createState() => _FastSceneryReadingTestState();
}

class _FastSceneryReadingTestState extends State<FastSceneryReadingTest> {
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

    ///this is where the test starts
    ///
    return;
  }

  void checkTapPosition() {
    if (currCheck == 5) {
      testComplete = true;
      return;
    } else if (currCheck == 4) {
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
        if (currCheck == 5) {
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
                    : Text(riverReadingInstructions[currCheck],
                        style: const TextStyle(fontSize: 30)),
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
                child: Image.asset('assets/river.png'),
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
                    },
                icon: const Icon(Icons.arrow_right),
                label: const Text('Next'))));
  }
}
