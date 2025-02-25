///define all the instructions for the phoenemic fluency
import '../screen/screens.dart';
export 'instructions.dart';
export 'ka_sound.dart';
export 'main.dart';
export 'ma_sound.dart';
export 'pa_sound.dart';
export 'results.dart';
export 'results-temp.dart';
export 'final_report.dart';
import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();

//VARIABLES
//boolean variables
bool phonemicRecordingComplete = false;
bool phonemicRecordingInProgress = false;
bool phonemicRecordingSent = false;
//string variables
String phonemicPaInstruction =
        "For this test, you will be asked to recite a set of words starting with the phoneme 'Pa'. The status of the test will be displayed in the text below the recording option. The button for continuing to the next test will appear after you have completed the recording phase. The test lasts for sixty seconds. Press the button below to begin with the recording. You cannot stop once you have pressed the button. ",
    phonemicMaInstruction =
        "For this test, you will be asked to recite a set of words starting with the phoneme 'Ma'. The status of the test will be displayed in the text below the recording option. The button for continuing to the next test will appear after you have completed the recording phase. The test lasts for sixty seconds. Press the button below to begin with the recording. You cannot stop once you have pressed the button. ",
    phonemicKaInstruction =
        "For this test, you will be asked to recite a set of words starting with the phoneme 'Ka'. The status of the test will be displayed in the text below the recording option. The button for continuing to the next test will appear after you have completed the recording phase. The test lasts for sixty seconds. Press the button below to begin with the recording. You cannot stop once you have pressed the button. ",
    phonemicInstruction =
        "In this test, you will be asked to recite out as many letters as possible that start with an alphabet that will be given to you by the examiner. You are allowed to say any word that begins with the alphabet. Press the button below this for an example.",
    currentElement = "",
    pathStorage = "",
    finalScore = "";
//list variables
List<String> outputValues = [], listResults = [];
//integer variables
int testValue = 0, timerValue = 0;
//FUNCTIONS

void setTestValue() {
  testValue = Random().nextInt(100) + 1;
}

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
