import 'imports.dart';
import '../screen/screens.dart';

///we check for both of these things

class DelayedMemoryTaskCheckList extends StatefulWidget {
  const DelayedMemoryTaskCheckList({super.key});

  @override
  State<DelayedMemoryTaskCheckList> createState() =>
      _DelayedMemoryTaskCheckListState();
}

class _DelayedMemoryTaskCheckListState
    extends State<DelayedMemoryTaskCheckList> {
  bool isPlaying = false;
  void playAudio() async {
    if (isPlaying == true) return;
    setState(() {
      isPlaying = true;
    });
    await player.setFilePath(finalFilePath);
    await player.play();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Delayed Memory Recall Results",
              style: TextStyle(fontSize: 40)),
          toolbarHeight: 100,
          centerTitle: true),
      body: Column(children: [
        Expanded(
          child: SizedBox(
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
                        title: Text(allRecitals[0][index]),
                        value: delayedMemoryCheck[index],
                        onChanged: (bool? value) {
                          setState(() {
                            delayedMemoryCheck[index] = value!;
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
        Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Center(
                child: TextButton.icon(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black)),
                    onPressed: () => {playAudio()},
                    label: const Text("Delayed Memory Replay",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    icon: const Icon(Icons.replay, color: Colors.white))))
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DelayedRecognitionTaskInstructions()))
              },
          label: const Text('Next'),
          icon: const Icon(Icons.arrow_forward)),
    );
  }
}
