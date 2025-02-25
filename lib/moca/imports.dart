///imports for moca test
// ignore_for_file: non_constant_identifier_names

import '../screen/screens.dart';
export '../screen/screens.dart';

int waitingTime = 0;
int seconds = 60;
////
String lastWordsAttentionTestThird = "";
String lastWordsMocaAbstraction = "";
String instructionsMocaMemory =
    "This is a memory test. I will read a list of words that you will have to remember for now and later. Your task is to tell as many as possible. The order does not matter. Tap the next button below when you are ready to take the test";

String instructionsMocaAttentionFirst =
    "You will be asked to repeat a set of numbers in both forward and reverse order.";

String instructionsMocaAttentionSecond =
    "A list of letters will be read to you. Your task is to tap on the red button everytime you hear the letter 'A'.";

List<String> tapElement = ["", "Tap now."];

String identifierElement = tapElement[0];

String instructionsMocaAttentionThirdFirst =
    "You will be asked to serially subtract a number Y from a number X.";
String instructionsMocaLanguageFirst =
    "A set of sentences will be recited to you.";
String instructionsMocaLanguageSecond =
    "Your task is to recite them as accurately as possible after listening. Press the button below when you are ready to begin.";
String sentenceMocaLanguage = "";
String instructionsMocaAbstraction =
    "In the next test, you will be required to tell us as many words as possible that begin with the letter P in the time span of 60 seconds. You are allowed to tell us any word apart from proper nouns (Pradeep or Pakistan) and words with the same sound but a different suffix, for example, punish, punished and punishment.";
List wordsListmoca = ['eye', 'saree', 'temple', 'rose', 'blue'];
List wordsSpokenMoca = [];
List wordsSpokenMocaAttentionThirdTest = [];
List<String> mocaLanguageRecitalSentences = [
  "I only know that Raju is the one to help today.",
  "The cat always hid under the sofa when the dogs were in the room."
];
List<List<String>> mocaLanguageRecitalSentenceTokens = [];
List mocaAbstractionOutput = [];
////

bool isFirstTrialMocaMemory = true;
bool testingInSessionMocaMemory = false;
bool MocaMemoryDone = false;
bool MocaMemorySpeakingPending = false;
bool MocaMemoryRecordingOn = false;
bool attentionTestSampleInProgress = false;
bool mocaAttentionTestSecondInProgress = false;
bool mocaAttentionTestSecondDone = false;
bool mocaAttentionTestThirdInProgress = false;
bool mocaAttentionTestThirdDone = false;
bool mocaLanguageRecitalInProgress = false;
bool mocaLanguageRecitalDone = false;
bool mocaLanguageRecordingInProgress = false;
bool mocaLanguageRecordingDone = false;
bool mocaLanguageDone = false;
bool mocaAbstractionInProgress = false;
bool mocaAbstractionDone = false;

/////
void stateWordsMocaMemory() async {
  await flutterTts.awaitSpeakCompletion(true);
  for (int i = 0; i < wordsListmoca.length; i++) {
    debugPrint(wordsListmoca[i]);
    await flutterTts.speak(wordsListmoca[i]);
  }
}

//tokenize words in sentences
List<List<String>> tokenizeRecitalSentences() {
  List<List<String>> newList = [];
  for (int i = 0; i < mocaLanguageRecitalSentences.length; i++) {
    newList.add(mocaLanguageRecitalSentences[i].split(' '));
  }
  return newList;
}

///attention test part 2

List mocaAttentionLettersList = [
  'f',
  'b',
  'a',
  'c',
  'm',
  'n',
  'a',
  'a',
  'j',
  'k',
  'l',
  'b',
  'a',
  'f',
  'a',
  'k',
  'd',
  'e',
  'a',
  'a',
  'a',
  'j',
  'a',
  'm',
  'o',
  'f',
  'a',
  'a',
  'b'
];

///2,6,7,8,12,14,18,19,20,26,27

List mocaAttentionLettersIndexCorrect = [
  2,
  6,
  7,
  8,
  12,
  14,
  18,
  19,
  20,
  26,
  27
];

List mocaAttentionLettersUserTapped = [];

int correctValuesTappedAttentionSecondTest = 0,
    wrongValuesTappedAttentionSecondTest = 0;

///other miscellaneous int values
int testNumberLanguage = 0;

///int scores for test
int scoreAttentionTestSecond = 0, scoreAttentionTestThird = 0;
