// ignore_for_file: camel_case_types

///these are main file imports for routing.
import 'screen/screens.dart';
import 'phonemic_fluency/instructions.dart';
import 'categoric_fluency/categoric_fluency_main.dart';
import 'moca/main.dart';
import 'verbal_recognition/verbal_instructions.dart';
import 'delayed_recall_recognition/imports.dart';
import 'FAST_Manual/fast_instructions.dart';
//import 'FAST_Manual/fast_reading_river_instructions.dart';
import 'phonemic_manual/main.dart';
import 'FAST_Automated/instructions.dart';
import 'results_generation/results_gen.dart';
import 'results_generation/result_final.dart';
import 'user_name_definition/user_name_def_final.dart';
import 'package:firebase_core/firebase_core.dart';

///these are secondary file imports for other classes that we will use, for pop and push method.
import 'phonemic_fluency/ma_sound.dart';
import 'phonemic_fluency/pa_sound.dart';
import 'phonemic_fluency/ka_sound.dart';
import 'phonemic_fluency/scoring_immediate.dart';
import 'phonemic_fluency/scoring_later.dart';
import 'phonemic_fluency/results_final.dart';
import 'results_generation/pa_score_review.dart';

///Variables that cannot be imported
int _selectedTestIndex = 0;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(home: const rollerSelection(), routes: {
    "pa score review": (context) => const PaScoreReview(),
    "phonemic fluency (results)": (context) => const PhonemicResultsFinal(),
    "phonemic fluency (ka)": (context) => const PhonemicFluencyKa(),
    "phonemic fluency (pa)": (context) => const PhonemicFluencyPa(),
    "phonemic fluency (imm)": (context) => const PhonemicImmediateScoring(),
    "phonemic fluency (del)": (context) => const PhonemicLaterScoring(),
    "phonemic fluency (ma)": (context) => const PhonemicFluencyMa(),
    "roller screen": (context) => const rollerSelection(),
    "phonemic fluency": (context) => const PhonemicFluencyInstructions(),
    "categoric fluency": (context) => const CategoricFluencyMain(),
    "verbal recognition (immediate)": (context) => const VerbalInstructions(),
    "verbal recognition (delayed)": (context) =>
        const DelayedMemoryTaskInstructions(),
    "moca": (context) => const mocaInstructions(),
    "fast": (context) => const FASTManualInstructions(),
    "phonemic fluency manual": (context) => const PhonemicManualStart(),
    "results": (context) => const ResultFinalAllTests(),
    "fast final": (context) => const FASTinstructions(),
    "name entry": (context) => const UserNameDefinition(),
  }));
}

///Roller for app selection

class rollerSelection extends StatefulWidget {
  const rollerSelection({super.key});
  @override
  State<rollerSelection> createState() => _rollerSelectionState();
}

class _rollerSelectionState extends State<rollerSelection> {
  ///initiating flutter speech to text in this component
  @override
  void initState() {
    _selectedTestIndex = 0;
    super.initState();
    initSpeech();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Test Selection")),
        body: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ///this will contain tests complete.
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Center(
                          child: Text("Tests Completed",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Center(
                            child: Text("$testsComplete/5",
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400))),
                      )
                    ]),

                ///this will contain verbal memory timer.
                Center(
                    child: Text(
                        verbalMemoryImmediateCompleted
                            ? "Test is done"
                            : "Verbal Memory Timer",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),

                ///this will contain user name
                Center(
                    child: Text(
                        !isUserDefined
                            ? "User is not defined"
                            : "Current user is $userName",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)))
              ]),
              Container(
                  padding: const EdgeInsets.only(left: 300, bottom: 400),
                  //alignment: Alignment.center,
                  child: SizedBox(
                    height: 200,
                    child: ListWheelScrollView(
                        itemExtent: 90,
                        magnification: 1.5,
                        useMagnifier: true,
                        offAxisFraction: 0.6,
                        physics: const FixedExtentScrollPhysics(),
                        diameterRatio: 1.2,
                        squeeze: 1,
                        onSelectedItemChanged: (index) => {
                              setState(() {
                                _selectedTestIndex = index;
                              })
                            },
                        children: testItems),
                  )),
            ],
          ),
          onTap: () => {
            ///MUST BE IMPLEMENTED AS A FUNCTION FOR CLEANER CODE
            //this is where we have to put an alert if the username has not been defined.
            if ((_selectedTestIndex == 0 ||
                    _selectedTestIndex == 1 ||
                    _selectedTestIndex == 2 ||
                    _selectedTestIndex == 3 ||
                    _selectedTestIndex == 4 ||
                    _selectedTestIndex == 5) &&
                !isUserDefined)
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                    title: const Text("Error"),
                    content: const Text("Please input the user name."),
                    actions: [
                      MaterialButton(
                          child: const Text("Exit"),
                          onPressed: () => {Navigator.pop(context, true)}),
                    ]),
              )
            else if (_selectedTestIndex == 0 && phonemicFluencyComplete)
              {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                      title: const Text("Error"),
                      content: const Text(
                          "This test has already been completed for this participant once."),
                      actions: [
                        MaterialButton(
                            child: const Text("Exit"),
                            onPressed: () => {Navigator.pop(context, true)}),
                      ]),
                )
              }
            else if (_selectedTestIndex == 6 && isUserDefined)
              {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                      title: const Text("Error"),
                      content:
                          const Text("You have already logged a participant."),
                      actions: [
                        MaterialButton(
                            child: const Text("Exit"),
                            onPressed: () => {Navigator.pop(context, true)}),
                      ]),
                )
              }
            else
              {
                debugPrint(_selectedTestIndex.toString()),
                Navigator.pushReplacementNamed(
                    context, returnPageRoute(_selectedTestIndex))
              }
          },
        ));
  }
}

//// End of roller for app selection
class temp extends StatefulWidget {
  const temp({super.key});

  @override
  State<temp> createState() => _tempState();
}

class _tempState extends State<temp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
