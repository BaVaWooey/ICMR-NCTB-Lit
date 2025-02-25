import '../screen/screens.dart';
import 'imports.dart';

class PhonemicManualStart extends StatefulWidget {
  const PhonemicManualStart({super.key});

  @override
  State<PhonemicManualStart> createState() => _PhonemicManualStartState();
}

class _PhonemicManualStartState extends State<PhonemicManualStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text('Phonemic (Manual)', style: TextStyle(fontSize: 40)),
            toolbarHeight: 100),
        body: Center(
            child: MaterialButton(
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PhonemicManualInstructions()))
                    },
                child: const Icon(Icons.arrow_forward))));
  }
}
