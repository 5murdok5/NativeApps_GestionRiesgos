import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/logic/providers/provider_auth.dart';
import 'package:gestionriesgos/src/logic/providers/provider_report.dart';
import 'package:gestionriesgos/src/logic/providers/provider_splash.dart';
import 'package:gestionriesgos/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: th.setThemeLight(),
        debugShowCheckedModeBanner: false,
        title: 'Gestión de Riesgos',
        initialRoute: '/',
        routes: Routes.routes,
      ),
    );
  }
}
