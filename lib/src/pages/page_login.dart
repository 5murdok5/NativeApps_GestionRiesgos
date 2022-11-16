import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/logic/providers/provider_auth.dart';
import 'package:gestionriesgos/src/widgets/widget_button.dart';
import 'package:gestionriesgos/src/widgets/widget_text.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatelessWidget {
  const PageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final paddlg = width * 0.08;
    final authPrv = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHzApp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(
                'Bienvenido a Gestión de Riesgos',
                type: 'title2',
                textAlign: TextAlign.center,
                padding: EdgeInsets.symmetric(
                  horizontal: paddlg,
                  vertical: 15,
                ),
              ),
              text(
                'Ingresa a nuestra app',
                type: 'subtitle2',
              ),
              TextButton(
                onPressed: () => {},
                child: text('Usuario Anonimo'),
              ),
              button(
                'Usuario Anonimo',
                margin: EdgeInsets.symmetric(
                  horizontal: paddlg,
                  vertical: 15,
                ),
                showArrow: false,
                load: authPrv.loadAuth,
                onTap: () => authPrv.authAnonimo(),
              ),
              button(
                'Ingresar con Credenciales',
                type: 'primary_line',
                margin: EdgeInsets.only(
                  left: paddlg,
                  right: paddlg,
                ),
                showArrow: true,
                onTap: () => authPrv.authCredentiasl(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
