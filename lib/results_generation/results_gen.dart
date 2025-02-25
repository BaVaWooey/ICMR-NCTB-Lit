import 'imports.dart';
import '../screen/screens.dart';

class resultsScreenFinal extends StatefulWidget {
  const resultsScreenFinal({super.key});

  @override
  State<resultsScreenFinal> createState() => _resultsScreenFinalState();
}

class MapItem {
  var user_id,
      phonemic_score,
      fast_writing_score,
      fast_expression_score,
      fast_comprehension_score,
      verbal_immediate,
      verbal_delayed_recall,
      verbal_delayed_recognition;

  MapItem(
      {this.user_id,
      this.phonemic_score,
      this.fast_expression_score,
      this.fast_comprehension_score,
      this.fast_writing_score,
      this.verbal_immediate,
      this.verbal_delayed_recall,
      this.verbal_delayed_recognition});

  MapItem.fromJson(var jsonVal)
      : user_id = jsonVal["user_id"],
        phonemic_score = jsonVal["Phonemic Fluency"],
        fast_writing_score = jsonVal["FAST - Writing"],
        fast_expression_score = jsonVal["FAST - Expression"],
        fast_comprehension_score = jsonVal["FAST - Comprehension"],
        verbal_immediate = jsonVal["Verbal Memory Immediate Recall"],
        verbal_delayed_recall = jsonVal["Verbal Memory Delayed Recall"],
        verbal_delayed_recognition =
            jsonVal["Verbal Memory Delayed Recognition"];

  Map<String, dynamic> toJson() {
    return {
      "user_id": user_id,
      "Phonemic Fluency": phonemic_score,
      "FAST - Writing": fast_writing_score,
      "FAST - Expression": fast_expression_score,
      "FAST - Comprehension": fast_comprehension_score,
      "Verbal Memory Immediate Recall": verbal_immediate,
      "Verbal Memory Delayed Recall": verbal_delayed_recall,
      "Verbal Memory Delayed Recognition": verbal_delayed_recognition
    };
  }
}

class _resultsScreenFinalState extends State<resultsScreenFinal> {
  int total_count = 0;
  @override
  void initState() {
    total_count = 0;
    init_total_count();
    super.initState();
  }

  void init_total_count() {
    for (var elem in final_scores) {
      total_count += elem != 'Null' ? 1 : 0;
    }
  }

  void dummy_function() async {
    return;
  }

  void write_into_json() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    var resultsDirectory =
        await Directory('$path/results').create(recursive: true);
    //debugPrint(await resultsDirectory.exists() ? "1" : "0");
    final dataPath = resultsDirectory.path;
    String finalPath = '$dataPath/output.json';
    var jsonData = {
      "user_id": "1234",
      test_names[0]: final_scores[0],
      test_names[1]: final_scores[1],
      test_names[2]: final_scores[2],
      test_names[3]: final_scores[3],
      test_names[4]: final_scores[4],
      test_names[5]: final_scores[5],
      test_names[6]: final_scores[6],
      test_names[7]: final_scores[7],
      test_names[8]: final_scores[8],
      test_names[9]: final_scores[9]
    };
    //String jsonFin = jsonEncode(list);

    debugPrint(finalPath);
    final finalFile = File(finalPath);
    // finalFile.writeAsBytes([]);
    // finalFile.writeAsStringSync(jsonFin);
    finalFile.writeAsStringSync('[]');
    debugPrint(await finalFile.exists() == true ? "1" : "0");
    final scoreMap = jsonDecode(finalFile.readAsStringSync());
    final user = MapItem.fromJson(jsonData);
    String final_output = json.encode(user);
    finalFile.writeAsStringSync(final_output);
    debugPrint(finalFile.readAsStringSync());
    // var jsonContents = await finalFile.readAsString();
    // debugPrint(json.decode(jsonContents));
    // // var jsonContents_1 = await finalFile.readAsString();
    // // debugPrint(jsonContents_1);
    // // debugPrint(json.decode(jsonContents_1));
    // String output = json.encode(jsonData);
    // debugPrint(output);
    //debugPrint(data);

    /*
var final_scores = [
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
];
var test_names = [
  'Phonemic Fluency',
  'FAST - Comprehension',
  'FAST - writing',
  'FAST - reading',
  'Verbal Memory Immediate Recall',
  'Verbal Memory Delayed Recall',
  'Verbal Memory Delayed Recognition'
];
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Current Results",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: final_scores.length,
                itemBuilder: (context, index) {
                  final name = test_names[index];
                  final value = final_scores[index];

                  return Align(
                    child: SizedBox(
                      height: 100,
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          title: Text(name,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          subtitle: value == 'Null'
                              ? const Text("Score not computed")
                              : Text(value),
                          trailing: value == 'Null'
                              ? MaterialButton(
                                  shape: const CircleBorder(),
                                  color: Colors.red,
                                  onPressed: () => {},
                                  child: const Icon(Icons.close,
                                      color: Colors.white))
                              : MaterialButton(
                                  shape: const CircleBorder(),
                                  onPressed: () => {},
                                  color: Colors.green,
                                  child: const Icon(Icons.check),
                                )),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Center(
                  child: MaterialButton(
                onPressed: () => {
                  total_count == 10 ? write_into_json() : dummy_function()

                  ///this will export the value to a json file.
                },
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                color: total_count == 7 ? Colors.green : Colors.grey,
                child: Text(total_count == 7 ? "Export" : "Finish all tests",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Center(
                  child: MaterialButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const rollerSelection(),
                      ))
                },
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                color: Colors.green,
                child: const Text("Return",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              )),
            )
          ],
        ));
  }
}
