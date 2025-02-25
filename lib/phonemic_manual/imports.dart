///exporting of all the files will happen here
export 'instructions.dart';
export 'main.dart';
export 'recording_phonemic.dart';
export 'results.dart';
// All  the string variables are defined here for our purposes

String manualInstructionsFirst =
        "Upon pressing the button below, you will be directed to a test where you will be given one phoneme. Your goal is to generate as many words as possible, that start with this phoneme.",
    phonemeType = "Ka";

bool recordingOn = false,
    recordingComplete = false,
    recordingInProgress = false,
    recordingSent = false;

int timerValue = 0;

List<String> outputValues = [];

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

void capitalizeWords() {
  for (String element in outputValues) {
    element = element.replaceFirst(element[0], element[0].toUpperCase());
  }
}
