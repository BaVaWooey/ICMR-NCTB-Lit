import '../screen/screens.dart';
import 'imports.dart';
import 'package:just_audio/just_audio.dart';

class PaScoreReview extends StatefulWidget {
  const PaScoreReview({super.key});

  @override
  State<PaScoreReview> createState() => _PaScoreReviewState();
}

class _PaScoreReviewState extends State<PaScoreReview> {
  final myController = TextEditingController(),
      scoreController = TextEditingController();

  bool audioPlaying = false;
  final player = AudioPlayer();

  List<String> listResults = [];

  int finalScore = 0;
  @override
  void initState() {
    audioPlaying = false;
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void replayAudio() async {
    if (audioPlaying == true) return;
    setState(() {
      audioPlaying = true;
    });
    /////code for replaying audio
    await player.setFilePath(finalUserPaDirectory);
    await player.play();
    setState(() {
      audioPlaying = player.playing;
    });
    setState(() {
      audioPlaying = false;
    });
    setState(() {
      audioPlaying = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Reviewing $userName's results",
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            centerTitle: true,
            toolbarHeight: 100),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // Center(
          //     child: MaterialButton(
          //         padding: const EdgeInsets.all(16),
          //         shape: const CircleBorder(),
          //         color: Colors.green,
          //         child:
          //             const Icon(Icons.replay, size: 80, color: Colors.white),
          //         onPressed: () => {
          //               replayAudio()
          //               ////this is where the function for replaying the audio will be at.
          //             })),
          const ProgressBar(
            progress: Duration.zero,
            total: Duration.zero,
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: 32.0,
            onPressed: () {},
          ),
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
                        keyboardType: TextInputType.number,
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
                                finalScore = int.parse(scoreController.text);
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
        floatingActionButton: FloatingActionButton.extended(
            label: const Text("Return"),
            onPressed: () => {Navigator.popAndPushNamed(context, "results")},
            icon: const Icon(Icons.arrow_back)));
  }
}
