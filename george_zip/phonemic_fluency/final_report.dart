import 'imports.dart';
import '../screen/screens.dart';

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
        Center(

            ///this is for all the words
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: listResults.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 10,
              child: Card(
                  elevation: 1,
                  child: ListTile(
                      title: Text(
                    listResults[index],
                    textAlign: TextAlign.center,
                  ))),
            );
          },
        )),
        Center(
            child: Text('Final Score - $finalScore',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))

            ///this is for the final score
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
