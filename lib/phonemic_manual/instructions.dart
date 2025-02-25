import '../screen/screens.dart';
import 'imports.dart';

class PhonemicManualInstructions extends StatefulWidget {
  const PhonemicManualInstructions({super.key});

  @override
  State<PhonemicManualInstructions> createState() =>
      _PhonemicManualInstructionsState();
}

class _PhonemicManualInstructionsState
    extends State<PhonemicManualInstructions> {
  bool dummyExample = false, dummyInProgress = false;
  String firstInteractive = "The phoneme for this example is Ga.",
      secondInteractive =
          "The words recited will be - Garrison - Gas - and - Gait.";
  @override
  void initState() {
    dummyExample = false;
    dummyInProgress = false;
    super.initState();
  }

  void reciteInteractive() async {
    ////text to speech will occur here.
    setState(() {
      dummyInProgress = true;
    });
    flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(secondInteractive);
    setState(() {
      dummyExample = true;
      dummyInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phonemic Fluency (Manual)',
            style: TextStyle(fontSize: 40)),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 70, 40, 30),
          child: Center(
              child: Text(
                  'The phoneme in this case will be "Ba". You will have to tell words that start with the phoneme Ba.',
                  style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic))),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 70, 40, 30),
          child: Center(
              child: Text(
                  'You should recite words such as Bar, Bartender, Bastion, etc.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(40, 70, 40, 30),
            child: Center(
                child: Text(
                    'Press the button below for an interactive example. You will able to go to the next part of the test only after pressing this button.',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w600)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(40, 70, 40, 30),
            child: Center(
                child: MaterialButton(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    color: Colors.blue,
                    onPressed: () {
                      ///this is where the audio will be recited.
                      if (dummyInProgress == false && dummyExample == false) {
                        reciteInteractive();
                      }
                    },
                    child: const Icon(Icons.speaker,
                        color: Colors.white, size: 40)))),
        Padding(
            padding: const EdgeInsets.fromLTRB(40, 60, 40, 30),
            child: Text(firstInteractive,
                style:
                    const TextStyle(fontSize: 25, fontStyle: FontStyle.italic)))
      ]),
      floatingActionButton: Visibility(
        visible: dummyExample,
        child: FloatingActionButton.large(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PhonemicManualRecording()))
                },
            child: const Icon(Icons.arrow_forward)),
      ),
    );
  }
}
