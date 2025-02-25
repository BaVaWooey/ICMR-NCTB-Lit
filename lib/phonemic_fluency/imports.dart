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
export 'temp_transition_screen.dart';
import '../results_generation/imports.dart';
import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();

//VARIABLES
//boolean variables
bool phonemicRecordingComplete = false;
bool phonemicRecordingInProgress = false;
bool phonemicRecordingSent = false;
//string variables
String phonemicPaInstruction =
        "For this test, you will be asked to recite a set of words starting with the phoneme 'Pa'. If you are scoring the test immediately, you will have an option to press a button that will count for every right word said by the participant. If you are scoring it later, you will have to simply record the audio. In both cases, the participant will be allowed to utter the words for 60 seconds. You cannot stop recording once you have started the process.",
    phonemicMaInstruction =
        "For this test, you will be asked to recite a set of words starting with the phoneme 'Ma'. If you are scoring the test immediately, you will have an option to press a button that will count for every right word said by the participant. If you are scoring it later, you will have to simply record the audio. In both cases, the participant will be allowed to utter the words for 60 seconds. You cannot stop recording once you have started the process.",
    phonemicKaInstruction =
        "For this test, you will be asked to recite a set of words starting with the phoneme 'Ka'. If you are scoring the test immediately, you will have an option to press a button that will count for every right word said by the participant. If you are scoring it later, you will have to simply record the audio. In both cases, the participant will be allowed to utter the words for 60 seconds. You cannot stop recording once you have started the process.",
    phonemicInstruction =
        "In this test, you will be asked to recite out as many letters as possible that start with an alphabet that will be given to you by the examiner. You are allowed to say any word that begins with the alphabet. Press the button below this for an example.",
    phonemicImmediateScoringInstructions =
        "You can press the button below to start recording at any given time. Note that you will given a single button for scoring the test, which you have to press everytime the participant speaks an accurate word. This will appear after pressing the button below. Do not press the button for words spoken by the participant that aren't correct.",
    phonemicLaterScoringInstructions =
        "You can press the button below to start recording. Since you are not scoring the test immediately, you will be given an option to review the participants audio data later.",
    currentElement = "",
    pathStorage = "",
    finalScore = "";
//list variables
List<String> outputValues = [],
    listResults = [],
    maResults = [],
    paResults = [],
    kaResults = [];
//integer variables
int testValue = 0, timerValue = 0;
String paScore = "", maScore = "", kaScore = "";
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
