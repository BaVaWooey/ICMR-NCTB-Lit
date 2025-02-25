import "../screen/screens.dart";

class UserNameDefinition extends StatefulWidget {
  const UserNameDefinition({super.key});

  @override
  State<UserNameDefinition> createState() => _UserNameDefinitionState();
}

class _UserNameDefinitionState extends State<UserNameDefinition> {
  TextEditingController myController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("This has been taken care of");
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Participant details",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Center(
                child: isUserDefined
                    ? Text("Current User - $userName",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))
                    : const Text("User Name is not defined",
                        style: TextStyle(fontSize: 25)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                child: Center(
                    child: TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Enter the current participant",
                        )))),
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Center(
                  child: OutlinedButton(
                      onPressed: () {
                        if (myController.text == "") {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
                                title: const Text("Error"),
                                content:
                                    const Text("Please enter a valid name."),
                                actions: [
                                  MaterialButton(
                                      child: const Text("Exit"),
                                      onPressed: () =>
                                          {Navigator.pop(context, true)}),
                                ]),
                          );
                        } else {
                          setState(() {
                            userName = myController.text;
                            isUserDefined = true;
                          });
                        }
                      },
                      child: const Text("Submit",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.arrow_back),
          label: const Text("Return"),
          onPressed: () => {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const rollerSelection(),
            //     ))
            Navigator.popAndPushNamed(context, "roller screen"),
          },
        ));
  }
}
