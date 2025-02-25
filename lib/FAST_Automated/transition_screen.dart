import 'imports.dart';
import '../screen/screens.dart';

class TransitionScreen extends StatefulWidget {
  const TransitionScreen({super.key});

  @override
  State<TransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

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
                          builder: (context) =>
                              next_test == "riverComprehension"
                                  ? const FASTRiverComprehension()
                                  : next_test == "shapeComprehension"
                                      ? const FASTShapeComprehension()
                                      : next_test == "riverReading"
                                          ? const FASTRiverReading()
                                          : const FASTRiverReading()))
                },
            icon: const Icon(Icons.arrow_forward)));
  }
}
