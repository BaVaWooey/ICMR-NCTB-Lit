// import '../verbal_recognition/imports.dart';
import '../screen/screens.dart';
import 'imports.dart';
import '../results_generation/imports.dart';

class VerbalMemoryRecognitionScoring extends StatefulWidget {
  const VerbalMemoryRecognitionScoring({super.key});

  @override
  State<VerbalMemoryRecognitionScoring> createState() =>
      _VerbalMemoryRecognitionScoringState();
}

class _VerbalMemoryRecognitionScoringState
    extends State<VerbalMemoryRecognitionScoring> {
  int t1 = 0, t2 = 0, t3 = 0, delayedMemory = 0, delayedRecall = 0;
  @override
  void initState() {
    debugPrint("This should work");
    computeDelayedRecall();
    computeDelayedRecognition();
    super.initState();
  }

  void computeDelayedRecall() {
    int i = 0;
    while (i < 10) {
      if (delayedMemoryCheck[i] == true) {
        debugPrint(delayedMemoryCheck[i] == true ? "True" : "False");
        delayedMemory += 1;
      }
      i += 1;
    }
    return;
  }

  void computeDelayedRecognition() {
    int i = 0;
    while (i < 20) {
      debugPrint(colorValues[i] == 1 ? "True" : "False");
      if (colorValues[i] == 1) {
        delayedRecall += 1;
      }
      i += 1;
    }
    return;
  }

  void createJsonData(delayedRecall, delayedRecognition) async {
    var jsonObjectDelayed = <String, dynamic>{
      "user_id": "12345",
      "delayed_recall": "",
      "delayed_recognition": "",
    };

    jsonObjectDelayed["delayed_recall"] = delayedRecall.toString();
    jsonObjectDelayed["delayed_recognition"] = delayedRecognition.toString();

    debugPrint(jsonObjectDelayed["user_id"]);
    final directory = await getApplicationSupportDirectory();
    String path = directory.path;

    var trialDirectory = await Directory('$path/verbal_memory/delayed_memory')
        .create(recursive: true);
    path = trialDirectory.path;

    String filePath = '$path/delayed_rr_scores';
    File jsonFile = File(filePath);

    if (jsonFile.existsSync() == false) {
      jsonFile.createSync();
      jsonFile.writeAsStringSync(json.encode({}));
    }
    debugPrint('$path/verbal_memory/delayed_memory');
    // ///we are creating the file
    Map<String, dynamic> existingData =
        json.decode(jsonFile.readAsStringSync());

    existingData.addAll(jsonObjectDelayed);
    debugPrint(existingData.length.toString());
    jsonFile.writeAsStringSync(json.encode(existingData));
    return;
  }

  void createPdfReport() async {
    ////this is specifically for creating a pdf report of all the final results
    final PdfDocument document = PdfDocument();

    final PdfPage page = document.pages.add();

    final Size pageSize = page.getClientSize();

    page.graphics.drawString(
        'User', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(10, 10, 300, 50));

    page.graphics.drawString(
        '12345', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(10, 10, 300, 50));

    File('12345-results.pdf').writeAsBytes(await document.save());

    document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Delayed Memory/Recognition Scores")),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // Container(
          //     child: const Center(
          //         child: Padding(
          //             padding: EdgeInsets.all(15),
          //             child: Text("Total learning",
          //                 style: TextStyle(
          //                     fontSize: 35, fontWeight: FontWeight.bold))))),
          // Container(
          //     child: Center(
          //         child: Padding(
          //             padding: const EdgeInsets.all(15),
          //             child: Column(children: [
          //               ////score for trial 1
          //               Center(
          //                   child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(10, 15, 10, 15),
          //                       child: Text("T1 = $t1",
          //                           style: const TextStyle(
          //                               fontSize: 15,
          //                               fontStyle: FontStyle.italic)))),

          //               ///score for trial 2
          //               Center(
          //                   child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(10, 15, 10, 15),
          //                       child: Text("T2 = $t2",
          //                           style: const TextStyle(
          //                               fontSize: 15,
          //                               fontStyle: FontStyle.italic)))),

          //               ///score for trial 3
          //               Center(
          //                   child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(10, 15, 10, 15),
          //                       child: Text("T3 = $t3",
          //                           style: const TextStyle(
          //                               fontSize: 15,
          //                               fontStyle: FontStyle.italic)))),
          //               Center(
          //                   child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(10, 15, 10, 15),
          //                       child: Text("T1 + T2 + T3 = ${t1 + t2 + t3}",
          //                           style: const TextStyle(
          //                               fontSize: 15,
          //                               fontStyle: FontStyle.italic))))

          //               ///total score over all compartments
          //             ])))),
          // Container(
          //     child: const Center(
          //         child: Padding(
          //             padding: EdgeInsets.all(15),
          //             child: Text("Learning Over Trials",
          //                 style: TextStyle(
          //                     fontSize: 35, fontWeight: FontWeight.bold))))),
          // Center(
          //     child: Padding(
          //         padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          //         child: Text("3T1 - T1 - T2 - T3 = ${t2 + t3 - (2 * t1)}",
          //             style: const TextStyle(
          //                 fontSize: 15, fontStyle: FontStyle.italic)))),
          Container(
              child: const Center(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Delayed Recall",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold))))),
          Center(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Text("Score = $delayedMemory/10",
                      style: const TextStyle(
                          fontSize: 15, fontStyle: FontStyle.italic)))),
          Container(
              child: const Center(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Delayed Recognition",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold))))),
          Center(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Text("Score = $delayedRecall/20",
                      style: const TextStyle(
                          fontSize: 15, fontStyle: FontStyle.italic)))),
          Center(
              child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: Colors.lightBlue,
                  child: const Text("Submit Final Results",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () => {
                        setState(
                            () => final_scores[5] = delayedMemory.toString()),
                        setState(
                            () => final_scores[6] = delayedRecall.toString())
                      })),
          Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  color: Colors.blue,
                  child: const Text("Return",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () => {
                    ///call function for saving data in json.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const rollerSelection()))

                    ///
                  },
                )),
          )
        ]));
  }
}
