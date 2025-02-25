import 'imports.dart';
import '../screen/screens.dart';

////define the main instructions for the test here
class FASTManualInstructions extends StatefulWidget {
  const FASTManualInstructions({super.key});

  @override
  State<FASTManualInstructions> createState() => _FASTManualInstructionsState();
}

class _FASTManualInstructionsState extends State<FASTManualInstructions> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("FAST (Manual)", style: TextStyle(fontSize: 40)),
          centerTitle: true,
          toolbarHeight: 100),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text(fastManualInstructions,
                style: const TextStyle(fontSize: 30))),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: TextButton.icon(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.blue),
                      ),
                      icon: const Icon(Icons.mic_outlined, color: Colors.white),
                      label: const Text("Press to recite instruction.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () => {
                            debugPrint(
                                "We will need to add audio file for reciting the instruction here.")
                            /////////
                            ///INMPORTANT FIX NEEDED HERE.
                            /////////
                          })),
            ))
      ]),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Next'),
          onPressed: () => {
                setState(() {
                  nextTest = "riverComprehension";
                }),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FASTManualRiverComprehensionDemo()))
              },
          icon: const Icon(Icons.arrow_forward)),
    );
  }
}
