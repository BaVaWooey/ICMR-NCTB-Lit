import '../screen/screens.dart';

class PhonemicFluencyTempTransition extends StatefulWidget {
  const PhonemicFluencyTempTransition({super.key});

  @override
  State<PhonemicFluencyTempTransition> createState() =>
      _PhonemicFluencyTempTransitionState();
}

class _PhonemicFluencyTempTransitionState
    extends State<PhonemicFluencyTempTransition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Text(
                    "Do you want to score the test immediately or later?",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)))),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Center(
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Score Now",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400)))),
          Center(
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Score Later",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400))))
        ])
      ]),
    );
  }
}
