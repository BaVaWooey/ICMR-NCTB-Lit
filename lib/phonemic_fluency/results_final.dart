import 'imports.dart';
import '../screen/screens.dart';

class PhonemicResultsFinal extends StatefulWidget {
  const PhonemicResultsFinal({super.key});

  @override
  State<PhonemicResultsFinal> createState() => _PhonemicResultsFinalState();
}

class _PhonemicResultsFinalState extends State<PhonemicResultsFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Final Results (Phonemic Fluency)",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Text(
                  finalMaScore != 0
                      ? "Ma Score - $finalMaScore"
                      : "Ma Scoring has either not been done, or the value is 0",
                  style: const TextStyle(
                      fontSize: 30,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Text(
                  finalPaScore != 0
                      ? "Pa Score - $finalPaScore"
                      : "Pa Scoring has either not been done, or the value is 0",
                  style: const TextStyle(
                      fontSize: 30,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Text(
                  finalKaScore != 0
                      ? "Ka Score - $finalKaScore"
                      : "Ka Scoring has either not been done, or the value is 0.",
                  style: const TextStyle(
                      fontSize: 30,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                testsComplete += 1;
                phonemicFluencyComplete = true;
              });
              Navigator.popAndPushNamed(context, "roller screen");
            },
            label: const Text("Next"),
            icon: const Icon(Icons.arrow_forward)));
  }
}
