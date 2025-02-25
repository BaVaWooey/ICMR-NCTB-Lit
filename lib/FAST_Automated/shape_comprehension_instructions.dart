import 'imports.dart';
import '../screen/screens.dart';

class FASTShapeComprehensionInstructions extends StatefulWidget {
  const FASTShapeComprehensionInstructions({super.key});

  @override
  State<FASTShapeComprehensionInstructions> createState() =>
      _FASTShapeComprehensionInstructionsState();
}

class _FASTShapeComprehensionInstructionsState
    extends State<FASTShapeComprehensionInstructions> {
  bool screen_tapped = false;
  @override
  void initState() {
    screen_tapped = false;
    super.initState();
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
          title: const Text("FAST (Shapes Instructions)",
              style: TextStyle(fontSize: 40)),
          centerTitle: true),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
            child:
                Text(instructions_shape, style: const TextStyle(fontSize: 25))),
        Center(
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: GestureDetector(
                      child: Image.asset('assets/shapes.png'),
                      onTapDown: (details) {
                        setState(() {
                          screen_tapped = true;
                        });
                      },
                    )))),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text("Tap on the circle to continue.",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)))
      ]),
      floatingActionButton: Visibility(
        visible: screen_tapped,
        child: FloatingActionButton.extended(
            label: const Text('Next'),
            onPressed: () => {
                  setState(() {
                    next_test = "shapeComprehension";
                    debugPrint("checker");
                    debugPrint(next_test);
                    debugPrint("Checker");
                  }),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TransitionScreen()))
                },
            icon: const Icon(Icons.arrow_forward)),
      ),
    );
  }
}
