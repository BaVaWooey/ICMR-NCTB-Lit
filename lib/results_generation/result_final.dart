import 'imports.dart';
import '../screen/screens.dart';

class ResultFinalAllTests extends StatefulWidget {
  const ResultFinalAllTests({super.key});

  @override
  State<ResultFinalAllTests> createState() => _ResultFinalAllTestsState();
}

class _ResultFinalAllTestsState extends State<ResultFinalAllTests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          title: Text("Results for $userName",
              style:
                  const TextStyle(fontSize: 35, fontWeight: FontWeight.bold))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ///this will be for phonemic fluency
          ///
          Visibility(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                      child: Text("$userName's Phonemic Fluency Results",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                phonemicFluencyComplete

                    ///the first thing to add will be a row.
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Text("Ma Sound results",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic))),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Text("$finalMaScore",
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic))),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: OutlinedButton(
                                            onPressed: () => {
                                                  ///this will navigator push to the ma score finalization
                                                },
                                            child: const Text(
                                                "Review Ma Results")))
                                  ]),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Text("Pa Sound results",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic))),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Text("$finalPaScore",
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic))),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: OutlinedButton(
                                            onPressed: () => {
                                                  Navigator.popAndPushNamed(
                                                      context,
                                                      "pa score review")

                                                  ///this will navigator push to the pa score finalization
                                                },
                                            child: const Text(
                                                "Review Pa Results")))
                                  ]),
                              Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Text("Ka Sound results",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic))),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Text("$finalKaScore",
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic))),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: OutlinedButton(
                                            onPressed: () => {
                                                  ///this will navigator push to the pa score finalization
                                                },
                                            child: const Text(
                                                "Review Ka Results")))
                                  ])
                            ])))
                    : const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("Please complete the test.")))
              ])),

          ///this will be for categoric fluency
          Visibility(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                      child: Text("$userName's Categoric Fluency Results",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                categoricFluencyComplete
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("To be done")))
                    : const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("Please complete the test.")))
              ])),

          ///this will be for fast
          Visibility(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                      child: Text("$userName's FAST Results",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                FASTComplete
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("To be done")))
                    : const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("Please complete the test.")))
              ])),

          ///this will be for verbal learning
          Visibility(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                      child: Text("$userName's Verbal Learning Results",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                VerbalLearningComplete
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("To be done")))
                    : const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("Please complete the test.")))
              ])),

          ///this will be for delayed recall and recognition
          Visibility(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                      child: Text(
                          "$userName's Delayed Recall and Recognition Results",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                DelayedRecallRecComplete
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("To be done")))
                    : const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(child: Text("Please complete the test.")))
              ]))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text("Return"),
          onPressed: () =>
              {Navigator.popAndPushNamed(context, "roller screen")},
          icon: const Icon(Icons.arrow_back)),
    );
  }
}
