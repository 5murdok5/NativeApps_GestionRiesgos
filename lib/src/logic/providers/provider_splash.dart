import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:gestionriesgos/src/global/global_page_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {
  // late CameraDescription _cameras;
  // CameraDescription get cameras => _cameras;
  late SharedPreferences prefs;

  SplashProvider() {
    getCamerasAvailable();
    Future.delayed(const Duration(seconds: 1), () async {
      prefs = await SharedPreferences.getInstance();
      bool isLog = prefs.getBool('isLoggin') ?? false;
      return toPage(
        name: isLog ? '/home' : '/login',
        fade: true,
        removePreviusPages: true,
      );
    });
  }

  getCamerasAvailable() async {
    final List<CameraDescription> respCameras = await availableCameras();
    log('cameras available ${respCameras.length.toString()}');
    // _cameras = respCameras.first;
    notifyListeners();
  }
}
