import '../screen/screens.dart';
import 'imports.dart';
import 'package:http/http.dart' as http;

class CategoricFluencyAnimal extends StatefulWidget {
  const CategoricFluencyAnimal({super.key});

  @override
  State<CategoricFluencyAnimal> createState() => _CategoricFluencyAnimalState();
}

class _CategoricFluencyAnimalState extends State<CategoricFluencyAnimal> {
  /// variable for timer class
  int timerValue = 5;
  Future<Directory?>? directory;
  Future<String?>? path;
  @override
  void initState() {
    timerValue = 5;
    categoricFluencyRecordingInProgress = false;
    categoricFluencyAnimalComplete = false;
    category = "animal";
    super.initState();
  }

  void changeTimerValue() async {
    if (categoricFluencyRecordingInProgress == true ||
        categoricFluencyAnimalComplete == true) {
      return;
    }
    while (timerValue > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timerValue -= 1;
      });
    }
    setState(() {
      categoricFluencyAnimalComplete = true;
    });
    return;
  }

  void recordAndPost() async {
    ///directory where app will directly write into
    final directory = await getApplicationSupportDirectory();
    String path = directory.path;

    ///checking condition
    if (categoricFluencyRecordingInProgress == true ||
        categoricFluencyAnimalComplete == true) {
      return;
    }

    ///

    ///we set the state to ensure that duplication of the recording process does not happen
    setState(() {
      categoricFluencyRecordingInProgress = true;
    });
    ////
    ///creating a directory for animal related categoric fluency audio to be stored in
    var newDirectory = await Directory('$path/animal').create(recursive: true);

    ///A path has been created for the file to work with.
    path = newDirectory.path;
    String newPath = '$path/newFile.wav';

    ///this is the recording process. it will be set for a 'x' amount of time, which is determined by the loop inside.

    await record.start(
        bitRate: 128000, encoder: AudioEncoder.wav, path: newPath);
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
    }
    await record.stop();

    /// end of the recording process

    ///for converting the newpath to a correct substring

    newPath = newPath.substring(1);

    ///(((((( BACKEND REQUESTS ))))))

    ///we create the request variable which will be used in the http post request.
    ///it is declared to be multi-part, a POST request and has the URI parsed as given below.
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://asr.iiit.ac.in/ssmtapi//'));

    ///the headers of the request element is defined here as well.
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['accept'] = 'application/json';

    ///we define the form fields section of the request variable.
    request.fields['lang'] = 'eng';

    ///finally, we add the files necessary to the http requets element. For now, this is the recorded audio that has been stored in the path.
    request.files.add(await http.MultipartFile.fromPath(
        'uploaded_file', newPath,
        contentType: MediaType("audio", "x-wav")));

    ///we finally determine a response element, that is a obtained from sending the request.
    var response = await request.send();
    String respStr = await response.stream.bytesToString();
    respStr = replaceOutputFunction(respStr);

    ///
    ///we 'unset' the recording variable.
    setState(() {
      outputWords = respStr.split(" ");
      outputWords.removeWhere((i) => i == "");
      categoricFluencyRecordingInProgress = false;
    });
    //////function completed, returned.
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Categoric Fluency Animal', style: TextStyle(fontSize: 40)),
            Icon(Icons.pets_sharp, size: 50, color: Colors.yellow)
          ]),
          centerTitle: true,
          toolbarHeight: 100),

      ///next we have instructions for the fluency test food
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
            child: Text(categoryFluencyAnimalInstruction,
                style: const TextStyle(fontSize: 30, height: 1.5))

            ///
            ),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 130, 30, 0),
            child: MaterialButton(
                onPressed: () => {
                      changeTimerValue(),
                      recordAndPost()

                      ///starts a timer function and a recording function
                    },
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                color: Colors.blue,
                child: categoricFluencyAnimalComplete == false
                    ? SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          value: (timerValue / 5).toDouble(),

                          ///here we define a variable,
                          color: Colors.blue,
                          backgroundColor: Colors.black,
                        ),
                      )
                    : const Icon(Icons.close, size: 60))),
        Padding(
            padding: const EdgeInsets.fromLTRB(40, 130, 30, 0),
            child: categoricFluencyRecordingInProgress == true
                ? const Text('Recording is taking place',
                    style: TextStyle(
                        fontSize: 30, height: 1.5, color: Colors.green))
                : const Text('Recording is not taking place',
                    style: TextStyle(
                        fontSize: 30, height: 1.5, color: Colors.red))),
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 130, 30, 0),
            child: categoricFluencyAnimalComplete == false
                ? const Text(
                    'You have not completed the test yet. Please complete it before you proceed to the next one.',
                    style: TextStyle(fontSize: 30, height: 1.5))
                : Text(categoricFluencyCompletedAnimal,
                    style: const TextStyle(
                        fontSize: 30,
                        height: 1.5))) // add variable property here
      ]),
      floatingActionButton: Visibility(
          visible: categoricFluencyAnimalComplete == true &&
                  categoricFluencyRecordingInProgress == false
              ? true
              : false, ////add variable property here
          child: FloatingActionButton.large(
            child: const Icon(Icons.arrow_forward),
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoricFluencyOutput()))

              ///this is for navigating to the results page
            },
          )),
    );
  }
}
