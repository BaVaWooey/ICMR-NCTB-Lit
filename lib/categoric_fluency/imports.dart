export 'categoric_fluency_main.dart';
export 'categoric_fluency_instructions.dart';
import 'package:record/record.dart';
export 'categoric_fluency_output.dart';
import 'package:just_audio/just_audio.dart';
import '../screen/screens.dart';
export 'dart:convert';
export 'cat_flu_animal.dart';
export 'cat_flu_fruits.dart';
export 'cat_flu_vehicles.dart';
export 'results_temp.dart';
export 'report_generation.dart';

///defining variables for main
///
final player = AudioPlayer();

///defining function for recording audio
void recordAudio() async {
  if (await record.hasPermission()) {}
  return;
}

int testValue = 0;

double cleanOutput(String input) {
  input.replaceAll("{", "");
  input.replaceAll("}", "");
  input.replaceAll(" ", "");
  input.replaceAll("similarity", "");
  debugPrint("check this out");
  debugPrint(input);
  return double.parse(input);
}

///list of all the words that were told
List<String> outputWords = [];

///completion of the task for each category

////Audio recording
bool categoricFluencyRecord = false;

void setCategoricFluencyRecording() {
  categoricFluencyRecord = !categoricFluencyRecord;
}

bool categoricRecordingComplete = false,
    categoricRecordingInProgress = false,
    categoricRecordingSent = false;
int timerValue = 0;
String currentElement = "",
    pathStorage = "",
    finalScore = "",
    animalScore = "",
    fruitScore = "",
    vehicleScore = "";

List<String> outputValues = [],
    listResults = [],
    animalResults = [],
    fruitResults = [],
    vehicleResults = [];

///instructions for different categories
String categoryFluencyAnimalInstruction =
        "Name items from the category animal. You have sixty seconds to complete the task. Press the button below when you are ready to take the test. A timer around the button will indicate the total time left.",
    categoryFluencyFruitInstruction =
        "Name items from the category fruit. You have sixty seconds to complete the task. Press the button below when you are ready to take the test. A timer around the button will indicate the total time left.",
    categoryFluencyVehicleInstruction =
        "Name items from the category vehicle. You have sixty seconds to complete the task. Press the button below when you are ready to take the test. A timer around the button will indicate the total time left.",
    categoryFluencyCompletedInstruction = "The task has been completed.";

////Text for showing that you have completed the test.
String categoricFluencyCompletedFruit =
        "You have completed the categoric fluency test for the 'fruit' component. Press the button below to proceed to the next test.",
    categoricFluencyCompletedAnimal =
        "You have completed the categoric fluency test for the 'animal' component. Press the button below to proceed to the next test.",
    categoricFluencyCompletedVehicle =
        "You have completed the categoric fluency test for the 'vehicle' component. Press the button below to proceed to the next test.";
String category = "";

///creating path value in flutter
///
///boolean values needed for the code
///checking if the test is completed
bool categoricFluencyAnimalComplete = false,
    categoricFluencyVehicleComplete = false,
    categoricFluencyFruitComplete = false;

///checking if the recording is in progress
bool categoricFluencyRecordingInProgress = false;

String replaceOutputFunction(String respStr) {
  respStr = respStr.replaceAll('"', "");
  respStr = respStr.replaceAll("eng", "");
  respStr = respStr.replaceAll("Language", "");
  respStr = respStr.replaceAll("transcript", "");
  respStr = respStr.replaceAll("[", "");
  respStr = respStr.replaceAll("{", "");
  respStr = respStr.replaceAll("]", "");
  respStr = respStr.replaceAll("}", " ");
  respStr = respStr.replaceAll(":", "");
  respStr = respStr.replaceAll("[", "");
  respStr = respStr.replaceAll("0", "");
  respStr = respStr.replaceAll("1", "");
  respStr = respStr.replaceAll('2', "");
  respStr = respStr.replaceAll("3", "");
  respStr = respStr.replaceAll("4", "");
  respStr = respStr.replaceAll("5", "");
  respStr = respStr.replaceAll("6", "");
  respStr = respStr.replaceAll("7", "");
  respStr = respStr.replaceAll("8", "");
  respStr = respStr.replaceAll("9", "");
  respStr = respStr.replaceAll("start", "");
  respStr = respStr.replaceAll("end", "");
  respStr = respStr.replaceAll(",", "");
  return respStr;
}

void setTestValue() {
  testValue = Random().nextInt(100) + 1;
}
