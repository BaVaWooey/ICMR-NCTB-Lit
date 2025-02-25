import '../screen/screens.dart';
import 'imports.dart';

class VerbalInstructions extends StatefulWidget {
  const VerbalInstructions({super.key});

  @override
  State<VerbalInstructions> createState() => _VerbalInstructionsState();
}

class _VerbalInstructionsState extends State<VerbalInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Verbal Memory', style: TextStyle(fontSize: 40)),
          centerTitle: true,
          toolbarHeight: 100),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 100),
            child: Center(
                child: Text(
                    trialNumberImmediate == 1
                        ? verbalInstructionsImmediate
                        : verbalInstructionsSecondImmediate,
                    style: const TextStyle(fontSize: 30, height: 1.5))))
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            // const VerbalMemoryImmediateChecklist()
                            trialNumberImmediate == 1
                                ? const VerbalMemoryTrialFirst()
                                : trialNumberImmediate == 2
                                    ? const VerbalMemoryTrialSecond()
                                    : const VerbalMemoryTrialThird()))
              },
          icon: const Icon(Icons.arrow_right),
          label: const Text('Next')),
    );
  }
}
