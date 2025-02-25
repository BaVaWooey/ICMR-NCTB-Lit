import 'imports.dart';
import '../screen/screens.dart';
import '../results_generation/imports.dart';

class ManualScoringFast extends StatefulWidget {
  const ManualScoringFast({super.key});

  @override
  State<ManualScoringFast> createState() => _ManualScoringFastState();
}

class _ManualScoringFastState extends State<ManualScoringFast> {
  final writing_controller = TextEditingController(),
      expression_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Manual Score",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          centerTitle: true,
          toolbarHeight: 100),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
            child: TextFormField(
                controller: writing_controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_fields),
                    labelText: 'Input Writing Score'),
                validator: (String? value) {
                  return (value != null &&
                          !value.contains(RegExp(r'^-?[0-9]+$')))
                      ? 'Numbers only.'
                      : null;
                })),
        Center(
            child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                color: Colors.blue,
                onPressed: () => {
                      setState(
                        () => final_score_writing = writing_controller.text,
                      )
                    },
                child: const Text("Submit Writing Score",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)))),
        Center(
            child: TextFormField(
                controller: expression_controller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.mic), labelText: 'Input Expression Score'),
                validator: (String? value) {
                  return (value != null &&
                          !value.contains(RegExp(r'^-?[0-9]+$')))
                      ? 'Numbers only.'
                      : null;
                })),
        Center(
            child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                color: Colors.blue,
                onPressed: () => {
                      setState(
                        () =>
                            final_score_expression = expression_controller.text,
                      )
                    },
                child: const Text("Submit Expression Score",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)))),
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Text("Current Scores",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30))),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Text(
                        "FAST Comprehension River Score - $fastComprehensionRiverScore",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Text(
                        "FAST Comprehension Shapes Score - $fastComprehensionShapeScore",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Text("FAST Reading Score - $fastReadingScore",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Text("FAST Expression - $final_score_expression",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Text("FAST Writing - $final_score_writing",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))),
              ),
            ],
          ),
        ),
        Center(
          child: MaterialButton(
              child: const Text("Submit Scores"),
              onPressed: () => {
                    setState(() => {
                          final_scores[1] =
                              fastComprehensionRightTap.toString(),
                          final_scores[2] = final_score_writing,
                          final_scores[3] = final_score_expression,
                          debugPrint(final_scores[7]),
                          debugPrint(final_scores[8]),
                          debugPrint(final_scores[9]),
                          final_scores[7] = fastReadingScore.toString(),
                          final_scores[8] =
                              fastComprehensionRiverScore.toString(),
                          final_scores[9] =
                              fastComprehensionShapeScore.toString(),
                          debugPrint(final_scores[7]),
                          debugPrint(final_scores[8]),
                          debugPrint(final_scores[9]),
                        })

                    ///you will submit the scores here.
                  }),
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const rollerSelection()));
          },
          label: const Text("Next"),
          icon: Icon(Icons.arrow_forward)),
    );
  }
}
