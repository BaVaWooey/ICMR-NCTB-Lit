import 'imports.dart';
import '../screen/screens.dart';

class FASTTestCompletion extends StatefulWidget {
  const FASTTestCompletion({super.key});

  @override
  State<FASTTestCompletion> createState() => _FASTTestCompletionState();
}

class _FASTTestCompletionState extends State<FASTTestCompletion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Results", style: TextStyle(fontSize: 40)),
          centerTitle: true,
          toolbarHeight: 100),
      body: const Center(
        child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Text("River Comprehension Score",
                  style: TextStyle(fontSize: 30))),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Text('4', style: TextStyle(fontSize: 30))),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Text("Shapes Comprehension Score",
                  style: TextStyle(fontSize: 30))),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Text('5', style: TextStyle(fontSize: 30))),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child:
                  Text("River Reading Score", style: TextStyle(fontSize: 30))),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Text('4', style: TextStyle(fontSize: 30)))
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Next'),
          onPressed: () => {
                setState(() {
                  nextTest = "riverComprehension";
                }),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const rollerSelection()))
              },
          icon: const Icon(Icons.arrow_forward)),
    );
  }
}
