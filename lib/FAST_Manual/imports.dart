export 'fast_instructions.dart';
export 'fast_river_comprehension.dart';
export 'fast_river_comprehension_demo.dart';
export 'fast_shapes_comprehension_instructions.dart';
export 'fast_shapes_comprehension.dart';
export 'fast_river_reading_instructions.dart';
export 'fast_reading_river.dart';
export 'fast_reading_river_instructions.dart';
export 'fast_river_reading.dart';
export 'fast_test_completion.dart';
export 'fast_expression_instruction.dart';
export 'fast_expression.dart';
export 'fast_writing.dart';
export 'fast_writing_instructions.dart';
export 'fast_writing_picture_upload.dart';
export 'results.dart';
export 'manual_scoring.dart';
// export 'fast_comprehension_2.dart';
export 'fast_reading.dart';
import 'package:just_audio/just_audio.dart';
export 'transition_screen.dart';
export 'package:flutter/services.dart';
export 'package:camera/camera.dart';

///audio player in flutter
final player = AudioPlayer();

///String variables
String fastManualInstructions =
        "In this test, you will be asked to tap on a set of images according to the instructions that will be recited/written out to you. Listen to/Read the instructions carefully, and tap on the screen accordingly. When the instructions are recited to you, you will be given the chance to replay the instructions thrice. You can only proceed to the next instruction after you are done tapping for the current instruction.",
    fastManualShapesComprehensionInstructions =
        " Like in the previous test, a set of instructions will be recited out to you. Your goal is to tap on the screen, according to the instructions being stated to you. Some instructions might require double/triple taps. So tap on the screen accordingly. To proceed with this test, follow the instruction written below and tap on the image accordingly.",
    fastManualRiverReadingInstructions =
        "In this test, the instructions will be written on the screen for you to see. Your aim is to tap on the screen, according to the written instruction. There will be no option to 'replay' the instruction. After tapping, tap on 'next instruction' to proceed.",
    fastManualRiverWritingInstructions =
        "In this test, you will be shown a picture. Please write as much as you can about the image presented to you.",
    fastManualExpressionInstructions =
        "In this test, a picture will be shown to you. Upon seeing the picture, you will have to tap on the button given below and speak right after.",
    nextTest = "";

///Integer variables
int fastReadingScore = 0,
    fastComprehensionRightTap = 0,
    fastComprehensionWrongTap = 0,
    fastComprehensionRiverScore = 0,
    fastComprehensionShapeScore = 0,
    fastReadingRightTap = 0,
    fastReadingWrongTap = 0;
String final_score_expression = "", final_score_writing = "";

String finalImagePath = "", finalAudioPath = "";

///Bool variables

///List variables
List<String> riverComprehensionInstructions = [
      "Point to a boat",
      "Point to the tallest tree",
      "Point to the man and point to the goat",
      "Point to the man's left leg and then to the ship",
      "Before pointing to the duck near the bridge, show me the middle hill."
    ],
    shapesComprehensionInstructions = [
      'Point to the square',
      "point to the cone",
      "point to the arrow and the square",
      "point to the square, the cone and the semicircle",
      "point to the one that looks like a hill and the one that looks like a half moon"
    ],
    riverReadingInstructions = [
      "Point to the goat.",
      "Show me the bridge.",
      "Point to the man standing in the barge.",
      "Touch the left-hand corner of the image.",
      "Touch the bottom of the image and then the top of the image."
    ];

///define the assets directory for all the audio files
List<String> riverOutputAudio = [
      'assets/audio/river/boat.mp3',
      'assets/audio/river/tallest_tree.mp3',
      'assets/audio/river/man_goat.mp3',
      'assets/audio/river/left_leg_ship.mp3',
      'assets/audio/river/middle_hill.mp3'
    ],
    shapeOutputAudio = [
      'assets/audio/shapes/square.mp3',
      'assets/audio/shapes/cone.mp3',
      'assets/audio/shapes/arrow_square.mp3',
      'assets/audio/shapes/square_cone_semicircle.mp3',
      'assets/audio/shapes/hill_half_moon.mp3'
    ],
    riverInstructionsReading = [
      'Point to the goat',
      'Show me the bridge',
      'Point to the man standing in the barge',
      'Touch the left hand corner of the screen',
      'Touch the bottom of the screen and then the top',
    ];
List<int> riverOutputAudioDuration = [2260, 3340, 4660, 5000, 6040],
    shapeOutputAudioDuration = [2048, 2062, 3094, 4078, 6080];

List<List<List<int>>> riverComprehensionCheckingOneTap = [
  [
    [530, 670],
    [1000, 770]
  ],
  [
    [877, 70],
    [1060, 341]
  ]
];
List<List<List<List<int>>>> riverComprehensionCheckingDoubleTap = [
  [
    [
      [200, 350],
      [355, 800]
    ],
    [
      [320, 560],
      [535, 788]
    ]
  ],
  [
    [
      [240, 500],
      [350, 800]
    ],
    [
      [569, 142],
      [885, 292]
    ]
  ],
  [
    [
      [406, 22],
      [719, 223]
    ],
    [
      [442, 516],
      [541, 583]
    ]
  ]
];

List<List<List<int>>> shapeComprehensionCheckingOneTap = [
  [
    [130, 280],
    [450, 700]
  ],

  ///first instruction
  [
    [524, 206],
    [718, 477]
  ]

  ///second instruction
];

List<List<List<List<int>>>> shapeComprehensionCheckingDoubleTap = [
  [
    ///third instruction
    [
      [140, 754],
      [431, 989]
    ],
    [
      [130, 280],
      [450, 700]
    ]
  ],
  [
    ///fifth instruction
    [
      [524, 206],
      [718, 477]
    ],
    [
      [566, 507],
      [1066, 878]
    ]
  ]
];

List<List<List<List<int>>>> shapeComprehensionCheckingTripleTap = [
  [
    [
      [130, 280],
      [450, 700]
    ],
    [
      [524, 206],
      [718, 477]
    ],
    [
      [566, 507],
      [1066, 878]
    ]
  ]
];

List<List<List<int>>> riverReadingCheckingOneTap = [
  [
    [94, 608],
    [260, 780]
  ],
  [
    [60, 380],
    [612, 570]
  ],
  [
    [330, 450],
    [420, 580]
  ],
  [
    [0, 610],
    [213, 800]
  ]
];

List<int> values = [338, 640];
