// ignore: file_names
import '../screen/screens.dart';
import 'imports.dart';

class CategoricTempResults extends StatefulWidget {
  const CategoricTempResults({super.key});

  @override
  State<CategoricTempResults> createState() => _CategoricTempResultsState();
}

class _CategoricTempResultsState extends State<CategoricTempResults> {
  bool audioReplayed = false, audioPlaying = false;
  bool testScoreComputed = false;
  List<bool> iconCheck = [];
  String audioPath = "";
  final myController = TextEditingController(),
      scoreController = TextEditingController();
  @override
  void initState() {
    listResults = [];
    audioReplayed = false;
    audioPlaying = false;
    audioPath = pathStorage;
    super.initState();
  }

  void replayAudio() async {
    if (audioReplayed == true) return;
    setState(() {
      audioReplayed = true;
    });
    /////code for replaying audio
    await player.setFilePath(audioPath);
    setState(() {
      audioPlaying = true;
    });
    await player.play();
    setState(() {
      audioPlaying = false;
    });
    setState(() {
      audioReplayed = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 100,
            title: const Text("Reviewing Results",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Center(
              child: MaterialButton(
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                  color: Colors.green,
                  child:
                      const Icon(Icons.replay, size: 80, color: Colors.white),
                  onPressed: () => {
                        replayAudio()
                        ////this is where the function for replaying the audio will be at.
                      })),
          Center(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: listResults.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                    child: Card(
                        elevation: 1,
                        child: ListTile(
                            leading: MaterialButton(
                                onPressed: () => {
                                      ///this will remove the value from the list
                                      setState(() {
                                        listResults.removeAt(index);
                                      })
                                    },
                                child:
                                    const Icon(Icons.close, color: Colors.red)),
                            title: Text(
                              listResults[index],
                              textAlign: TextAlign.center,
                            ))),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Text("Add the entries ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: Text("(Scroll upon adding more than two)",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(200, 0, 200, 0),
                    child: TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Input Text',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        color: Colors.blue,
                        onPressed: () => {
                              setState(() {
                                listResults.add(myController.text);
                                myController.text = "";
                              })
                            },
                        child: const Text("Submit",
                            style:
                                TextStyle(fontSize: 30, color: Colors.white))),
                  )
                ]),
          ),
          Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
              decoration: BoxDecoration(border: Border.all()),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(200, 0, 200, 0),
                      child: TextField(
                        controller: scoreController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Final Score',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        color: Colors.blue,
                        onPressed: () => {
                              setState(() {
                                finalScore = scoreController.text;
                                scoreController.text = "";
                              })
                            },
                        child: const Text("Submit Score",
                            style:
                                TextStyle(fontSize: 30, color: Colors.white))),
                  )
                ],
              )),
        ]),
        floatingActionButton: Visibility(
          visible: !audioPlaying,
          child: FloatingActionButton.extended(
              label: const Text("Next"),
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => {
                    if (currentElement == 'fruit')
                      {
                        setState(() {
                          int i = 0;
                          while (i < listResults.length) {
                            fruitResults.add(listResults[i]);
                            i += 1;
                          }
                          fruitScore = finalScore;
                        })
                      }
                    else if (currentElement == 'animal')
                      {
                        setState(() {
                          int i = 0;
                          while (i < listResults.length) {
                            animalResults.add(listResults[i]);
                            i += 1;
                          }
                          animalScore = finalScore;
                        })
                      }
                    else if (currentElement == 'vehicle')
                      {
                        setState(() {
                          int i = 0;
                          while (i < listResults.length) {
                            vehicleResults.add(listResults[i]);
                            i += 1;
                          }
                          vehicleScore = finalScore;
                        })
                      },
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => currentElement == 'animal'
                              ? const CategoricFluencyFruit()
                              : (currentElement == 'fruit'
                                  ? const CategoricFluencyVehicle()
                                  : const CategoricFluencyReport()),
                        ))
                  }),
        ));
  }
}
