import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/global/actions/actions_toast.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/widgets/widget_app_bar_pages.dart';
import 'package:gestionriesgos/src/widgets/widget_button.dart';
import 'package:gestionriesgos/src/widgets/widget_load.dart';

class PageCamera extends StatefulWidget {
  final CameraDescription camera;
  final Function(String? path) getImg;
  const PageCamera({super.key, required this.camera, required this.getImg});

  @override
  State<PageCamera> createState() => _PageCameraState();
}

class _PageCameraState extends State<PageCamera> with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String path = '';
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> takepicture() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      _controller.takePicture().then((image) {
        setState(() {
          path = image.path;
          _controller.dispose();
          widget.getImg(path);
          back();
        });
        // if (image != null) {
        //   showToast('Picture saved to ${image.path}');
        // }
      });
    } catch (e) {
      // If an error occurs, log the error to the console.
      showToast(e.toString());
    }
  }

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (!cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarPages(
        showArrow: false,
        title: 'Agregar Fotografía',
      ),
      body: path != ''
          ? const SizedBox()
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async => await takepicture(),
                          child: CameraPreview(
                            _controller,
                          ),
                        ),
                      ),
                      btnTakePic(),
                      button(
                        'Cancelar',
                        type: 'primary_line',
                        margin: EdgeInsets.only(
                          top: 10,
                          left: width * 0.04,
                          right: width * 0.04,
                        ),
                        showArrow: false,
                        onTap: () => back(),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: loadwidget(),
                  );
                }
              },
            ),
    );
  }

  Widget btnTakePic() {
    return button(
      // Provide an onPressed callback.
      'Tomar Foto del Lugar',
      showArrow: false,
      margin: EdgeInsets.only(
        top: 15,
        left: width * 0.04,
        right: width * 0.04,
      ),
      padding: const EdgeInsets.all(25),
      onTap: () async => await takepicture(),
    );
  }
}
