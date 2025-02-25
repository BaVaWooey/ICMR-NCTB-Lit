import '../screen/screens.dart';
import 'imports.dart';

class FASTRiverExpression extends StatefulWidget {
  const FASTRiverExpression({super.key});

  @override
  State<FASTRiverExpression> createState() => _FASTRiverExpressionState();
}

class _FASTRiverExpressionState extends State<FASTRiverExpression> {
  bool recordingComplete = false,
      recordingInProgress = false,
      audioReplayed = false;
  String audioPath = "";
  @override
  void initState() {
    super.initState();
  }

  void recordingFunction() async {
    if (recordingComplete == true) return;
    debugPrint('Entered');

    ///code for recording
    final directory = await getApplicationSupportDirectory();
    String path = directory.path;
    var varDirectory =
        await Directory('$path/fast_expression').create(recursive: true);
    path = varDirectory.path;

    String filePath = '$path/expression.wav';
    if (recordingInProgress == false) {
      await record.start(
          bitRate: 128000, encoder: AudioEncoder.wav, path: filePath);
      setState(() {
        recordingInProgress = true;
      });
    } else {
      await record.stop();
      setState(() {
        audioPath = filePath.substring(1);
        finalAudioPath = filePath.substring(1);
        recordingInProgress = false;
        recordingComplete = true;
      });
    }
    debugPrint('Done');
    ////
  }

  void replayAudio() async {
    if (recordingComplete == false || audioReplayed == true) return;
    setState(() {
      audioReplayed = true;
    });
    /////code for replaying audio
    await player.setFilePath(audioPath);
    await player.play();

    setState(() {
      audioReplayed = false;
    });
    return;
  }

  ////this is where all the recording will be at.

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 100,
            centerTitle: true,
            title: const Text('Expression (Recording)',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Text('Press the button below to start recording.',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )))),
          Center(
              child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 5)),
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Image.asset('assets/river.png'),
            ),
          )),
          Center(
              child: Visibility(
            visible: !recordingComplete,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: MaterialButton(
                    color: recordingInProgress == true
                        ? Colors.yellow
                        : Colors.green,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    onPressed: () => {
                          ////press the button once to start recording
                          recordingFunction()

                          ///press it again to stop recording
                        },
                    child: recordingInProgress == true
                        ? const Icon(Icons.mic_external_off)
                        : const Icon(Icons.mic_external_on))),
          )),
          Center(
              child: Visibility(
            visible: recordingComplete && !recordingInProgress,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    onPressed: () => {
                          ///replay audio function
                          replayAudio()
                        },
                    color: audioReplayed == true ? Colors.grey : Colors.green,
                    child: Text(
                      audioReplayed == true ? 'Wait' : 'Replay',
                    ))),
          ))
        ]),
        floatingActionButton: Visibility(
          visible: recordingComplete,
          child: FloatingActionButton.extended(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FASTManualWritingInstructions()))
                  },
              label: const Text('Next')),
        ));
  }
}
