import 'imports.dart';
import '../screen/screens.dart';

class VerbalMemoryTrialFirst extends StatefulWidget {
  const VerbalMemoryTrialFirst({super.key});

  @override
  State<VerbalMemoryTrialFirst> createState() => _VerbalMemoryTrialFirstState();
}

class _VerbalMemoryTrialFirstState extends State<VerbalMemoryTrialFirst> {
  bool _testComplete = false,
      recitalComplete = false,
      recitalInProgress = false,
      recordingInProgress = false,
      recordingComplete = false;
  int startTimer = 5;
  String statusOfTest = "", pathStorage = "";

  //////
  @override
  void initState() {
    super.initState();
    _testComplete = false;
    recitalComplete = false;
    recitalInProgress = false;
    recordingComplete = false;
    trialNumberImmediate = 2;
    startTimer = 5;
    _startTimerInitiate();
    statusOfTest = "Not Started";
  }

  void _startTimerInitiate() async {
    while (startTimer > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        startTimer -= 1;
      });
    }

    ///once this is done, the recital will start
    stateWords();
  }

  void startRecording() async {
    if (recordingComplete == true) {
      return;
    }

    ///this is for recording the audio response of the participant
    final directory = await getApplicationSupportDirectory();
    String path = directory.path;
    var trial1Directory =
        await Directory('$path/verbal_memory/trial_1').create(recursive: true);
    path = trial1Directory.path;

    String filePath = '$path/sound_1.wav';

    ///recording starts here
    ///set state of recording her
    if (recordingInProgress == false) {
      await record.start(
          bitRate: 128000, encoder: AudioEncoder.wav, path: filePath);
      setState(() {
        recordingInProgress = true;
      });
    } else {
      await record.stop();
      setState(() {
        recordingInProgress = false;
        recordingComplete = true;
        pathStorage = filePath.substring(1);
        outputAudioPath.add(pathStorage);
        _testComplete = true;
      });
    }
  }

  void stateWords() async {
    int count = 0;
    String audioWord = "";
    ////this is where the words will be stated
    setState(() {
      recitalInProgress = true;
    });
    while (count < 10) {
      audioWord = wordToAudio[allRecitals[0][count]]!;

      ///once we do this, we will start to state the word involved in the process
      await player.setAsset(audioWord);

      await Future.delayed(const Duration(seconds: 1));

      await player.play();
      await Future.delayed(const Duration(seconds: 1));
      count += 1;
    }
    setState(() {
      recitalComplete = true;
      recitalInProgress = false;
    });
    return;
  }

  void playAudio() async {
    if (recordingComplete == false) {
      return;
    }
    ////we will have the path of the audio stored here
    await player.setFilePath(pathStorage);
    await player.play();
  }

  ///////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Trial 1", style: TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: startTimer > 0
            ? Center(
                child: Text("The test will begin in $startTimer",
                    style: const TextStyle(
                        fontSize: 45, fontWeight: FontWeight.bold)))
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    const Padding(
                        padding: EdgeInsets.all(15),
                        child: Center(
                            child: Text("Current status of test",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)))),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: Text(
                                recitalInProgress == true
                                    ? "Recital in Progress"
                                    : recitalComplete == true
                                        ? "Recital Complete"
                                        : "Recital Started",
                                style: const TextStyle(fontSize: 30)))),
                    Visibility(
                      visible: recitalComplete,
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                              child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                            color: recordingInProgress == false
                                ? Colors.blue
                                : Colors.red,
                            onPressed: () => {
                              ///this is for recording the audio
                              startRecording(),
                            },
                            child: recordingInProgress == true
                                ? const Text("Stop recording",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))
                                : const Text("Start recording",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                          ))),
                    ),
                    Visibility(
                      visible: recitalComplete,
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                color: recordingComplete == true
                                    ? Colors.blue
                                    : Colors.red,
                                onPressed: () => {
                                      playAudio(),
                                      ////here is where the audio will be spoken out for reference
                                    },
                                child: recordingComplete == true
                                    ? const Text("Play Audio",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold))
                                    : const Text("Record first",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold))),
                          )),
                    )
                  ]),
        floatingActionButton: Visibility(
            visible: _testComplete,
            child: FloatingActionButton.extended(
                onPressed: () => {
                      setState(() => trialNumberImmediate = 2),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VerbalInstructions()))
                    },
                label: const Text('Next'),
                icon: const Icon(Icons.arrow_forward))));
  }
}
