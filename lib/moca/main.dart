///code for mocaMemory
// ignore_for_file: camel_case_types

import "imports.dart";

class mocaInstructions extends StatefulWidget {
  const mocaInstructions({super.key});

  @override
  State<mocaInstructions> createState() => _mocaInstructionsState();
}

class _mocaInstructionsState extends State<mocaInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 200,
          title: const Text("MOCA test", style: TextStyle(fontSize: 30))),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(70.0),
          child: Container(
              padding: const EdgeInsets.only(right: 14, left: 14),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: const Text('Instructions',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30))),
        ),
        Container(
            padding: const EdgeInsets.only(right: 14, left: 14),
            child: Text(instructionsMocaMemory,
                style: const TextStyle(
                    fontSize: 20,
                    height: 2.5,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.2)))
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const mocaAttentionInstructionsFirst()))
              },
          child: const Icon(Icons.arrow_forward_sharp)),
    );
  }
}

class mocaMemoryImmediateRecall extends StatefulWidget {
  const mocaMemoryImmediateRecall({super.key});
  @override
  State<mocaMemoryImmediateRecall> createState() =>
      _mocaMemoryImmediateRecallState();
}

class _mocaMemoryImmediateRecallState extends State<mocaMemoryImmediateRecall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 200,
            title: const Text("Memory Test", style: TextStyle(fontSize: 30))),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(70.0),
            child: Container(
                decoration: BoxDecoration(border: Border.all()),
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: isFirstTrialMocaMemory == true
                    ? const Text("First Trial",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))
                    : const Text('Second Trial',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(70),
            child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: const Text(
                    'Press the button when you are ready to commence the test.',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          ),
          Padding(
            padding: const EdgeInsets.all(70),
            child: Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: MaterialButton(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    color: Colors.black,
                    onPressed: () => {stateWordsMocaMemory()},

                    ///testinginSessionMocaMemory is when the component is activated
                    child: testingInSessionMocaMemory == false
                        ? const Icon(Icons.play_arrow,
                            color: Colors.white, size: 40)
                        : const Icon(Icons.pause_circle_filled,
                            color: Colors.white, size: 40))),
          ),
          Visibility(
            visible: MocaMemorySpeakingPending == true ? true : false,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: MaterialButton(
                onPressed: () => {
                  if (MocaMemoryRecordingOn == true)
                    {
                      ///then here we start recording
                      //()
                    }
                  else
                    {
                      stopListen(),
                      wordsSpokenMoca.add(lastWords.toString().split(' '))
                    }
                  // {wordsSpokenMoca.add(stopListen().toString().split(' '))}
                },
                child: testingInSessionMocaMemory == true ||
                        MocaMemoryRecordingOn == true
                    ? const Icon(Icons.mic_external_off)
                    : const Icon(Icons.mic_external_on),
              ),
            ),
          )
        ]));
  }
}

class mocaMemoryTimer extends StatefulWidget {
  const mocaMemoryTimer({super.key});

  @override
  State<mocaMemoryTimer> createState() => _mocaMemoryTimerState();
}

class _mocaMemoryTimerState extends State<mocaMemoryTimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Timer Check')),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator()));
  }
}

////Attention
class mocaAttentionInstructionsFirst extends StatefulWidget {
  const mocaAttentionInstructionsFirst({super.key});

  @override
  State<mocaAttentionInstructionsFirst> createState() =>
      _mocaAttentionInstructionsFirstState();
}

class _mocaAttentionInstructionsFirstState
    extends State<mocaAttentionInstructionsFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 300,
            title:
                const Text('Attention test', style: TextStyle(fontSize: 50))),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(70),
              child: Text(instructionsMocaAttentionFirst,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      decoration: TextDecoration.underline)),
            ),
            Container(
                padding: const EdgeInsets.all(70),
                child: const Text(
                    'In the first test, five numbers will be recited to you. You are supposed to repeat them in the forward order.',
                    style: TextStyle(fontSize: 25))),
            Container(
                padding: const EdgeInsets.all(70),
                child: const Text(
                    'in the second test, three numbers will be recited to you. You are supposed to repeat them in the backward order.',
                    style: TextStyle(fontSize: 25)))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const mocaAttentionInstructionsSecond()));
            },
            child: Icon(Icons.arrow_forward_sharp)));
  }
}

class mocaAttentionInstructionsSecond extends StatefulWidget {
  const mocaAttentionInstructionsSecond({super.key});

  @override
  State<mocaAttentionInstructionsSecond> createState() =>
      _mocaAttentionInstructionsSecondState();
}

class _mocaAttentionInstructionsSecondState
    extends State<mocaAttentionInstructionsSecond> {
  String letterCurrent = "-";
  @override
  void initState() {
    setState(() {
      identifierElement = tapElement[0];
    });
    super.initState();
  }

  void attentionTestSample() async {
    setState(() => {attentionTestSampleInProgress = true});
    await flutterTts.awaitSpeakCompletion(true);
    setState(() => {
          letterCurrent = 'b',
        });
    await flutterTts.speak('b');
    await Future.delayed(const Duration(seconds: 1));
    setState(() => {letterCurrent = 'c'});
    await flutterTts.speak('c');
    await Future.delayed(const Duration(seconds: 1));
    setState(() => {letterCurrent = 'f'});
    await flutterTts.speak('f');
    await Future.delayed(const Duration(seconds: 1));
    setState(() => {letterCurrent = 'l'});
    await flutterTts.speak('l');
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => {
          identifierElement = tapElement[1],
        });
    setState(() => {letterCurrent = 'a'});
    await flutterTts.speak('a');
    setState(() => {
          identifierElement = tapElement[0],
        });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() => {letterCurrent = 'b'});
    await flutterTts.speak('b');
    await Future.delayed(const Duration(seconds: 1));
    setState(() => {letterCurrent = 'z'});
    await flutterTts.speak('z');
    await Future.delayed(const Duration(seconds: 1));
    setState(() => {letterCurrent = 'o'});
    await flutterTts.speak('o');
    setState(() => {attentionTestSampleInProgress = false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 300,
          title: const Text('Attention Test Part 2',
              style: TextStyle(fontSize: 50))),
      body: Column(children: [
        Container(
            padding: const EdgeInsets.all(70),
            child: Text(instructionsMocaAttentionSecond,
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w600))),
        Container(
            padding: const EdgeInsets.all(30),
            child: MaterialButton(
                color: Colors.black,
                padding: const EdgeInsets.all(10),
                child: const Text('Press here for demo',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                onPressed: () => {
                      ///state letters
                      if (attentionTestSampleInProgress == false)
                        {attentionTestSample()}
                    })),
        Container(
            padding: const EdgeInsets.all(30),
            child: Text('The letter being pronounced is $letterCurrent.',
                style: const TextStyle(
                  fontSize: 30,
                ))),
        // Container(
        //     padding: const EdgeInsets.all(30),
        //     child: Text(identifierElement,
        //         style: const TextStyle(
        //             fontWeight: FontWeight.w800,
        //             decoration: TextDecoration.underline,
        //             fontSize: 45))),
        Container(
            padding: const EdgeInsets.all(30),
            child: MaterialButton(
                padding: const EdgeInsets.all(60),
                onPressed: () => {
                      ///This will serve as a way to change the button text
                    },
                color: Colors.red,
                shape: const CircleBorder(),
                // child: const Icon(Icons.south, color: Colors.white, size: 100),
                child: Text(letterCurrent == 'a' ? "Tap now" : "Don't tap now",
                    style: const TextStyle(color: Colors.white, fontSize: 20))))
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_forward_sharp),
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const mocaAttentionTestActualSecond()))
              }),
    );
  }
}

class mocaAttentionTestActualSecond extends StatefulWidget {
  const mocaAttentionTestActualSecond({super.key});

  @override
  State<mocaAttentionTestActualSecond> createState() =>
      _mocaAttentionTestActualSecondState();
}

class _mocaAttentionTestActualSecondState
    extends State<mocaAttentionTestActualSecond> {
  String currentSpeak = "";
  int currentIndex = 0;
  @override
  void initState() {
    setState(() => {
          mocaAttentionLettersUserTapped = [],
          //mocaAttentionLettersList = [],
          mocaAttentionTestSecondInProgress = false,
          mocaAttentionTestSecondDone = false,
          currentSpeak = "",
          currentIndex = 0,
          correctValuesTappedAttentionSecondTest = 0,
          wrongValuesTappedAttentionSecondTest = 0
        });
    mocaAttentionTestSecondInProgress = false;
    super.initState();
  }

  void commenceMocaAttentionTestSecond() async {
    await flutterTts.awaitSpeakCompletion(true);
    setState(() => {mocaAttentionTestSecondInProgress = true});
    debugPrint(mocaAttentionLettersList.length.toString());
    for (int i = 0; i < mocaAttentionLettersList.length; i += 1) {
      setState(() => {currentIndex = i});
      debugPrint('check');
      await flutterTts.speak(mocaAttentionLettersList[i]);
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() => {
          mocaAttentionTestSecondInProgress = false,
          mocaAttentionTestSecondDone = true
        });
  }

  void checkForCorrectTapMocaAttentionTestSecond() {
    if (mocaAttentionLettersIndexCorrect.contains(currentIndex) &&
        !(mocaAttentionLettersUserTapped.contains(currentIndex))) {
      setState(() => {
            correctValuesTappedAttentionSecondTest += 1,
            mocaAttentionLettersUserTapped.add(currentIndex)
          });
    } else if (!mocaAttentionLettersIndexCorrect.contains(currentIndex) &&
        mocaAttentionLettersUserTapped.contains(currentIndex)) {
    } else {
      setState(() => {wrongValuesTappedAttentionSecondTest += 1});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 300,
            centerTitle: true,
            title: const Text('Attention Test part 2',
                style: TextStyle(fontSize: 50))),
        body: Center(
            child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(30),
                child: const Text(
                    "Tap the button right below the instruction to start the test. Tap the red button whenever you hear the letter 'a'.",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w300))),
            Container(
                padding: const EdgeInsets.all(30),
                child: const Text(
                    'Do not tap the red button before pressing the black button.',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline))),
            Container(
                padding: const EdgeInsets.all(50),
                child: MaterialButton(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    color: Colors.black,
                    onPressed: () => {
                          if (mocaAttentionTestSecondInProgress == false &&
                              mocaAttentionTestSecondDone == false)
                            {commenceMocaAttentionTestSecond()}
                        },
                    child: const Text('Start!',
                        style: TextStyle(color: Colors.white, fontSize: 30)))),
            Container(
                padding: const EdgeInsets.all(30),
                child: MaterialButton(
                    padding: const EdgeInsets.all(30),
                    onPressed: () => {
                          if (mocaAttentionTestSecondInProgress == true)
                            {checkForCorrectTapMocaAttentionTestSecond()}
                          else
                            {
                              HapticFeedback.vibrate(),
                            },
                          debugPrint(correctValuesTappedAttentionSecondTest
                              .toString()),
                          debugPrint(
                              wrongValuesTappedAttentionSecondTest.toString())
                        },
                    color: Colors.red,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.south,
                        color: Colors.white, size: 100))),
            Visibility(
              visible: mocaAttentionTestSecondDone == true ? true : false,
              child: Container(
                  padding: const EdgeInsets.all(50),
                  child: MaterialButton(
                      color: Colors.black,
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 10, top: 10),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const mocaAttentionInstructionsThird()))
                          },
                      child: const Text('Next test',
                          style:
                              TextStyle(fontSize: 30, color: Colors.white)))),
            )
          ],
        )));
  }
}

class mocaAttentionInstructionsThird extends StatefulWidget {
  const mocaAttentionInstructionsThird({super.key});

  @override
  State<mocaAttentionInstructionsThird> createState() =>
      _mocaAttentionInstructionsThirdState();
}

class _mocaAttentionInstructionsThirdState
    extends State<mocaAttentionInstructionsThird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 300,
            title: const Text('Attention Test part 3',
                style: TextStyle(fontSize: 50))),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(70),
              child: Text(instructionsMocaAttentionThirdFirst,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w300))),
          Container(
              padding: const EdgeInsets.all(70),
              child: MaterialButton(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 30, right: 30),
                  color: Colors.black,
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const mocaAttentionTestThird()))
                      },
                  child: const Text('Proceed to test',
                      style: TextStyle(fontSize: 30, color: Colors.white))))
        ]));
  }
}

class mocaAttentionTestThird extends StatefulWidget {
  const mocaAttentionTestThird({super.key});

  @override
  State<mocaAttentionTestThird> createState() => _mocaAttentionTestThirdState();
}

class _mocaAttentionTestThirdState extends State<mocaAttentionTestThird> {
  @override
  void initState() {
    super.initState();
    setState(() {
      lastWordsAttentionTestThird = "";
      mocaAttentionTestThirdDone = false;
      wordsSpokenMocaAttentionThirdTest = [];
    });
  }

  ///voice recording functionality
  void onSpeechResultMocaAttentionThird(SpeechRecognitionResult result) {
    setState(() {
      lastWordsAttentionTestThird = result.recognizedWords;
    });
  }

  ///generic listening functions
  void listenTextMocaAttentionThird() async {
    speechInUse = true;
    await speechToText.listen(onResult: onSpeechResultMocaAttentionThird);
  }

  void stopListenMocaAttentionThird() async {
    await speechToText.stop();
    speechInUse = false;
    debugPrint(lastWordsAttentionTestThird);
    setState(() => {
          wordsSpokenMocaAttentionThirdTest =
              lastWordsAttentionTestThird.split(' ')
        });
  }

  ///call all voice recording functions
  void recordInputMocaAttentionTestThird() async {
    if (mocaAttentionTestThirdInProgress == true) {
      stopListenMocaAttentionThird();
      setState(() {
        wordsSpokenMocaAttentionThirdTest =
            lastWordsAttentionTestThird.split(" ");
        mocaAttentionTestThirdInProgress = false;
        mocaAttentionTestThirdDone = true;
      });
    } else {
      setState(() {
        mocaAttentionTestThirdInProgress = true;
      });
      listenTextMocaAttentionThird();
    }

    ///we will end the recording here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 300,
            centerTitle: true,
            title: const Text('Attention Test part 3',
                style: TextStyle(fontSize: 50))),
        body: Center(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(70),
                  child: const Text(
                      "Serially subtract the number '7' from the number '100'. Do this upto five times. Press the button below when you're ready.",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600))),
              Container(
                  padding: const EdgeInsets.all(70),
                  child: MaterialButton(
                      shape: const CircleBorder(),
                      color: Colors.black,
                      padding: const EdgeInsets.all(30),
                      child: mocaAttentionTestThirdInProgress == true
                          ? const Icon(Icons.mic_external_off,
                              color: Colors.white, size: 30)
                          : const Icon(Icons.mic_external_on,
                              color: Colors.white, size: 30),
                      onPressed: () => {
                            recordInputMocaAttentionTestThird()

                            ///speech to text functionality goes here
                          })),
              Visibility(
                  visible: mocaAttentionTestThirdDone == true ? true : false,
                  child: Container(
                      padding: const EdgeInsets.all(70),
                      child: MaterialButton(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10, bottom: 10),
                          onPressed: () => {
                                ///go to the next test
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const mocaLanguageInstructions()))
                              },
                          color: Colors.black,
                          child: const Text('Continue',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30)))))
            ],
          ),
        ));
  }
}

///Sentence repetition
class mocaLanguageInstructions extends StatefulWidget {
  const mocaLanguageInstructions({super.key});

  @override
  State<mocaLanguageInstructions> createState() =>
      _mocaLanguageInstructionsState();
}

class _mocaLanguageInstructionsState extends State<mocaLanguageInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 300,
            title: const Text('Language Test', style: TextStyle(fontSize: 50))),
        body: Center(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.all(70),
                child: Text(instructionsMocaLanguageFirst,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300))),
            Container(
                padding: const EdgeInsets.all(70),
                child: Text(instructionsMocaLanguageSecond,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline))),
            Container(
                padding: const EdgeInsets.all(70),
                child: MaterialButton(
                    color: Colors.black,
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const mocaLanguageTest()))
                        },
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: const Text('Start Testing!',
                        style: TextStyle(color: Colors.white, fontSize: 30))))
          ]),
        ));
  }
}

class mocaLanguageTest extends StatefulWidget {
  const mocaLanguageTest({super.key});

  @override
  State<mocaLanguageTest> createState() => _mocaLanguageTestState();
}

class _mocaLanguageTestState extends State<mocaLanguageTest> {
  @override
  void initState() {
    setState(() {
      mocaLanguageRecitalSentenceTokens = tokenizeRecitalSentences();
      mocaLanguageRecitalInProgress = false;
      mocaLanguageRecitalDone = false;
      mocaLanguageRecordingInProgress = false;
      mocaLanguageRecordingDone = true;
      mocaLanguageDone = false;
      sentenceMocaLanguage = "";
      testNumberLanguage = 0;
    });
    super.initState();
  }

  void stateSentenceTokens(testNumber) async {
    debugPrint('entered');
    await flutterTts.awaitSpeakCompletion(true);
    for (int i = 0;
        i < mocaLanguageRecitalSentenceTokens[testNumber].length;
        i++) {
      await flutterTts.speak(mocaLanguageRecitalSentenceTokens[testNumber][i]);
      await Future.delayed(const Duration(milliseconds: 5));
    }
  }

  ///reciting sentence
  void reciteSentence() async {
    setState(() => {
          mocaLanguageRecitalInProgress = true,
        });
    // await flutterTts.awaitSpeakCompletion(true);
    // await flutterTts.speak(mocaLanguageRecitalSentences[testNumberLanguage]);
    stateSentenceTokens(testNumberLanguage);
    setState(() => {
          mocaLanguageRecitalInProgress = false,
          mocaLanguageRecitalDone = true
        });
  }

  ///recording sentence
  void onSpeechResultMocaLanguage(SpeechRecognitionResult result) {
    setState(() {
      sentenceMocaLanguage = result.recognizedWords;
    });
  }

  ///generic listening functions
  void listenTextMocaLangauge() async {
    speechInUse = true;
    await speechToText.listen(onResult: onSpeechResultMocaLanguage);
  }

  void stopListenMocaLanguage() async {
    await speechToText.stop();
    speechInUse = false;
    debugPrint(sentenceMocaLanguage);
    setState(() => {
          mocaLanguageRecordingDone = true,
          mocaLanguageRecitalDone = false,
          testNumberLanguage += 1,
          if (testNumberLanguage == 2) {mocaLanguageDone = true}
        });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 300,
            centerTitle: true,
            title: const Text('Language Test', style: TextStyle(fontSize: 50))),
        body: Center(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.all(70),
              child: const Text(
                  'Press the black button first to hear the sentence. Press the red button afterwards to recite the sentence and then tap on the button again when you are done recording. Both must be done one after the other in the prescribed order.',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300))),
          Container(
              padding: const EdgeInsets.all(20),
              child: const Text("You must repeat the entire process twice.",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline))),
          Container(
              padding: const EdgeInsets.all(70),
              child: MaterialButton(
                  color: Colors.black,
                  padding: const EdgeInsets.only(
                      right: 30, left: 30, top: 10, bottom: 10),
                  child: const Text('Start recital',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  onPressed: () => {
                        debugPrint('entered'),
                        if (mocaLanguageRecordingDone == true &&
                            mocaLanguageRecordingInProgress == false &&
                            mocaLanguageDone == false)
                          {reciteSentence()}

                        ///start recital
                      })),
          Container(
              padding: const EdgeInsets.all(30),
              child: MaterialButton(
                  color: Colors.red,
                  padding: const EdgeInsets.all(30),
                  shape: const CircleBorder(),
                  child: mocaLanguageRecordingInProgress == true
                      ? const Icon(Icons.mic_external_on,
                          size: 50, color: Colors.white)
                      : const Icon(Icons.mic_external_off,
                          size: 50, color: Colors.white),
                  onPressed: () => {
                        if (mocaLanguageRecitalDone == true &&
                            mocaLanguageRecitalInProgress == false &&
                            mocaLanguageDone == false)
                          {
                            if (mocaLanguageRecordingInProgress == true)
                              {
                                stopListenMocaLanguage(),
                                setState(() => {
                                      mocaLanguageRecordingInProgress = false,
                                      mocaLanguageRecordingDone = true,
                                    })
                              }
                            else
                              {
                                listenTextMocaLangauge(),
                                setState(() =>
                                    {mocaLanguageRecordingInProgress = true})
                              }
                          }
                      })),
          Visibility(
              visible: mocaLanguageDone == true ? true : false,
              child: Container(
                  padding: const EdgeInsets.all(30),
                  child: MaterialButton(
                      color: Colors.black,
                      padding: const EdgeInsets.only(
                          right: 30, left: 30, top: 10, bottom: 10),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const mocaAbstractionInstructions()))
                          },
                      child: const Text('Next Test',
                          style:
                              TextStyle(fontSize: 30, color: Colors.white)))))
        ])));
  }
}

////Verbal fluency
class mocaAbstractionInstructions extends StatefulWidget {
  const mocaAbstractionInstructions({super.key});

  @override
  State<mocaAbstractionInstructions> createState() =>
      _mocaAbstractionInstructionsState();
}

class _mocaAbstractionInstructionsState
    extends State<mocaAbstractionInstructions> {
  @override
  void onSpeechResultMocaAbstraction(SpeechRecognitionResult result) {
    setState(() {
      lastWordsMocaAbstraction = result.recognizedWords;
    });
  }

  ///generic listening functions
  void listenTextMocaAbstraction() async {
    speechInUse = true;
    await speechToText.listen(onResult: onSpeechResultMocaAbstraction);
  }

  void stopListenMocaAbstraction() async {
    await speechToText.stop();
    speechInUse = false;
    debugPrint(lastWordsMocaAbstraction);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 300,
            centerTitle: true,
            title: const Text('Verbal Fluency Test',
                style: TextStyle(fontSize: 50))),
        body: Center(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.all(70),
              child: Text(instructionsMocaAbstraction,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline))),
          Container(
              padding: const EdgeInsets.all(70),
              child: MaterialButton(
                  padding: const EdgeInsets.only(
                      right: 30, left: 30, top: 10, bottom: 10),
                  color: Colors.black,
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const mocaAbstractionTest()))
                      },
                  child: const Text('Proceed to test',
                      style: TextStyle(fontSize: 30, color: Colors.white))))
        ])));
  }
}

class mocaAbstractionTest extends StatefulWidget {
  const mocaAbstractionTest({super.key});

  @override
  State<mocaAbstractionTest> createState() => _mocaAbstractionTestState();
}

class _mocaAbstractionTestState extends State<mocaAbstractionTest> {
  @override
  void initState() {
    seconds = 5;
    mocaAbstractionInProgress = false;
    mocaAbstractionDone = false;
    lastWordsMocaAbstraction = "";
    super.initState();
  }

  void onSpeechResultMocaAbstraction(SpeechRecognitionResult result) {
    setState(() => {lastWordsMocaAbstraction = result.recognizedWords});
  }

  void listenFunctionAbstraction() async {
    speechInUse = true;
    setState(() {
      mocaAbstractionInProgress = true;
    });
    await speechToText.listen(onResult: onSpeechResultMocaAbstraction);
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        seconds = seconds - 1;
      });
    }
    await speechToText.stop();
    mocaAbstractionOutput = lastWordsMocaAbstraction.split(" ");
    debugPrint(lastWordsMocaAbstraction);
    speechInUse = false;
    setState(() {
      mocaAbstractionInProgress = false;
      mocaAbstractionDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 300,
            title: const Text('Verbal Fluency Test',
                style: TextStyle(fontSize: 50))),
        body: Center(
          child: Column(children: [
            Container(
                padding: const EdgeInsets.all(70),
                child: MaterialButton(
                    color: Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(70),
                    onPressed: () => {
                          ///Here they will start reciting the words
                          if (mocaAbstractionDone == false &&
                              mocaAbstractionInProgress == false)
                            {listenFunctionAbstraction()}
                        },
                    child: const Icon(Icons.mic_external_on,
                        color: Colors.white, size: 30))),
            Container(
                padding: const EdgeInsets.all(70),
                child: Text(
                    mocaAbstractionDone == false
                        ? "$seconds seconds left."
                        : "Test is over.",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 30))),
            Visibility(
                visible: mocaAbstractionDone == true ? true : false,
                child: Container(
                  padding: const EdgeInsets.all(70),
                  child: MaterialButton(
                      color: Colors.black,
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      child: const Text('Next Test',
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const mocaFinalScore()))
                          }),
                ))
          ]),
        ));
  }
}

////Abstraction
class mocaDelayedRecallInstructions extends StatefulWidget {
  const mocaDelayedRecallInstructions({super.key});

  @override
  State<mocaDelayedRecallInstructions> createState() =>
      _mocaDelayedRecallInstructionsState();
}

class _mocaDelayedRecallInstructionsState
    extends State<mocaDelayedRecallInstructions> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

///Delayed Recall
class mocaOrientationInstructions extends StatefulWidget {
  const mocaOrientationInstructions({super.key});

  @override
  State<mocaOrientationInstructions> createState() =>
      _mocaOrientationInstructionsState();
}

class _mocaOrientationInstructionsState
    extends State<mocaOrientationInstructions> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class mocaFinalScore extends StatefulWidget {
  const mocaFinalScore({super.key});

  @override
  State<mocaFinalScore> createState() => _mocaFinalScoreState();
}

class _mocaFinalScoreState extends State<mocaFinalScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 300,
            title: const Text('Final Scores', style: TextStyle(fontSize: 50))),
        body: Center(
            child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(30),
                child: const Text('Attention Test part 2 score',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline))),
            Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                    'Number of true positives - $correctValuesTappedAttentionSecondTest',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300))),
            Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                    'Number of false positives - $wrongValuesTappedAttentionSecondTest',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300))),
            Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                    'Number of false negatives - ${mocaAttentionLettersIndexCorrect.length - correctValuesTappedAttentionSecondTest}',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300))),
            Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                    'Number of true negatives - ${mocaAttentionLettersList.length - mocaAttentionLettersIndexCorrect.length - wrongValuesTappedAttentionSecondTest}',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300))),
            Container(
                padding: const EdgeInsets.all(70),
                child: const Text('Attention Test part 3 score',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline))),
            Container(
                padding: const EdgeInsets.all(70),
                child: const Text('Language Test score',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline))),
            Container(
                padding: const EdgeInsets.all(70),
                child: const Text('Abstraction score',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline))),
          ],
        )));
  }
}
