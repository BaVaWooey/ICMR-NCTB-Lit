import 'imports.dart';
import '../screen/screens.dart';

////this is where the image will be displayed to the test taker.
///give button that will then go to the widget where they can upload the photo they took.

bool doneWriting = false;

showAlertDialog(BuildContext context, setState) {
  Widget continueButton = TextButton(
      child: const Text("Yes, I'm done"),
      onPressed: () {
        setState(() {
          doneWriting = true;
          debugPrint("$doneWriting");
        });
        Navigator.of(context).pop();
      });

  Widget rejectButton = TextButton(
      child: const Text("No, take me back"),
      onPressed: () {
        doneWriting = false;
        Navigator.of(context).pop();
      });

  AlertDialog alert = AlertDialog(
    title: const Text("Warning"),
    content: const Text("Are you done writing down what you see in the image?"),
    actions: [
      continueButton,
      rejectButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class FASTManualWriting extends StatefulWidget {
  const FASTManualWriting({super.key});

  @override
  State<FASTManualWriting> createState() => _FASTManualWritingState();
}

class _FASTManualWritingState extends State<FASTManualWriting> {
  @override
  void initState() {
    doneWriting = false;
    super.initState();
  }

  void generateAlert() {}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          title: const Text('Writing (Image)',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          ///write what you see about the image
          children: [
            ///show the image
            Center(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 5)),
              margin: const EdgeInsets.all(15.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Image.asset('assets/river.png'),
              ),
            )),

            ///tell them to move on if they have written.
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: Colors.green,
                  onPressed: () {
                    showAlertDialog(context, setState);
                  },
                  child: const Text('Press here',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ))
          ]),
      floatingActionButton: Visibility(
        visible: doneWriting,
        child: FloatingActionButton.extended(
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Proceed'),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FASTManualWritingPhotoUpload()))
                  ////this will take us to the section where we can upload the photo.
                }),
      ),
    );
  }
}
