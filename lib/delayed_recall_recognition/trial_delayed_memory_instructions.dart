import 'imports.dart';
import '../screen/screens.dart';

////We will have to write the instructions first
///
class DelayedMemoryTaskInstructions extends StatefulWidget {
  const DelayedMemoryTaskInstructions({super.key});

  @override
  State<DelayedMemoryTaskInstructions> createState() =>
      _DelayedMemoryTaskInstructionsState();
}

class _DelayedMemoryTaskInstructionsState
    extends State<DelayedMemoryTaskInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Delayed Memory Recall Instructions",
              style: TextStyle(fontSize: 40)),
          toolbarHeight: 100,
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 100),
            child: Text(delayedInstructions,
                style: const TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text('Next'),
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DelayedMemoryTaskRecording()))
                }));
  }
}
