# ICMR-NCTB Verbal Learning Tests

A digitized version of the verbal learning tests present in the ICMR Neuro-Cognitive ToolBox. The PDF version of this document can be found in this [link](http://brandp.in/icmr/downloads/english.pdf).

## Instructions for installation and running the code 

Before following these instructions, ensure that you have an android device connected to your system on which you are running the flutter application through terminal. **This is imperative because the flutter application opens on the android device, not on your laptop/system from which you are executing the commands given below.** Please go through this [video](https://www.youtube.com/watch?v=yxif9Tj8fDE&ab_channel=FlutterTeacher) to get a further understanding of how flutter works and how one can set up their android device to run the application seamlessly. 

1. Install flutter from [here](https://docs.flutter.dev/get-started/install).
2. Clone the project and navigate to `/app` folder inside the cloned repo.
3. Inside the directory, open a linux based terminal.
4. Type `flutter doctor ` - Checks if flutter has been correctly installed. 
5. Type `flutter run ` - To run the flutter application.

Device specifications have been mentioned below. **WARNING - Devices that are not of the following specifications will either not run the program or will show buggy outputs.**

## About data storage

Upon completion, each of these tests will record user results in JSON format. The scoring system varies across tests, with some being time-bound while others are not. The available tests include `Phonemic Fluency`, `Categoric Fluency`, `Verbal Learning (Immediate and Delayed)`, `FAST Writing`, `FAST Comprehension`, `FAST Reading`, and `FAST Expression`.

## Device and Environment specifications 

The application has been written with large tablet devices that have android support in mind. The following specifications given below are of importance. 

### Environment specifications 

1. *Flutter 3.24.2*
2. *Dart 3.5.2*
3. *Minimum SDK Version* - 16 (Android 4.1 Jelly Bean)
4. *Target SDK Version* - 34 (Android 14)
5. *>=Android Studio 2023.1.1* - Recommended Version (Android Studio 2023.2.1, Iguana)

### Device specifications 

1.  *Operating System: Android 13 or higher*
2.  *Processor: Octa-core (or equivalent performance)*
3.  *Storage: 128 GB or more recommended*
4.  *Screen: High-resolution (Full HD+ or higher)*

Device example 👉 **OnePlus Pad Go (8GB RAM variant)**
