import '../screen/screens.dart';
import 'imports.dart';

class PhonemicManualResults extends StatefulWidget {
  const PhonemicManualResults({super.key});

  @override
  State<PhonemicManualResults> createState() => _PhonemicManualResultsState();
}

class _PhonemicManualResultsState extends State<PhonemicManualResults> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void wordRemoval(int index) {
    setState(() {
      outputValues.removeAt(index);
    });
    return;
  }

  void wordAddition(String input) {
    setState(() {
      outputValues.add(input);
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Phonemic (Manual) results',
                style: TextStyle(fontSize: 40)),
            toolbarHeight: 100,
            centerTitle: true),
        body: Column(
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(40, 30, 40, 70),
                child: Center(
                    child: Text(
                  'The words for this session are given below as follows - ',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30),
                ))),
            Center(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: outputValues.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: const Icon(Icons.arrow_right),
                        title: Text(outputValues[index]),
                        trailing: MaterialButton(
                            onPressed: () => {
                                  //function for removing the word from the list.
                                  wordRemoval(index)
                                },
                            child: const Icon(Icons.close)));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 70),
              child: Center(
                  child: TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter new word'))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 30, 70),
              child: Center(
                  child: MaterialButton(
                      child: const Text('Submit'),
                      onPressed: () => {wordAddition(myController.text)})),
            )
          ],
        ));
  }
}
