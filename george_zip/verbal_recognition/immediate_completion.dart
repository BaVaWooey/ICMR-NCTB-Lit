import '../screen/screens.dart';
import 'imports.dart';

class ImmediateCompletion extends StatefulWidget {
  const ImmediateCompletion({super.key});

  @override
  State<ImmediateCompletion> createState() => _ImmediateCompletionState();
}

class _ImmediateCompletionState extends State<ImmediateCompletion> {
  @override
  void initState() {
    computeFinalScore();
    super.initState();
  }

  void computeFinalScore() {
    ///this is where the final score computation will be done
    int i = 0;
    while (i < 10) {
      if (immediateRecallCheck[0][i] == true) {
        setState(() {
          finalScore += 1;
        });
      }
      if (immediateRecallCheck[1][i] == true) {
        setState(() {
          finalScore += 1;
        });
      }
      if (immediateRecallCheck[2][i] == true) {
        setState(() {
          finalScore += 1;
        });
      }
      i += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Immediate Recall has been completed.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            Text("Score - $finalScore",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            FloatingActionButton.extended(
                label: const Text('Next'),
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const rollerSelection()))
                    })
          ],
        ),
      ),
    );
  }
}
