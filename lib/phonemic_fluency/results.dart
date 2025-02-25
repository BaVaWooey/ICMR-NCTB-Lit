import 'imports.dart';
import '../screen/screens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhonemicResults extends StatefulWidget {
  const PhonemicResults({super.key});

  @override
  State<PhonemicResults> createState() => _PhonemicResultsState();
}

class _PhonemicResultsState extends State<PhonemicResults> {
  bool buttonInDisplay = false;
  bool testScoreComputed = false;
  int finalScore = 0;
  List<bool> iconCheck = [];
  @override
  void initState() {
    debugPrint(currentElement);
    iconCheck = [];
    buttonInDisplay = false;
    testScoreComputed = false;
    finalScore = 0;
    capitalize();
    computeTestScore();
    super.initState();
  }

  void capitalize() {
    for (String element in outputValues) {
      debugPrint("This has been check");
      setState(() {
        element = element.replaceFirst(element[0], element[0].toUpperCase());
      });

      return;
    }
  }

  void computeTestScore() async {
    String url = "";
    debugPrint("computing the score");

    ///we will first check for all the words that exist + start with ma
    for (String element in outputValues) {
      if (element[0] == currentElement) {
        /////this is the part where we will send http requests to the dictionary api
        url = "https://api.dictionaryapi.dev/api/v2/entries/en/$element";
      } else {
        url =
            "https://api.dictionaryapi.dev/api/v2/entries/en/$currentElement$element";
      }
      final output = await http.get(Uri.parse(url));
      final checkValue = jsonDecode(output.body);
      if ('$checkValue'[0] == "[") {
        finalScore += 1;
        iconCheck.add(true);
      } else {
        iconCheck.add(false);
      }
    }
    setState(() {
      testScoreComputed = true;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Phonemic Fluency (Results)',
              style: TextStyle(fontSize: 40)),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Obtained Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: outputValues.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 10,
                  child: Card(
                      elevation: 1,
                      child: ListTile(
                          leading: testScoreComputed == false
                              ? Icon(Icons.close,
                                  color: Colors.green.withOpacity(0))
                              : iconCheck[index] == true
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : const Icon(Icons.close, color: Colors.red),
                          title: Text(
                            outputValues[index],
                            textAlign: TextAlign.center,
                          ))),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Score',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  )),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(children: [
                Center(
                    child: Visibility(
                        visible: !testScoreComputed,
                        child: const Text("Please wait.",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)))),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: testScoreComputed == true
                            ? Text('$finalScore',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 30))
                            : LoadingAnimationWidget.waveDots(
                                color: Colors.black, size: 30)))
              ])),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Visibility(
                  visible: testScoreComputed,
                  child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      color: Colors.grey,
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const rollerSelection(),
                                ))
                          },
                      child: const Text("EXIT",
                          style: TextStyle(fontWeight: FontWeight.bold)))),
            ),
          )
        ]));
  }
}
