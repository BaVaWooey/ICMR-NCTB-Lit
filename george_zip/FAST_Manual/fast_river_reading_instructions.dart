import 'imports.dart';
import '../screen/screens.dart';

class FASTRiverReadingInstructions extends StatefulWidget {
  const FASTRiverReadingInstructions({super.key});

  @override
  State<FASTRiverReadingInstructions> createState() =>
      _FASTRiverReadingInstructionsState();
}

class _FASTRiverReadingInstructionsState
    extends State<FASTRiverReadingInstructions> {
  bool screen_tapped = false;
  @override
  void initState() {
    screen_tapped = false;
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("FAST (River Instructions)",
              style: TextStyle(fontSize: 40)),
          centerTitle: true),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text(fastManualRiverReadingInstructions,
                style: const TextStyle(fontSize: 25))),
        Center(
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: GestureDetector(
                      child: Image.asset('assets/river.png', height: 400),
                      onTapDown: (details) {
                        setState(() {
                          screen_tapped = true;
                        });
                      },
                    )))),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text("Tap on the river to continue.",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)))
      ]),
      floatingActionButton: Visibility(
        visible: screen_tapped,
        child: FloatingActionButton.extended(
            label: const Text('Next'),
            onPressed: () => {
                  setState(() {
                    nextTest = "riverReading";
                  }),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FASTTransitionScreen()))
                },
            icon: const Icon(Icons.arrow_forward)),
      ),
    );
  }
}
