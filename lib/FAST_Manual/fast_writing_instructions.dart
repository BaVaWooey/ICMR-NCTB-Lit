import 'imports.dart';
import '../screen/screens.dart';

////this is for the writing component of FAST

class FASTManualWritingInstructions extends StatefulWidget {
  const FASTManualWritingInstructions({super.key});

  @override
  State<FASTManualWritingInstructions> createState() =>
      _FASTManualWritingInstructionsState();
}

class _FASTManualWritingInstructionsState
    extends State<FASTManualWritingInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 100,
            title: const Text('FAST (Writing)',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
          child: Text(fastManualRiverWritingInstructions,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FASTManualWriting()))
                },
            label: const Text('Next'),
            icon: const Icon(Icons.arrow_forward)));
  }
}
