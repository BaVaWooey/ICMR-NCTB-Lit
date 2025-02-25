import 'imports.dart';
import '../screen/screens.dart';

class PhonemicFluencyKa extends StatefulWidget {
  const PhonemicFluencyKa({super.key});

  @override
  State<PhonemicFluencyKa> createState() => _PhonemicFluencyKaState();
}

class _PhonemicFluencyKaState extends State<PhonemicFluencyKa> {
  @override
  void initState() {
    setState(() {
      currentElement = "k";
      phonemicRecordingComplete = false;
      phonemicRecordingInProgress = false;
      phonemicRecordingSent = false;
      timerValue = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Phonemic Fluency (Ka)',
              style: TextStyle(fontSize: 40)),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Column(children: [
          //// instructions
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
              child: Text(phonemicKaInstruction,
                  style: const TextStyle(
                      fontSize: 25, fontStyle: FontStyle.italic, height: 1.5))),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, "phonemic fluency (imm)");
                          },
                          child: const Text("Press here to score now",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400)))),
                  Center(
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(
                                context, "phonemic fluency (del)");
                          },
                          child: const Text("Press here to score later",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400))))
                ]),
          )

          /// status of recording
          /// the button for continuation to results
        ]),
        floatingActionButton: Visibility(
            visible: phonemicRecordingComplete,
            child: FloatingActionButton.extended(
                label: const Text('Next'),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PhonemicTempResults()))
                    })));
  }
}
