import 'imports.dart';
import '../screen/screens.dart';

///this is for importing the files into your code.
class DelayedRecognitionTask extends StatefulWidget {
  const DelayedRecognitionTask({super.key});

  @override
  State<DelayedRecognitionTask> createState() => _DelayedRecognitionTaskState();
}

class _DelayedRecognitionTaskState extends State<DelayedRecognitionTask> {
  bool _testComplete = false, testBegin = false, wordStated = false;
  int timerCount = 5, currWordCount = 0;
  @override
  void initState() {
    wordStated = false;
    _testComplete = false;
    testBegin = false;
    timerCount = 5;
    currWordCount = 0;
    startTimer();
    functionChange();
    super.initState();
  }

  void startTimer() async {
    while (timerCount > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        timerCount -= 1;
      });
    }
    setState(() {
      testBegin = true;
    });
  }

  void sayWord() async {
    //this is for stating the word.
    setState(() {
      wordStated = true;
    });
    var audioWord = wordToAudio[delayedRecognitionWords[currWordCount]]!;

    ///once we do this, we will start to state the word involved in the process
    await player.setAsset(audioWord);

    await player.play();

    setState(() {
      debugPrint("Entered");
      wordStated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Delayed Recognition Test",
                style: TextStyle(fontSize: 40)),
            toolbarHeight: 100),
        body: _testComplete == true
            ? const Center(
                child: Text("Test is over",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)))
            : testBegin == false
                ? Center(
                    child: Container(
                        child: Text(timerCount.toString(),
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold))))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                            child: Center(
                                child: MaterialButton(
                                    color: Colors.blue,
                                    child: const Icon(Icons.volume_up,
                                        color: Colors.white),
                                    onPressed: () => {
                                          if (wordStated == false)
                                            {
                                              debugPrint("Here"),
                                              sayWord(),
                                              setState(() {
                                                wordStated = false;
                                              })
                                            }

                                          ///this will say the word.
                                        }))),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                            child: Center(
                                child: Text(
                                    delayedRecognitionWords[currWordCount],
                                    style: TextStyle(
                                        fontSize: 45,
                                        fontWeight:
                                            wordCorrectness[currWordCount] ==
                                                    true
                                                ? FontWeight.bold
                                                : FontWeight.normal)))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                  child: const Icon(Icons.check),
                                  onPressed: () => {
                                        if (wordCorrectness[currWordCount] ==
                                            true)
                                          {
                                            setState(() {
                                              colorValues[currWordCount] = 1;
                                            })
                                          }
                                        else
                                          {
                                            setState(() {
                                              colorValues[currWordCount] = -1;
                                            })
                                          },
                                        if (currWordCount < 19)
                                          setState(() {
                                            currWordCount += 1;
                                          })
                                        else
                                          setState(() {
                                            _testComplete = true;
                                          })
                                      }),
                              MaterialButton(
                                  child: const Icon(Icons.close),
                                  onPressed: () => {
                                        if (wordCorrectness[currWordCount] ==
                                            false)
                                          {
                                            setState(() {
                                              colorValues[currWordCount] = 1;
                                            })
                                          }
                                        else
                                          {
                                            setState(() {
                                              colorValues[currWordCount] = -1;
                                            })
                                          },
                                        if (currWordCount < 19)
                                          setState(() {
                                            currWordCount += 1;
                                          })
                                        else
                                          setState(() {
                                            _testComplete = true;
                                          })
                                      })
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i in colorValues)
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4,
                                          color: i == 0
                                              ? Colors.grey[900]!
                                              : i == 1
                                                  ? Colors.green
                                                  : Colors.red)),
                                )
                            ])
                      ]),
        floatingActionButton: Visibility(
            visible: _testComplete,
            child: FloatingActionButton.extended(
                label: const Text('Next'),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const VerbalMemoryRecognitionScoring()))
                    })));
  }
}
