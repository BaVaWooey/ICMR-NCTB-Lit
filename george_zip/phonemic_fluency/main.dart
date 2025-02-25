import '../screen/screens.dart';
import 'imports.dart';

////this will be the code for starting the phonemic fluency test
///upon pressing this button, you will be directed to the instructions page

class PhonemicFluencyMain extends StatefulWidget {
  const PhonemicFluencyMain({super.key});

  @override
  State<PhonemicFluencyMain> createState() => _PhonemicFluencyMainState();
}

class _PhonemicFluencyMainState extends State<PhonemicFluencyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text('Phonemic Fluency', style: TextStyle(fontSize: 40)),
            toolbarHeight: 100),
        body: Center(
            child: MaterialButton(
                onPressed: () => {
                      ///navigator function.
                      ///Moves the context to instructions.
                    },
                child: const Icon(Icons.arrow_forward))));
  }
}
