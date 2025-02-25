import 'imports.dart';
import '../screen/screens.dart';

class VerbalMemoryImmediateChecklist extends StatefulWidget {
  const VerbalMemoryImmediateChecklist({super.key});

  @override
  State<VerbalMemoryImmediateChecklist> createState() =>
      _VerbalMemoryImmediateChecklistState();
}

class _VerbalMemoryImmediateChecklistState
    extends State<VerbalMemoryImmediateChecklist> {
  bool _isPlaying = false;
  @override
  void initState() {
    _isPlaying = false;
    super.initState();
  }

  void playAudio(input) async {
    if (_isPlaying == true) {
      return;
    }
    setState(() {
      _isPlaying = true;
    });
    await player.setFilePath(input == 1
        ? outputAudioPath[0]
        : input == 2
            ? outputAudioPath[1]
            : outputAudioPath[2]);
    await player.play();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Immediate Recall (Checklist)',
                style: TextStyle(fontSize: 30)),
            centerTitle: true,
            toolbarHeight: 100),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(
              child: SizedBox(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                          child: const Text("Words",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)))),
                  Expanded(
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: allRecitals[0].length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(allRecitals[0][index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  // <-- SEE HERE
                                  return const Divider();
                                },
                              ),
                            ))),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 64))
                ]),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                          child: const Text("Trial 1",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)))),
                  Expanded(
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: allRecitals[0].length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    value: immediateRecallCheck[0][index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        immediateRecallCheck[0][index] = value!;
                                      });
                                    },
                                    //title: Text(allRecitals[0][index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  // <-- SEE HERE
                                  return const Divider();
                                },
                              ),
                            ))),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: TextButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.black)),
                              onPressed: () => {playAudio(1)},
                              label: const Text("Trial 1 Replay",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              icon: const Icon(Icons.replay,
                                  color: Colors.white))))
                ]),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                          child: const Text("Trial 2",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)))),
                  Expanded(
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: allRecitals[0].length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    value: immediateRecallCheck[1][index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        immediateRecallCheck[1][index] = value!;
                                      });
                                    },
                                    //title: Text(allRecitals[0][index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  // <-- SEE HERE
                                  return const Divider();
                                },
                              ),
                            ))),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: TextButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.black)),
                              onPressed: () => {playAudio(2)},
                              label: const Text("Trial 2 Replay",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              icon: const Icon(Icons.replay,
                                  color: Colors.white))))
                ]),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                          child: const Text("Trial 3",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)))),
                  Expanded(
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: allRecitals[0].length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    value: immediateRecallCheck[2][index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        immediateRecallCheck[2][index] = value!;
                                      });
                                    },
                                    //title: Text(allRecitals[0][index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  // <-- SEE HERE
                                  return const Divider();
                                },
                              ),
                            ))),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: TextButton.icon(
                              onPressed: () => {playAudio(3)},
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.black)),
                              label: const Text("Trial 3 Replay",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              icon: const Icon(Icons.replay,
                                  color: Colors.white))))
                ]),
              ),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text('Next'),
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImmediateCompletion()))
                }));
  }
}


// Expanded(
//                         child: SizedBox(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black)),
//                             child: Padding(
//                                 padding: const EdgeInsets.all(15),
//                                 child: Center(
//                                     child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: ListView.separated(
//                                     shrinkWrap: true,
//                                     itemCount: allRecitals[0].length,
//                                     itemBuilder: (context, index) {
//                                       return CheckboxListTile(
//                                         value: immediateRecallCheck[2][index],
//                                         onChanged: (bool? value) {
//                                           setState(() {
//                                             immediateRecallCheck[2][index] =
//                                                 value!;
//                                           });
//                                         },
//                                         title: Text(allRecitals[0][index]),
//                                       );
//                                     },
//                                     separatorBuilder: (context, index) {
//                                       // <-- SEE HERE
//                                       return const Divider();
//                                     },
//                                   ),
//                                 ))),
//                           ),
//                         ),
//                       )