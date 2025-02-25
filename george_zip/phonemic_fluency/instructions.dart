import 'imports.dart';
import '../screen/screens.dart';

class PhonemicFluencyInstructions extends StatefulWidget {
  const PhonemicFluencyInstructions({super.key});

  @override
  State<PhonemicFluencyInstructions> createState() =>
      _PhonemicFluencyInstructionsState();
}

class _PhonemicFluencyInstructionsState
    extends State<PhonemicFluencyInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text('Phonemic Fluency', style: TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 100, 30, 100),
          child: Text(phonemicInstruction,
              style: const TextStyle(
                  fontSize: 30, height: 1.5, fontStyle: FontStyle.italic)),
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text('Next'),
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => {
                  setTestValue(),
                  debugPrint('$testValue'),
                  if (testValue <= 33)
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhonemicFluencyMa()))
                    }
                  else if (testValue <= 66)
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhonemicFluencyPa()))
                    }
                  else
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PhonemicFluencyKa()))
                    }

                  ///this will randomly navigate to one of the tests.
                }));
  }
}
