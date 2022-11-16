import 'package:flutter/widgets.dart';
import 'package:gestionriesgos/src/global/actions/actions_toast.dart';
import 'package:gestionriesgos/src/global/global_page_navigator.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/logic/providers/provider_report.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  late SharedPreferences prefs;

  AuthProvider() {
    Future.delayed(const Duration(milliseconds: 400), () async {
      prefs = await SharedPreferences.getInstance();
    });
  }
  // Variables
  late bool _loadAutn = false;
  bool get loadAuth => _loadAutn;

  // Methods
  authAnonimo() {
    _loadAutn = true;
    notifyListeners();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        _loadAutn = false;
        await prefs.setBool('isLoggin', true);
        notifyListeners();
        toPage(
          name: '/home',
          fade: true,
          removePreviusPages: true,
        );
        showToast('Bienvenido, Usuario Anónimo', type: 'success');
      },
    );
  }

  authCredentiasl() {
    showToast('Lo siento, Esta función aún no está disponible', type: 'alert');
  }

  logOut() async {
    await prefs.setBool('isLoggin', false);
    await prefs.setString('reports', '');
    toPage(
      name: '/login',
      fade: true,
      removePreviusPages: true,
    );
    showToast('Gracias por usar nuestro servicio', type: 'succcess');
  }
}
