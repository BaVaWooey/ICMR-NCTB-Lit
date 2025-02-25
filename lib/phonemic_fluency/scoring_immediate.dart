import '../screen/screens.dart';
import 'imports.dart';

class PhonemicImmediateScoring extends StatefulWidget {
  const PhonemicImmediateScoring({super.key});

  @override
  State<PhonemicImmediateScoring> createState() =>
      _PhonemicImmediateScoringState();
}

class _PhonemicImmediateScoringState extends State<PhonemicImmediateScoring> {
  String currentTest = "", currentPath = "", filePath = "";
  bool isRecording = false, recordingComplete = false, audioPlaying = false;
  int tempScoreValue = 0;
  @override
  void initState() {
    isRecording = false;
    recordingComplete = false;
    titleInitiator();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void titleInitiator() {
    setState(() {
      if (currentElement == "m") {
        maScoringDone = true;
        currentTest = "Ma Sound";
        currentPath = "ma_sound";
      } else if (currentElement == "p") {
        paScoringDone = true;
        currentTest = "Pa Sound";
        currentPath = "pa_sound";
      } else {
        kaScoringDone = true;
        currentTest = "Ka Sound";
        currentPath = "ka_sound";
      }
    });
  }

  void startRecording() async {
    if (recordingComplete || isRecording) return;
    setState(() {
      isRecording = true;
    });

    // await Future.delayed(const Duration(milliseconds: 5000));
    //creating directory

    final directory = await getApplicationSupportDirectory();
    String path = directory.path;
    var tempDirectory = await Directory('$path/phonemic_fluency/$currentPath')
        .create(recursive: true);
    path = tempDirectory.path;
    filePath = '$path/$userName.wav';

    ///record audio
    await record.start(const RecordConfig(), path: filePath);
    while (timerValue < 5) {
      debugPrint('This has been entered');
      await Future.delayed(const Duration(seconds: 1));
      setState(() => (timerValue += 1));
    }
    await record.stop();

    setState(() {
      isRecording = false;
      recordingComplete = true;
      if (currentElement == "m") {
        finalUserMaDirectory = filePath;
      } else if (currentElement == "p") {
        finalUserPaDirectory = filePath;
      } else {
        finalUserKaDirectory = filePath;
      }
    });
  }

  void replayAudio() async {
    if (audioPlaying == true) return;
    /////code for replaying audio
    await player.setFilePath(filePath);
    setState(() {
      audioPlaying = true;
    });
    await player.play();
    setState(() {
      audioPlaying = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Immediate Scoring ($currentTest)",
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Text(phonemicImmediateScoringInstructions,
                style: const TextStyle(
                    fontSize: 30, height: 1.5, fontStyle: FontStyle.italic)),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Text(
                isRecording
                    ? "Recording in Progress"
                    : recordingComplete
                        ? "Recording Complete"
                        : "Tap to start recording",
                style: const TextStyle(
                    fontSize: 30,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Visibility(
          visible: !recordingComplete,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: MaterialButton(
                      padding: const EdgeInsets.all(20),
                      shape: CircleBorder(),
                      onPressed: () => {
                            ///this will start the recording function.
                            startRecording()
                          },
                      color: isRecording
                          ? Colors.blue
                          : recordingComplete
                              ? Colors.green
                              : Colors.amber,
                      child: Icon(
                          isRecording
                              ? Icons.mic_off
                              : recordingComplete
                                  ? Icons.thumb_up
                                  : Icons.mic,
                          size: 50,
                          color: Colors.white)))),
        ),
        Visibility(
          visible: isRecording || recordingComplete,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Text(
                  isRecording
                      ? "Current Score Count : $tempScoreValue"
                      : "Final Score Count : $tempScoreValue",
                  style: const TextStyle(
                      fontSize: 30,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Visibility(
          visible: isRecording,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Center(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: MaterialButton(
                        padding: const EdgeInsets.all(20),
                        shape: const CircleBorder(),
                        color: Colors.blue,
                        child: const Icon(Icons.arrow_upward, size: 50),
                        onPressed: () => {
                              //this will take care of the score.
                              setState(() {
                                tempScoreValue += 1;
                              })
                            }))),
          ]),
        ),
        Visibility(
          visible: recordingComplete,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: MaterialButton(
                      padding: const EdgeInsets.all(20),
                      shape: CircleBorder(),
                      onPressed: () => {
                            replayAudio()

                            ///this will start the recording function.
                          },
                      color: audioPlaying ? Colors.amber : Colors.green,
                      child: audioPlaying
                          ? const Icon(Icons.multitrack_audio, size: 50)
                          : const Icon(Icons.replay, size: 50)))),
        )
      ]),
      floatingActionButton: Visibility(
        visible: recordingComplete && !audioPlaying,
        child: FloatingActionButton.extended(
            onPressed: () {
              ///this will go to the next test.
              if (currentElement == "m") {
                setState(() {
                  finalMaScore = tempScoreValue;
                });
                Navigator.popAndPushNamed(context, "phonemic fluency (pa)");
              } else if (currentElement == "p") {
                setState(() {
                  finalPaScore = tempScoreValue;
                });
                Navigator.popAndPushNamed(context, "phonemic fluency (ka)");
              } else {
                setState(() {
                  finalKaScore = tempScoreValue;
                });
                Navigator.popAndPushNamed(
                    context, "phonemic fluency (results)");
              }
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Next")),
      ),
    );
  }
}
