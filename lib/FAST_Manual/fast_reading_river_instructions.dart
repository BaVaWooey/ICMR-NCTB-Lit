import 'imports.dart';
import '../screen/screens.dart';

class FASTReadingRiverInstructions extends StatefulWidget {
  const FASTReadingRiverInstructions({super.key});

  @override
  State<FASTReadingRiverInstructions> createState() =>
      _FASTReadingRiverInstructionsState();
}

class _FASTReadingRiverInstructionsState
    extends State<FASTReadingRiverInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAST (Reading)",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: Column(children: [
        Center(
            child: Padding(
                padding: const EdgeInsets.all(50),
                child: Text(fastManualRiverReadingInstructions,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold))))
      ]),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Next'),
        icon: const Icon(Icons.arrow_forward),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FASTRiverReading()))
        },
      ),
    );
  }
}
