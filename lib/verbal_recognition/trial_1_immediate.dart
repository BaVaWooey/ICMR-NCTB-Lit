import 'imports.dart';
import '../screen/screens.dart';
import 'package:http/http.dart' as http;

////code for recording voice file and obtaining output

class VerbalImmediate extends StatefulWidget {
  const VerbalImmediate({super.key});

  @override
  State<VerbalImmediate> createState() => _VerbalImmediateState();
}

class _VerbalImmediateState extends State<VerbalImmediate> {
  double recordingTime = 0;
  String pathStorage = "";
  int countDown = 5;
  late ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
  @override
  void initState() {
    immediateRecordingResultsObtained = false;
    countDown = 5;
    recordingTime = 0;
    immediateRecordingInProgress = false;
    immediateRecordingSent = false;
    immediateRecordingComplete = false;
    startRecording();
    super.initState();
  }

  void startRecording() async {
    setState(() {
      immediateRecordingInProgress = true;
    });
    final directory = await getApplicationSupportDirectory();
    String path = directory.path;
    var firstTrialDirectory =
        await Directory('$path/verbal_fluency/first_trial')
            .create(recursive: true);
    path = firstTrialDirectory.path;
    String filePath = '$path/input.wav';
    ////this is the start of the warning that the recording will start.
    while (countDown > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        countDown -= 1;
      });
    }

    ///this is where the recording actually starts.
    await record.start(const RecordConfig(), path: filePath);
    while (recordingTime <= 20) {
      debugPrint("$recordingTime");
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        recordingTime += 1;
        valueNotifier.value = (recordingTime / 2) * 10;
      });
    }
    await record.stop();
    setState(() {
      pathStorage = filePath.substring(1);
      immediateRecordingInProgress = false;
      immediateRecordingSent = true;
    });
    sendAudioAndGetResult();

    ///this will ensure that the recording is delayed by 5 seconds

    return;
  }

  void sendAudioAndGetResult() async {
    ///this is for sending the audio that was recorded
    debugPrint("This has been entered");
    ////this is where the api requests take place.
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://asr.iiit.ac.in/ssmtapi//'));

    ///the headers of the request element is defined here as well.
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['accept'] = 'application/json';

    ///we define the form fields section of the request variable.
    request.fields['lang'] = 'eng';

    ///finally, we add the files necessary to the http requets element. For now, this is the recorded audio that has been stored in the path.
    request.files.add(await http.MultipartFile.fromPath(
        'uploaded_file', pathStorage,
        contentType: MediaType("audio", "x-wav")));

    ///we finally determine a response element, that is a obtained from sending the request.
    setState(() {
      immediateRecordingSent = false;
      immediateRecordingResultsObtained = true;
    });
    var response = await request.send();
    String respStr = await response.stream.bytesToString();
    respStr = replaceOutputFunction(respStr);
    setState(() {
      immediateRecordingSent = false;
      outputValues = respStr.split(" ");
      outputValues.removeWhere((i) => i == "");
    });
    for (String element in outputValues) {
      debugPrint(element);
      if (allRecitals[0].contains(element) == true) {
        setState(() {
          correctCount += 1;
        });
        debugPrint('Correct');
      } else {
        setState(() {
          wrongCount += 1;
        });
        debugPrint('Wrong');
      }
    }
    setState(() {
      recitalCount += 1;
      missedCount += (10 - correctCount);
      immediateRecordingResultsObtained = false;
      immediateRecordingComplete = true;
    });
    debugPrint('$correctCount, $wrongCount, $missedCount');

    ///we have the scores now.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text('Immediate Recall', style: TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
              child: Center(
                  child: countDown > 0
                      ? Text('The recording starts in $countDown seconds.',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))
                      : const Text('The recording has started.',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)))),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
              child: Center(
                  child: SimpleCircularProgressBar(
                mergeMode: true,
                valueNotifier: valueNotifier,
                size: 180,
                progressStrokeWidth: 20,
                backStrokeWidth: 5,
              ))),
          Visibility(
            visible: immediateRecordingSent && !immediateRecordingInProgress,
            child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 70, 30, 30),
                child: Center(
                    child: Text('The recorded data is being processed.',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)))),
          ),
          Visibility(
            visible: immediateRecordingResultsObtained,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
                child: Center(
                    child: Text(
                        'Your result for trail $recitalCount is being computed.',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)))),
          )
        ]),
        floatingActionButton: Visibility(
          visible: immediateRecordingComplete,
          child: FloatingActionButton.extended(
              label: const Text('Next'),
              onPressed: () {
                if (recitalCount < 4) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerbalRecognitionReciting(),
                      ));
                } else {
                  debugPrint('Immediate Recall Done.');
                }
              },
              icon: const Icon(Icons.arrow_right)),
        ));
  }
}
