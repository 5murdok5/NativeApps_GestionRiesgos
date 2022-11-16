import 'package:flutter/cupertino.dart';
import 'package:gestionriesgos/src/pages/page_home.dart';
import 'package:gestionriesgos/src/pages/page_login.dart';
import 'package:gestionriesgos/src/pages/page_detail_report.dart';
import 'package:gestionriesgos/src/pages/page_splash.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const PageSplash(),
    '/login': (context) => const PageLogin(),
    '/home': (context) => const PageHome(),
    '/detail_report': (context) => const PageDetailReport(),
  };
}
