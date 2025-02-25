///Generate variables for results of all the tests.
export 'dart:convert';

export 'package:flutter/services.dart';

export 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

int verbal_delayed_score = 0;
var verbal_immediate_trials = [];

var final_scores = [
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
  'Null',
  'Null'
];
var test_names = [
  'Phonemic Fluency',
  'FAST - Comprehension',
  'FAST - Writing',
  'FAST - Expression',
  'Verbal Memory Immediate Recall',
  'Verbal Memory Delayed Recall',
  'Verbal Memory Delayed Recognition',
  'FAST - Reading',
  'FAST - Comprehension River',
  'FAST - Comprehension Shapes',
  'Categoric Fluency'
];
