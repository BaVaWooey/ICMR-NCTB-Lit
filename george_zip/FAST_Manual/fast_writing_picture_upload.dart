import 'imports.dart';
import '../screen/screens.dart';

class FASTManualWritingPhotoUpload extends StatefulWidget {
  const FASTManualWritingPhotoUpload({super.key});

  @override
  State<FASTManualWritingPhotoUpload> createState() =>
      _FASTManualWritingPhotoUploadState();
}

class _FASTManualWritingPhotoUploadState
    extends State<FASTManualWritingPhotoUpload> {
  late CameraController controller;
  String imagePath = "";
  bool pictureTaken = false, pictureBeingTaken = false;

  @override
  void initState() {
    pictureTaken = false;
    pictureBeingTaken = false;
    initController();
    super.initState();
  }

  void initController() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
  }

  ///take picture

  void takePicture() async {
    final image = await controller.takePicture();

    final String path = image.path;
    setState(() {
      imagePath = path;
      finalImagePath = path;
      pictureTaken = true;
    });
    debugPrint("This picture has been saved to path - $path");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 100,
            title: const Text('FAST (Writing, picture upload)',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
        body: pictureBeingTaken == true
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: CameraPreview(controller),
                  ),
                  Center(
                      child: MaterialButton(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(30),
                          child: const Icon(Icons.camera, size: 30),
                          onPressed: () => {
                                ///uploading photo
                                takePicture(),
                                setState(() {
                                  pictureBeingTaken = false;
                                })
                              }))
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Center(
                        child: Text(
                            pictureTaken == true
                                ? 'Please Proceed'
                                : 'Press the button below to take photo',
                            style: TextStyle(
                                color: pictureTaken == true
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.bold))),
                    Center(
                        child: MaterialButton(
                      padding: const EdgeInsets.all(20),
                      shape: const CircleBorder(),
                      color: pictureTaken == true ? Colors.green : Colors.red,
                      onPressed: () => {
                        ////this is the functionality for uploading photo.
                        setState(() {
                          pictureBeingTaken = true;
                        })
                        //takePicture()
                      },
                      child: pictureTaken == true
                          ? const Icon(Icons.thumb_up, size: 35)
                          : const Icon(Icons.stop_screen_share_outlined,
                              size: 35),
                    )),
                    Center(
                        child: pictureTaken == true
                            ? Container(child: Image.file(File(imagePath)))
                            : const Text("Picture not taken yet",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)))
                  ]),
        floatingActionButton: Visibility(
          visible: pictureTaken,
          child: FloatingActionButton.extended(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FASTresults()))
                  },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Continue')),
        ));
  }
}
