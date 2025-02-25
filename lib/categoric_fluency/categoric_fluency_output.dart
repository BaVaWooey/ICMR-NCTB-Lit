// ignore_for_file: camel_case_types

import '../screen/screens.dart';
import 'imports.dart';
import 'package:http/http.dart' as http;

///we will use this page as a placeholder for the output
///
class CategoricFluencyOutput extends StatefulWidget {
  const CategoricFluencyOutput({super.key});

  @override
  State<CategoricFluencyOutput> createState() => _CategoricFluencyOutputState();
}

class _CategoricFluencyOutputState extends State<CategoricFluencyOutput> {
  int finalScore = 0;
  bool scoreComputed = false;
  List<bool> optionCheck = [];

  @override
  void initState() {
    finalScore = 0;
    scoreComputed = false;
    optionCheck = [];
    calculateScore();
    super.initState();
  }

  void calculateScore() async {
    debugPrint("This has been entered");
    String triviaURL = "https://api.api-ninjas.com/v1/textsimilarity",
        apiKey = "3q4LnZuciyHAxQ1tH7KM1Q==eJKPjhRxQxqtz4oI";
    Map<String, String> headers = {'X-Api-Key': apiKey},
        body = {"text_1": "", "text_2": ""};

    for (String element in outputWords) {
      body["text_1"] = category;
      body["text_2"] = element;
      final jsonPass = jsonEncode(body);

      ///pass the http request here as well
      final response = await http.post(Uri.parse(triviaURL),
          headers: headers, body: jsonPass);
      final result = jsonDecode(response.body);
      double actualOutput = result["similarity"];
      if (actualOutput > 0.45) {
        finalScore += 1;
        optionCheck.add(true);
      } else {
        optionCheck.add(false);
      }
    }
    setState(() {
      scoreComputed = true;
    });
    return;

    ///this is where we check for the results
    ///
  }

  int lengthOutput = outputWords.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categoric Fluency Score',
              style: TextStyle(fontSize: 40)),
          toolbarHeight: 100,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Text('OUTPUT',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: outputWords.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: scoreComputed == false
                            ? const Visibility(
                                visible: false, child: Text('sample'))
                            : optionCheck[index] == true
                                ? const Icon(Icons.check, color: Colors.green)
                                : const Icon(Icons.close, color: Colors.red),
                        // leading: scoreComputed == false
                        //     ? Icon(Icons.stop,
                        //         color: Colors.green.withOpacity(0))
                        //     : const Icon(Icons.stop, color: Colors.green),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(outputWords[index],
                            style: const TextStyle(fontSize: 30),
                            textAlign: TextAlign.center));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Text('SCORE',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: scoreComputed == false
                      ? Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: LoadingAnimationWidget.waveDots(
                                color: Colors.black, size: 60),
                          ),
                          const Text('Please Wait',
                              style: TextStyle(fontSize: 20))
                        ])
                      : Text('$finalScore',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Visibility(
                    visible: scoreComputed,
                    child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        color: Colors.grey,
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const rollerSelection(),
                                  ))
                            },
                        child: const Text("EXIT",
                            style: TextStyle(fontWeight: FontWeight.bold)))),
              ),
            )
          ],
        ));
  }
}
