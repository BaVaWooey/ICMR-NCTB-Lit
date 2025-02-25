export 'instructions.dart';
export 'river_comprehension_demo.dart';
export 'river_comprehension.dart';
export 'river_reading.dart';
export 'river_reading_instructions.dart';
export 'shape_comprehension.dart';
export 'shape_comprehension_instructions.dart';
export 'shape_reading.dart';
export 'transition_screen.dart';
export 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
export 'package:media_info/media_info.dart';

final player = AudioPlayer();
//we will define all the relevant imports and variables here
///

///bool variables

///we will need bool variables to check if the test has been completed or not.
bool river_comprehension_complete = false,
    river_expression_complete = false,
    shapes_comprehension_complete = false,
    shapes_expression_complete = false,
    testInProgress = false,
    testComplete = false;

///int variables
int river_comprehension_correct = 0,
    river_expression_correct = 0,
    shaeps_comprehension_correct = 0,
    shapes_expression_correct = 0,
    replays_total = 0,
    instruction_number = 1,
    time_left = 5,
    number_of_taps = 1;

////float variables
///none as of now

///string variables
///we will need to define the instructions and other relevent variables in this section
String instructions_fast_final =
        "In this test, you will be given a set of instructions to follow. You will be prompted to touch certain parts of the screen depending on the directions given to you. Follow them as is. The first part of this test will be based on a scenery. The next part of this test will be on a set of shapes.",
    instructions_river =
        "In this test, you will given a river scenery. Upon pressing the blue button below, you will be prompted to the next page. Listen to the auditory instructions and perform the actions accordingly.",
    next_test = "",
    instructions_shape =
        "You will be prompted to do the exact same as the last test. However, like it was previously mentioned on the earlier instructions page, you will be prompted to tap on an image that shows a set of shapes. Your goal is to tap on the correct shape/set of shapes according to the instructions being stated to you. Read the instruction below and tap accordingly to continue.",
    instructions_river_reading =
        "A set of instructions will be displayed on the screen, prompting you to point at certain objects present in the river. Your goal is to accurately tap on the places that show where the objects are placed. The test is timed, so you will only get 15 seconds per instruction. As a sample, please attempt the example below. The instruction is given below the picture.";
////list variables
List<String> riverOutputAudio = [
  'assets/audio/river/boat.mp3',
  'assets/audio/river/tallest_tree.mp3',
  'assets/audio/river/man_goat.mp3',
  'assets/audio/river/left_leg_ship.mp3',
  'assets/audio/river/middle_hill.mp3'
];
List<String> shapeOutputAudio = [
  'assets/audio/shapes/square.mp3',
  'assets/audio/shapes/cone.mp3',
  'assets/audio/shapes/arrow_square.mp3',
  'assets/audio/shapes/square_cone_semicircle.mp3',
  'assets/audio/shapes/hill_half_moon.mp3'
];
List<int> riverOutputAudioDuration = [2260, 3340, 4660, 5000, 6040];
List<int> shapeOutputAudioDuration = [2048, 2062, 3094, 4078, 6080];

List<String> riverInstructionsReading = [
  'Point to a boat.',
  'Point to the tallest tree.',
  'Point to the man and point to the goat.',
  'Point to the man\'s left leg and then to the ship.',
  'Before pointing to a duck near the bridge, show me the middle hill.',
  'The test is complete.'
];
