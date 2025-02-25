import 'imports.dart';
import '../screen/screens.dart';

///since we will have to use the abbreviated version of the module, we will import it separately for every file
import 'package:http/http.dart' as http;

class PhonemicFluencyKa extends StatefulWidget {
  const PhonemicFluencyKa({super.key});

  @override
  State<PhonemicFluencyKa> createState() => _PhonemicFluencyKaState();
}

class _PhonemicFluencyKaState extends State<PhonemicFluencyKa> {
  @override
  void initState() {
    setState(() {
      currentElement = "k";
      phonemicRecordingComplete = false;
      phonemicRecordingInProgress = false;
      phonemicRecordingSent = false;
      timerValue = 0;
    });
    super.initState();
  }

  ///define a recording function
  ///only the recording and storing of audio will take place in this function
  ///
  void recordingFunction() async {
    //create directory and check if it exists
    final directory = await getApplicationSupportDirectory();
    String path = directory.path;
    var kaDirectory = await Directory('$path/phonemic_fluency/ka_sound')
        .create(recursive: true);
    path = kaDirectory.path;
    String filePath = '$path/sound_1.wav';
    if (phonemicRecordingComplete == true ||
        phonemicRecordingInProgress == true) {
      return;
    }

    ///recording starts here
    setState(() {
      phonemicRecordingInProgress = true;
    });
    await record.start(
        bitRate: 128000, encoder: AudioEncoder.wav, path: filePath);
    while (timerValue < 5) {
      debugPrint('This has been entered');
      await Future.delayed(const Duration(seconds: 1));
      setState(() => (timerValue += 1));
    }
    await record.stop();
    setState(() {
      pathStorage = filePath.substring(1);
      phonemicRecordingInProgress = false;
      phonemicRecordingComplete = true;
      phonemicRecordingSent = true;
    });
    // sendAudioAndObtainResult();

    ///recording ends here
  }

  ///define a function where the audio will be sent to api for results. the results will be stored here.
  ///
  ///
  void sendAudioAndObtainResult() async {
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
    var response = await request.send();
    String respStr = await response.stream.bytesToString();
    respStr = replaceOutputFunction(respStr);
    setState(() {
      outputValues = respStr.split(" ");
      outputValues.removeWhere((i) => i == "");
      phonemicRecordingSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Phonemic Fluency (Ka)',
              style: TextStyle(fontSize: 40)),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Column(children: [
          //// instructions
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
              child: Text(phonemicKaInstruction,
                  style: const TextStyle(
                      fontSize: 25, fontStyle: FontStyle.italic, height: 1.5))),

          /// button for recording
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
              child: Center(
                  child: MaterialButton(
                      padding: const EdgeInsets.all(20),
                      color: Colors.grey,
                      shape: const CircleBorder(),
                      onPressed: () => {
                            debugPrint(
                                "The recording function has been elicited."),
                            if (phonemicRecordingComplete == false &&
                                phonemicRecordingInProgress == false)
                              {recordingFunction()}

                            ///this will start the recording
                          },
                      child: (phonemicRecordingInProgress == true ||
                              phonemicRecordingComplete == true)
                          ? const Icon(Icons.mic_off, size: 60)
                          : const Icon(Icons.mic, size: 60)))),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
              child: Center(
                  child: phonemicRecordingInProgress == true
                      ? const Text("The recording is in progress.",
                          style: TextStyle(fontSize: 25, color: Colors.red))
                      : (phonemicRecordingComplete == true
                          ? const Text("The recording has been completed.",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.green))
                          : const Text("Press the button above to record.",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.blue)))))

          /// status of recording
          /// the button for continuation to results
        ]),
        floatingActionButton: Visibility(
            visible: phonemicRecordingSent,
            child: FloatingActionButton.extended(
                label: const Text('Next'),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PhonemicTempResults()))
                    })));
  }
}
