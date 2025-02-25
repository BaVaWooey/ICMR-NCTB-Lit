// ignore: file_names
import '../screen/screens.dart';

class CategoricTempResults extends StatefulWidget {
  const CategoricTempResults({super.key});

  @override
  State<CategoricTempResults> createState() => _CategoricTempResultsState();
}

class _CategoricTempResultsState extends State<CategoricTempResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Center(
              child: MaterialButton(
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                  color: Colors.green,
                  child:
                      const Icon(Icons.replay, size: 80, color: Colors.white),
                  onPressed: () => {
                        ////this is where the function for replaying the audio will be at.
                      })),
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(200, 0, 200, 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Final Score',
                ),
              ),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton.extended(
            label: const Text("Next"),
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const rollerSelection(),
                      ))
                }));
  }
}
