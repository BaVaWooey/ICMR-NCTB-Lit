import 'imports.dart';
import '../screen/screens.dart';

///this is for importing the files into your code.

class DelayedRecognitionTaskInstructions extends StatefulWidget {
  const DelayedRecognitionTaskInstructions({super.key});

  @override
  State<DelayedRecognitionTaskInstructions> createState() =>
      _DelayedRecognitionTaskInstructionsState();
}

class _DelayedRecognitionTaskInstructionsState
    extends State<DelayedRecognitionTaskInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Delayed Memory Recognition Instructions",
              style: TextStyle(fontSize: 40)),
          toolbarHeight: 100,
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 100),
            child: Text(delayedRecognitionInstructions,
                style: const TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text('Next'),
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DelayedRecognitionTask()))
                }));
  }
}
