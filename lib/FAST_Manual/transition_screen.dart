import 'imports.dart';
import '../screen/screens.dart';

class FASTTransitionScreen extends StatefulWidget {
  const FASTTransitionScreen({super.key});

  @override
  State<FASTTransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<FASTTransitionScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Center(
            child: Text(
                "Press the button below ONLY if you are ready to take the test.",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text('Next'),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => nextTest == "riverComprehension"
                              ? const FASTManualRiverComprehension()
                              : nextTest == "shapeComprehension"
                                  ? const FASTManualShapesComprehension()
                                  : const FASTManualRiverReading()))
                },
            icon: const Icon(Icons.arrow_forward)));
  }
}
