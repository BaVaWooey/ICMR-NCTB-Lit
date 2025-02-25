import 'imports.dart';
import '../screen/screens.dart';

class FASTinstructions extends StatefulWidget {
  const FASTinstructions({super.key});

  @override
  State<FASTinstructions> createState() => _FASTinstructionsState();
}

class _FASTinstructionsState extends State<FASTinstructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("FAST (final)", style: TextStyle(fontSize: 40)),
          centerTitle: true),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text(instructions_fast_final,
                style: const TextStyle(fontSize: 25))),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text(
                "The first test (comprehension) will have a river scene.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text(
                "The second test (comprehension) will have a set of shapes.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text("The third test (expression) will have a river scene.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Text(
                "The fourth test (expression) will have a set of shapes.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
      ]),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Next'),
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FASTRiverReadingInstructions()))
              },
          icon: const Icon(Icons.arrow_forward)),
    );
  }
}
