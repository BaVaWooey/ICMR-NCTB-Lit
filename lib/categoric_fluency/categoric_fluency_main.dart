import '../screen/screens.dart';
import 'imports.dart';

class CategoricFluencyMain extends StatefulWidget {
  const CategoricFluencyMain({super.key});

  @override
  State<CategoricFluencyMain> createState() => _CategoricFluencyMainState();
}

class _CategoricFluencyMainState extends State<CategoricFluencyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text("Categoric Fluency", style: TextStyle(fontSize: 40)),
            centerTitle: true),
        body: Center(
            child: ElevatedButton(
                onPressed: () => {
                      ///This is the function to navigate to the instructions page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CategoricFluencyInstructions(),
                          ))
                    },
                child: const Icon(Icons.arrow_forward_sharp))));
  }
}
