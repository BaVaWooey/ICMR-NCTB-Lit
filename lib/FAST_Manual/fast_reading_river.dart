import 'imports.dart';
import '../screen/screens.dart';

class FASTRiverReading extends StatefulWidget {
  const FASTRiverReading({super.key});

  @override
  State<FASTRiverReading> createState() => _FASTRiverReadingState();
}

class _FASTRiverReadingState extends State<FASTRiverReading> {
  bool firstTapVal = false, secondTapVal = false;
  int instructionCount = 0, correctCount = 0, firstTap = 0;
  @override
  void initState() {
    instructionCount = 0;
    correctCount = 0;
    super.initState();
  }

  void onPressFunction(double x, double y) {
    debugPrint(riverReadingCheckingOneTap.length.toString());
    if (instructionCount < 4) {
      if (x > riverReadingCheckingOneTap[instructionCount][0][0] &&
          y > riverReadingCheckingOneTap[instructionCount][0][1] &&
          x < riverReadingCheckingOneTap[instructionCount][1][0] &&
          y < riverReadingCheckingOneTap[instructionCount][1][1]) {
        setState(() {
          correctCount += 1;
        });
        debugPrint("Correct Tap");
      }
    } else if (instructionCount == 4) {
      if (firstTap == 0) {
        if (y > values[0]) {
          setState(() {
            firstTapVal = true;
            debugPrint("This has been entered");
          });
        }
      } else if (firstTap == 1) {
        if (y < values[1]) {
          setState(() {
            secondTapVal = true;
            debugPrint("This has been entered as well");
          });
        }
      }
      firstTap += 1;
    }
    if (instructionCount < 4 || (instructionCount == 4 && firstTap == 2)) {
      setState(() {
        instructionCount += 1;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FAST (Reading)",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: instructionCount < 5
                      ? Text(riverReadingInstructions[instructionCount],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                      : const Text("The test is complete.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))),
          GestureDetector(
              child: Container(
                  width: 800,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Image.asset('assets/river.png')),
              onTapDown: (details) => {
                    // debugPrint(details.globalPosition.dx.toString()),
                    // debugPrint(details.globalPosition.dy.toString()),
                    onPressFunction(
                        details.globalPosition.dx, details.globalPosition.dy)
                  })
        ]),
        floatingActionButton: Visibility(
          visible: (instructionCount == 5),
          child: FloatingActionButton.extended(
            onPressed: () => {
              setState(() {
                correctCount += (firstTapVal && secondTapVal) ? 1 : 0;
                fastReadingScore = correctCount;
              }),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const FASTManualWritingInstructions()))
            },
            label: const Text('Next'),
            icon: const Icon(Icons.arrow_forward),
          ),
        ));
  }
}
