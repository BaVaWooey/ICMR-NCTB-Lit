///All the imports
///
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:record/record.dart';
import 'package:flutter_sound/flutter_sound.dart';

///
///

////All the exports
///
export 'package:roller_list/roller_list.dart';
export 'package:flutter/material.dart';
export '../styles/utils.dart';
export 'package:flutter/services.dart';
export 'package:speech_to_text/speech_recognition_result.dart';
export 'package:circular_countdown_timer/circular_countdown_timer.dart';
export 'package:path_provider/path_provider.dart';
export 'dart:io';
export 'package:dio/dio.dart';
export 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
export 'dart:math';
export 'package:record/record.dart';
export 'package:http_parser/http_parser.dart';
export 'package:loading_animation_widget/loading_animation_widget.dart';
export '../main.dart';
export 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
// export 'package:flutter_curl/flutter_curl.dart';

///
///
///
//general speech to text functions

SpeechToText speechToText = SpeechToText();
String lastWords = '';
bool speechInUse = false;
bool verbalMemoryImmediateCompleted = false;
//
//general text to speech functions
TextToSpeech textToSpeech = TextToSpeech();
FlutterTts flutterTts = FlutterTts();

///Base functionalities essential for all files

class SizeConfig {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  static double safeAreaHorizontal = 0;
  static double safeAreaVertical = 0;
  static double safeBlockHorizontal = 0;
  static double safeBlockVertical = 0;

  void init(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
  }
}

///Items for different files/functionalities
///
///Roller list
int _selectedTestIndex = 0;

///individual test components present in list
List<Widget> testItems = [
  const ListTile(title: Text("Phonemic Fluency"), onTap: null),
  const ListTile(title: Text("Categoric Fluency")),
  //this was commented out ^
  const ListTile(title: Text("Verbal Memory (Immediate)")),
  const ListTile(title: Text("Verbal Memory (Delayed)")),
  // const ListTile(title: Text("MOCA")),
  const ListTile(title: Text("FAST")),
  const ListTile(title: Text("Results")),
  const ListTile(title: Text("Login")),
  // const ListTile(title: Text("Phonemic Fluency (Manual)")),
  // const ListTile(title: Text("FAST (Final)"))
];

///function for roller list

String returnPageRoute(int check) {
  if (check == 0) {
    return "phonemic fluency";
  } else if (check == 1) {
    return "categoric fluency";
  } else if (check == 2) {
    return "verbal recognition (immediate)";
  } else if (check == 3) {
    return "verbal recognition (delayed)";
  } else if (check == 9) {
    return "moca";
  } else if (check == 4) {
    return "fast";
  } else if (check == 9) {
    return "phonemic fluency manual";
  } else if (check == 9) {
    return "fast final";
  } else if (check == 5) {
    return "results";
  } else if (check == 6) {
    return "name entry";
  }
  return "";
}

void initSpeech() async {
  await speechToText.initialize();
}

Future listeningForPandC() async {
  if (speechInUse == true) return null;

  //listen for 60 seconds
  speechInUse = true;
  await speechToText.listen(onResult: onSpeechResult);
  for (int i = 0; i < 5; i++) {
    await Future.delayed(const Duration(seconds: 1), () {
      debugPrint('the time right now is ${i + 1} seconds');
    });
  }

  ///

  //return, and print the text
  await speechToText.stop();
  speechInUse = false;

  ///
  debugPrint(lastWords);
  return lastWords;
}

void onSpeechResult(SpeechRecognitionResult result) {
  lastWords = result.recognizedWords;
}

///generic listening functions
void listenText() async {
  speechInUse = true;
  await speechToText.listen(onResult: onSpeechResult);
}

void stopListen() async {
  await speechToText.stop();
  speechInUse = false;
  debugPrint(lastWords);
  return;
}

///initializing recorder for categoric and phonemic fluency
///
final record = AudioRecorder();
final recorder = FlutterSoundRecorder();

///this is for defining who the current user is.
bool isUserDefined = false;
String userName = "";

///final scores for all the participants
int finalMaScore = 0, finalPaScore = 0, finalKaScore = 0;

///checking values for if the scoring has been done or not.
bool maScoringDone = false, kaScoringDone = false, paScoringDone = false;

///this is for keeping track of how many tests are completed.
int testsComplete = 0;

///checking if every test is done/complete individually.
bool phonemicFluencyComplete = false,
    categoricFluencyComplete = false,
    FASTComplete = false,
    VerbalLearningComplete = false,
    DelayedRecallRecComplete = false;

///this is for defining all the links of the audio
String finalUserPaDirectory = "",
    finalUserMaDirectory = "",
    finalUserKaDirectory = "";
