import 'imports.dart';
import '../screen/screens.dart';
import '../results_generation/imports.dart';

class CategoricFluencyReport extends StatefulWidget {
  const CategoricFluencyReport({super.key});

  @override
  State<CategoricFluencyReport> createState() => _CategoricFluencyReportState();
}

class _CategoricFluencyReportState extends State<CategoricFluencyReport> {
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
            child: Text("Results (Animal)",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Center(

            ///this is for all the words
            child: SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: animalResults.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 10,
                child: Card(
                    elevation: 1,
                    child: ListTile(
                        title: Text(
                      animalResults[index],
                      textAlign: TextAlign.center,
                    ))),
              );
            },
          ),
        )),
        const Center(
            child: Text("Results (Fruit)",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Center(

            ///this is for all the words
            child: SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: fruitResults.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 10,
                child: Card(
                    elevation: 1,
                    child: ListTile(
                        title: Text(
                      fruitResults[index],
                      textAlign: TextAlign.center,
                    ))),
              );
            },
          ),
        )),
        const Center(
            child: Text("Results (Vehicle)",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
        Center(

            ///this is for all the words
            child: SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: vehicleResults.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 10,
                child: Card(
                    elevation: 1,
                    child: ListTile(
                        title: Text(
                      vehicleResults[index],
                      textAlign: TextAlign.center,
                    ))),
              );
            },
          ),
        )),
        Center(
            child: Text('Final Score (Animal) - $animalScore',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))

            ///this is for the final score
            ),
        Center(
            child: Text('Final Score (Fruit) - $fruitScore',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))

            ///this is for the final score
            ),
        Center(
            child: Text('Final Score (Vehicle) - $vehicleScore',
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
                      setState(() => final_scores[10] =
                          "$animalScore (Animal), $fruitScore (Fruit), $vehicleScore (Vehicle)")
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
