import '../screen/screens.dart';
import 'imports.dart';

class FASTManualExpressionInstructions extends StatefulWidget {
  const FASTManualExpressionInstructions({super.key});

  @override
  State<FASTManualExpressionInstructions> createState() =>
      _FASTManualExpressionInstructionsState();
}

class _FASTManualExpressionInstructionsState
    extends State<FASTManualExpressionInstructions> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          title: const Text('FAST (Expression)',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
        child: Text(fastManualExpressionInstructions,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Next'),
          onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FASTRiverExpression()))
              }),
    );
  }
}
