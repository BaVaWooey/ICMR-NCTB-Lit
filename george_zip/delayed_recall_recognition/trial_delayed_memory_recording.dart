import 'imports.dart';
import '../screen/screens.dart';

class DelayedMemoryTaskRecording extends StatefulWidget {
  const DelayedMemoryTaskRecording({super.key});

  @override
  State<DelayedMemoryTaskRecording> createState() =>
      _DelayedMemoryTaskRecordingState();
}

class _DelayedMemoryTaskRecordingState
    extends State<DelayedMemoryTaskRecording> {
  String pathStorage = "";
  bool is_recording = false, recording_complete = false, _testComplete = false;
  @override
  void initState() {
    is_recording = false;
    recording_complete = false;
    _testComplete = false;
    super.initState();
  }

  void startRecording() async {
    if (recording_complete == true) return;
    final directory = await getApplicationSupportDirectory();
    String path = directory.path;
    var trial1Directory = await Directory('$path/verbal_memory/delayed_memory')
        .create(recursive: true);
    path = trial1Directory.path;

    String filePath = '$path/sound_1.wav';
    if (is_recording == false) {
      await record.start(
          bitRate: 128000, encoder: AudioEncoder.wav, path: filePath);
      setState(() {
        is_recording = true;
      });
    } else {
      await record.stop();
      setState(() {
        is_recording = false;
        recording_complete = true;
        pathStorage = filePath.substring(1);
        finalFilePath = pathStorage;
        outputAudioPath.add(pathStorage);
        _testComplete = true;
      });
    }
  }

  void playRecording() async {
    if (_testComplete == false) return;
    await player.setFilePath(pathStorage);
    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Delayed Memory Recall Recording",
                style: TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 100),
            child: Center(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5)),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Text("Press the button below to start recording.",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            )),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 100),
            child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.lightBlueAccent;
                    }
                    return Colors.white;
                  }),
                  textStyle: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return size 40, otherwise 20
                    if (states.contains(MaterialState.pressed)) {
                      return const TextStyle(fontSize: 40, color: Colors.blue);
                    }
                    return const TextStyle(
                        fontSize: 30, color: Colors.blueAccent);
                  }),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                onPressed: () => {
                      startRecording()

                      ///this is for recording the audio
                    },
                label: Text(is_recording == true
                    ? "Finish Recording"
                    : _testComplete == true
                        ? "Test Complete"
                        : "Start Recording"),
                icon: Icon(is_recording == true
                    ? Icons.mic_external_off
                    : _testComplete == true
                        ? Icons.close
                        : Icons.mic)),
          )),
          Center(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 100, 30, 100),
                  child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.lightBlueAccent;
                          }
                          return Colors.white;
                        }),
                        textStyle: MaterialStateProperty.resolveWith((states) {
                          // If the button is pressed, return size 40, otherwise 20
                          if (states.contains(MaterialState.pressed)) {
                            return const TextStyle(
                                fontSize: 40, color: Colors.blue);
                          }
                          return const TextStyle(
                              fontSize: 30, color: Colors.blueAccent);
                        }),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                      ),
                      label: Text(_testComplete == true
                          ? "Play recording"
                          : "Finish recording"),
                      icon: Icon(
                          _testComplete == true ? Icons.speaker : Icons.close),
                      onPressed: () => {playRecording()})))
        ]),
        floatingActionButton: Visibility(
          visible: _testComplete,
          child: FloatingActionButton.extended(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const DelayedMemoryTaskCheckList()))
                  },
              label: const Text('Next'),
              icon: const Icon(Icons.arrow_forward)),
        ));
  }
}
