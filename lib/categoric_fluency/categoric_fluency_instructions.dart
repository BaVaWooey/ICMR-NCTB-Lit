import '../screen/screens.dart';
import 'imports.dart';

class CategoricFluencyInstructions extends StatefulWidget {
  const CategoricFluencyInstructions({super.key});

  @override
  State<CategoricFluencyInstructions> createState() =>
      _CategoricFluencyInstructionsState();
}

class _CategoricFluencyInstructionsState
    extends State<CategoricFluencyInstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: const Text('Categoric Fluency Instructions',
              style: TextStyle(fontSize: 40)),
          centerTitle: true),
      body: const Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(50, 100, 100, 50),
          child: Text(
              'In each of these fluency tests, you will be presented with a single category. In each of these tests, you will be asked to generate the names of as many items in that category as possible in one minute. Three such tests will be administered to you. Tap on the icon button on the tests when you are ready to tell the names. Press the arrow button below to proceed to the tests.',
              style: TextStyle(
                height: 1.5,
                fontSize: 30,
              )),
        )
      ]),
      floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoricFluencyAnimal()));
            setTestValue();
            // if (testValue < 33) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const CategoricFluencyAnimal()));
            // } else if (testValue < 66) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const CategoricFluencyFruit()));
            // } else {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const CategoricFluencyVehicle()));
            // }
          },
          child: const Icon(Icons.arrow_forward_sharp)),
    );
  }
}
