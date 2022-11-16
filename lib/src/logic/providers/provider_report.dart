import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gestionriesgos/src/global/actions/actions_toast.dart';
import 'package:gestionriesgos/src/global/global_helpers.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/logic/model/model_conver_reports.dart';
import 'package:gestionriesgos/src/logic/model/model_report.dart';
import 'package:gestionriesgos/src/widgets/widget_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportProvider with ChangeNotifier {
  //Variables
  late XFile _imgFile = XFile('');
  XFile get imgFile => _imgFile;
  late String _detail = '';

  late bool _loadSave = false;
  bool get loadSave => _loadSave;

  late bool _loadGetRep = true;
  bool get loadGetRep => _loadGetRep;

  late List<ModelReport> _listReport = [];
  List<ModelReport> get listReport => _listReport;

  late SharedPreferences prefs;

  ReportProvider() {
    Future.delayed(const Duration(milliseconds: 400), () async {
      prefs = await SharedPreferences.getInstance();
      await getDataStorage();
    });
  }

  // Methods

  getDataStorage() async {
    String? repors = prefs.getString('reports');
    if (repors != null && repors != '') {
      final resp = json.decode(repors);
      final values = ModelConvertReport.fromMap(resp);
      _listReport = values.list!;
    }
    _loadGetRep = false;
    notifyListeners();
  }

  void onChangedetail(String dt) {
    _detail = dt;
    notifyListeners();
  }

  Future<void> ontapOption({bool isFromCamera = true}) async {
    final img = await takePicture(fromCamera: isFromCamera);
    if (img != null) {
      _imgFile = img;
    }
    notifyListeners();
  }

  Future<void> getPhoto() async {
    showAlert(
      title: 'Selecciona una Ubicación',
      description: 'Selecciona la ubicación de donde obtendrás la fotografía',
      textAcept: 'Camara',
      textCancel: 'Galeria',
      onAcept: () async => await ontapOption(isFromCamera: true),
      onCancel: () async => await ontapOption(isFromCamera: false),
    );
  }

  bool validateData() {
    if (_imgFile.path != '' && _detail != '') {
      return true;
    }
    return false;
  }

  void clear({bool withBack = false}) {
    _imgFile = XFile('');
    _detail = '';
    notifyListeners();
    if (withBack) back();
  }

  bool clearDataPrv({bool withBack = false}) {
    if (validateData() == true) {
      var status = false;
      showAlert(
        title: 'Has ingresado algunos datos',
        description:
            'Estas seguro de salir del formulario se eleminaran los datos que ya ingresaste',
        onAcept: () {
          clear(withBack: withBack);
          status = true;
        },
        onCancel: () {
          status = false;
        },
      );
      return status;
    } else {
      clear(withBack: withBack);
      return true;
    }
  }

  saveImgLocal(File currentFile) async {
    final String path =
        await getApplicationDocumentsDirectory().then((value) => value.path);
    final File newImage = await currentFile.copy('$path/image1.png');
    return newImage;
  }

  Future<void> onSaveReport() async {
    _loadSave = true;
    final newFile = await saveImgLocal(File(_imgFile.path));
    _listReport.add(ModelReport(
      path: newFile.path,
      description: _detail,
      date: DateTime.now().millisecondsSinceEpoch,
    ));
    _listReport.sort((a, b) => b.date!.compareTo(a.date!));
    notifyListeners();
    String storage = ModelConvertReport(list: _listReport).toJson();
    await prefs.setString('reports', storage);
    clear(withBack: true);
    showToast(
      'Reporte Guardado',
      type: 'success',
    );
    _loadSave = false;
    notifyListeners();
  }
}
