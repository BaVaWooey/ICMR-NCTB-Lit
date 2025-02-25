//export 'trial_1_delayed.dart';
//export 'trial_1_immediate.dart';
//export 'trial_1_reciting.dart';
//export 'trial_1.dart';
//export 'trial_2.dart';
//export 'trial_3.dart';
//export 'immediate_checklist.dart';
//export 'verbal_instructions.dart';
export 'package:syncfusion_flutter_pdf/pdf.dart';
export 'dart:convert';
export 'score_screen.dart';
export 'trial_delayed_memory_instructions.dart';
export 'trial_delayed_memory_recording.dart';
export 'trial_delayed_memory_check_list.dart';
export 'trial_delayed_recognition_instructions.dart';
export 'trial_delayed_recognition_test.dart';
import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();

///all the necessary imports for the code
///

String verbalInstructions =
        "You will hear ten words. Listen to them carefully. Repeat them in any order and record your response by using the record button provided. Remember that you will have to recall these words later.",
    recitalInstructions =
        "Press the button below to begin the recital. The words will be told to you only once, so please pay attention after pressing the button. You cannot activate the recital again after completing it once.",
    verbalInstructionsSecond =
        "The ten words will be recited again. Listen to them carefully. Repeat them in any order and record your response by using the record button provided. Remember that you will have to recall these words later.",
    delayedInstructions =
        "In the previous trials, a list of ten words were recited to you, in varying order for a total of three times. Tell all those words again.",
    delayedRecognitionInstructions =
        "A few minutes ago, a list of words was read out multiple times. Now, I will read a few words again. Tell me whether the word was in that list or not.",
    finalFilePath = "";

bool recitalComplete = false,
    recitalInProgress = false,
    immediateRecallDone = false,
    immediateDataObtained = false,
    immediateRecordingInProgress = false,
    immediateRecordingSent = false,
    immediateRecordingResultsObtained = false,
    immediateRecordingComplete = false;

List<String> outputValues = [];
int recitalCount = 1,
    correctCount = 0,
    wrongCount = 0,
    missedCount = 0,
    trialNumber = 1;

List<List<String>> allRecitals = [
  [
    "Letter",
    "Butter",
    "Corner",
    "Arm",
    "Queen",
    "Ticket",
    "Grass",
    "Stone",
    "Book",
    "Stick"
  ],
  [
    "Ticket",
    "Book",
    "Butter",
    "Corner",
    "Stone",
    "Arm",
    "Queen",
    "Letter",
    "Stick",
    "Grass"
  ],
  [
    "Queen",
    "Grass",
    "Arm",
    "Book",
    "Stick",
    "Corner",
    "Butter",
    "Stone",
    "Ticket",
    "Letter"
  ]
];

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

Map<String, String> wordToAudio = {
  "Butter": "assets/audio/verbal_memory/butter.mp3",
  "Arm": "assets/audio/verbal_memory/arm.mp3",
  "Corner": "assets/audio/verbal_memory/corner.mp3",
  "Letter": "assets/audio/verbal_memory/letter.mp3",
  "Queen": "assets/audio/verbal_memory/queen.mp3",
  "Ticket": "assets/audio/verbal_memory/ticket.mp3",
  "Grass": "assets/audio/verbal_memory/grass.mp3",
  "Stone": "assets/audio/verbal_memory/stone.mp3",
  "Book": "assets/audio/verbal_memory/book.mp3",
  "Stick": "assets/audio/verbal_memory/stick.mp3",
  "Temple": "assets/audio/verbal_memory/temple.mp3",
  "Tea": "assets/audio/verbal_memory/tea.mp3",
  "Key": "assets/audio/verbal_memory/key.mp3",
  "Hotel": "assets/audio/verbal_memory/hotel.mp3",
  "Mountain": "assets/audio/verbal_memory/mountain.mp3",
  "Five": "assets/audio/verbal_memory/five.mp3",
  "Shoe": "assets/audio/verbal_memory/shoe.mp3",
  "Village": "assets/audio/verbal_memory/village.mp3",
  "Thread": "assets/audio/verbal_memory/thread.mp3",
  "Soldier": "assets/audio/verbal_memory/soldier.mp3",
};

List<List> immediateRecallCheck = [
  [false, false, false, false, false, false, false, false, false, false],
  [false, false, false, false, false, false, false, false, false, false],
  [false, false, false, false, false, false, false, false, false, false]
];

List<bool> delayedMemoryCheck = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];

List<String> outputAudioPath = [];

List<bool> wordCorrectness = [
  true, //butter
  false, // temple
  true, //arm
  false, //tea
  false, //key
  true, //corner
  false, //five
  true, //letter
  false, //hotel
  false, //mountain
  true, //queen
  true, //book
  false, //shoe
  true, //stick
  false, //village
  false, //thread
  true, //ticket
  false, //soldier
  true, //grass
  true //stone
];

List<String> delayedRecognitionWords = [
  "Butter", //true
  "Temple",
  "Arm", //true
  "Tea",
  "Key",
  "Corner", //true
  "Five",
  "Letter", //true
  "Hotel",
  "Mountain",
  "Queen", //true
  "Book", // true
  "Shoe",
  "Stick", // true
  "Village",
  "Thread",
  "Ticket", //true
  "Soldier",
  "Grass", //true
  "Stone" //true
];

List<int> colorValues = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];

void functionChange() {
  for (int i = 0; i < 20; i++) {
    colorValues[i] = 0;
  }
}

(int, int, int, int, int) scoreValuesVerbalMemory() {
  int t1 = 0, t2 = 0, t3 = 0, delayedMemory = 0, delayedRecall = 0, i;
  for (int i = 0; i < 10; i++) {
    t1 += immediateRecallCheck[0][i] == true ? 1 : 0;
    t2 += immediateRecallCheck[1][i] == true ? 1 : 0;
    t3 += immediateRecallCheck[2][i] == true ? 1 : 0;
    delayedMemory += delayedMemoryCheck[i] == true ? 1 : 0;
  }
  for (int i = 0; i < 20; i++) {
    delayedRecall += colorValues[i] == 1 ? 1 : 0;
  }
  return (t1, t2, t3, delayedMemory, delayedRecall);
}
