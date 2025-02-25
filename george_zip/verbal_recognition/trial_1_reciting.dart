import 'imports.dart';
import '../screen/screens.dart';

class VerbalRecognitionReciting extends StatefulWidget {
  const VerbalRecognitionReciting({super.key});

  @override
  State<VerbalRecognitionReciting> createState() =>
      _VerbalRecognitionRecitingState();
}

class _VerbalRecognitionRecitingState extends State<VerbalRecognitionReciting> {
  @override
  void initState() {
    recitalComplete = false;
    recitalInProgress = false;
    super.initState();
  }

  void performRecital() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setLanguage("en-IN");
    if (recitalCount > 3) {
      await flutterTts.speak("The recital phase is over.");
      return;
    }
    setState(() {
      recitalInProgress = true;
    });
    await flutterTts.speak("This is trial number $recitalCount");
    await Future.delayed(const Duration(seconds: 1));
    for (String element in allRecitals[recitalCount - 1]) {
      await flutterTts.speak(element);
      await Future.delayed(const Duration(milliseconds: 300));
    }
    setState(() {
      recitalInProgress = false;
      recitalComplete = true;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Trial $recitalCount (Recital)',
                style: const TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 30),
              child: Center(
                  child: Text(recitalInstructions,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 2)))),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 30),
              child: Center(
                  child: MaterialButton(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      color: recitalComplete == true
                          ? Colors.red
                          : recitalInProgress == true
                              ? Colors.blue
                              : Colors.green,
                      onPressed: () => {
                            ////this is where the recital functions goes
                            if (recitalInProgress == false &&
                                recitalComplete == false)
                              performRecital()
                          },
                      child: recitalComplete == true
                          ? const Icon(Icons.stop,
                              size: 30, color: Colors.white)
                          : recitalInProgress == true
                              ? const Icon(Icons.mic_external_off,
                                  size: 30, color: Colors.white)
                              : const Icon(Icons.mic_external_on,
                                  size: 30, color: Colors.white)))),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
              child: recitalComplete == true
                  ? const Text("Recital completed.",
                      style: TextStyle(fontSize: 30, color: Colors.red))
                  : recitalInProgress == true
                      ? const Text("Recital in progress.",
                          style: TextStyle(fontSize: 30, color: Colors.blue))
                      : const Text("Recital not started.",
                          style: TextStyle(fontSize: 30, color: Colors.green)))
        ]),
        floatingActionButton: Visibility(
          visible: recitalComplete,
          child: FloatingActionButton.extended(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerbalImmediate()))
                  },
              icon: const Icon(Icons.arrow_outward_sharp),
              label: const Text('Next')),
        ));
  }
}
