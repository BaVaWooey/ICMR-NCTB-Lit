import 'imports.dart';
import '../screen/screens.dart';

class FASTresults extends StatefulWidget {
  const FASTresults({super.key});

  @override
  State<FASTresults> createState() => _FASTresultsState();
}

class _FASTresultsState extends State<FASTresults> {
  bool audioPlaying = false;
  @override
  void initState() {
    audioPlaying = false;
    super.initState();
  }

  void playingAudio() async {
    if (audioPlaying == true) return;
    setState(() {
      audioPlaying = true;
    });
    await player.setFilePath(finalAudioPath);
    await player.play();
    setState(() {
      audioPlaying = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('FAST results',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          toolbarHeight: 100,
          centerTitle: true),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ///results for fast comprehension
        Center(
            child: Column(children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Comprehension results',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Correct taps ",
                        style: TextStyle(fontSize: 20, color: Colors.green)),
                    Text('$fastComprehensionRightTap',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Wrong taps ",
                        style: TextStyle(fontSize: 20, color: Colors.red)),
                    Text('$fastComprehensionWrongTap',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ]))
        ])),
        const Center(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Reading results',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)))
        ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(fastReadingScore.toString(),
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold))),

        ///results for fast expression
        Center(
            child: Column(children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Expression results',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: MaterialButton(
                  padding: EdgeInsets.all(20),
                  color: audioPlaying == false ? Colors.green : Colors.red,
                  onPressed: () => {
                        ///play audio
                        playingAudio()
                      },
                  shape: const CircleBorder(),
                  child: audioPlaying == true
                      ? const Icon(Icons.mic_external_off, color: Colors.white)
                      : const Icon(Icons.mic_external_on, color: Colors.white)))
        ])),

        ///results for fast writing
        Center(
            child: Column(children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text('Writing results',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Container(child: Image.file(File(finalImagePath))))
        ]))
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManualScoringFast()))
              },
          label: const Text("Next"),
          icon: const Icon(Icons.arrow_forward)),
    );
  }
}
