import '../screen/screens.dart';
import 'imports.dart';

import 'package:http/http.dart' as http;

////goals for this application
///record and store the audio in a directory.

class PhonemicManualRecording extends StatefulWidget {
  const PhonemicManualRecording({super.key});

  @override
  State<PhonemicManualRecording> createState() =>
      _PhonemicManualRecordingState();
}

class _PhonemicManualRecordingState extends State<PhonemicManualRecording> {
  String pathStorage = "";

  @override

  ///we will define the functions for recording the audio here
  void initState() {
    outputValues = [];
    recordingSent = false;
    recordingOn = false;
    recordingInProgress = false;
    recordingComplete = false;
    timerValue = 0;
    super.initState();
  }

  void recordingStart() async {
    setState(() {
      recordingOn = true;
      recordingInProgress = true;
    });

    ////here we will create the directory where the audio will be stored

    final directory = await getApplicationSupportDirectory();
    String path = directory.path;
    var finalDirectory = await Directory('$path/phonemic_fluency/pa_sound')
        .create(recursive: true);
    path = finalDirectory.path;
    String filePath = '$path/sound_init.wav';

    ///This is where the recording starts after the button has been pressed

    await record.start(const RecordConfig(), path: filePath);
    while (timerValue < 5) {
      debugPrint('This has been entered');
      await Future.delayed(const Duration(seconds: 1));
      setState(() => (timerValue += 1));
    }
    await record.stop();

    setState(() {
      pathStorage = filePath.substring(1);
    });
    ////
    // debugPrint("this was the first");
    await sendAudioAndObtainResult();
    // debugPrint("This was the second");
    setState(() {
      recordingInProgress = false;
      recordingComplete = true;
    });
    return;
  }

  Future<void> sendAudioAndObtainResult() async {
    ////this is where the api requests take place.
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://asr.iiit.ac.in/ssmtapi//'));

    ///the headers of the request element is defined here as well.
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['accept'] = 'application/json';

    ///we define the form fields section of the request variable.
    request.fields['lang'] = 'eng';

    debugPrint(pathStorage);

    ///finally, we add the files necessary to the http requets element. For now, this is the recorded audio that has been stored in the path.
    request.files.add(await http.MultipartFile.fromPath(
        'uploaded_file', pathStorage,
        contentType: MediaType("audio", "x-wav")));

    ///we finally determine a response element, that is a obtained from sending the request.
    var response = await request.send();
    String respStr = await response.stream.bytesToString();
    respStr = replaceOutputFunction(respStr);
    setState(() {
      outputValues = respStr.split(" ");
      outputValues.removeWhere((i) => i == "");
      recordingSent = true;
    });
    capitalizeWords();
    for (String element in outputValues) {
      debugPrint(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text('Phonemic (Manual)', style: TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: Column(children: [
          ///This will tell the user the kind of phoneme for which they will have to state words
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 70, 40, 30),
            child: Center(
                child: Text.rich(TextSpan(
                    text: 'The phoneme for this test will be ',
                    style: const TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                  TextSpan(
                      text: phonemeType,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ))
                ]))),
          ),

          ///This will include a mechanism for recorrding the words
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 70, 40, 30),
            child: Center(
                child: Text(
                    'Press the button below when you are ready to begin.',
                    style: TextStyle(fontSize: 30))),
          ),

          ///button for recording words
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 70, 40, 30),
            child: Center(
                child: MaterialButton(
                    color: Colors.blue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    onPressed: () => {
                          if (recordingOn == false &&
                              recordingInProgress == false &&
                              recordingComplete == false)
                            {
                              recordingStart()

                              ///here we call the function for recording the audio
                            }
                        },
                    child: recordingOn == false
                        ? const Icon(Icons.mic_external_off,
                            color: Colors.white, size: 30)
                        : const Icon(Icons.mic_external_on))),
          ),

          ///will tell us about the current status of the recording
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 70, 40, 30),
            child: Center(
                child: Text('The recording is in progress.',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          )
        ]),
        floatingActionButton: Visibility(
            visible: recordingComplete,
            child: FloatingActionButton.large(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PhonemicManualResults()))
                    },
                child: const Icon(Icons.arrow_forward))));
  }
}
