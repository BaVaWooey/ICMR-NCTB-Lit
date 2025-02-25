import 'imports.dart';
import '../screen/screens.dart';
import '../results_generation/imports.dart';

class PhonemicFluencyReport extends StatefulWidget {
  const PhonemicFluencyReport({super.key});

  @override
  State<PhonemicFluencyReport> createState() => _PhonemicFluencyReportState();
}

class _PhonemicFluencyReportState extends State<PhonemicFluencyReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          title: const Text("Final Report",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Center(
            child: Text("Results (Ma)",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Center(

            ///this is for all the words
            child: SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: maResults.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 10,
                child: Card(
                    elevation: 1,
                    child: ListTile(
                        title: Text(
                      maResults[index],
                      textAlign: TextAlign.center,
                    ))),
              );
            },
          ),
        )),
        const Center(
            child: Text("Results (Pa)",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Center(

            ///this is for all the words
            child: SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: paResults.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 10,
                child: Card(
                    elevation: 1,
                    child: ListTile(
                        title: Text(
                      paResults[index],
                      textAlign: TextAlign.center,
                    ))),
              );
            },
          ),
        )),
        const Center(
            child: Text("Results (Ka)",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Center(

            ///this is for all the words
            child: SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: kaResults.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 10,
                child: Card(
                    elevation: 1,
                    child: ListTile(
                        title: Text(
                      kaResults[index],
                      textAlign: TextAlign.center,
                    ))),
              );
            },
          ),
        )),
        Center(
            child: Text('Final Score (Ma) - $maScore',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))

            ///this is for the final score
            ),
        Center(
            child: Text('Final Score (Pa) - $paScore',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))

            ///this is for the final score
            ),
        Center(
            child: Text('Final Score (Ka) - $kaScore',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))

            ///this is for the final score
            ),
        Center(
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                color: Colors.lightBlue,
                child: const Text("Submit Final Results",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () => {
                      setState(() => final_scores[0] =
                          "$maScore (Ma), $paScore (Pa), $kaScore (Ka)")
                    }))
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
