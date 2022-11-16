import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/logic/providers/provider_splash.dart';
import 'package:gestionriesgos/src/theme/theme.dart';
import 'package:gestionriesgos/src/widgets/widget_text.dart';
import 'package:provider/provider.dart';

class PageSplash extends StatelessWidget {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kprimaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(
              'Gestion de Riesgos',
              type: 'title',
              color: Colors.white.withAlpha(190),
              padding: const EdgeInsets.only(bottom: 10),
            ),
            Icon(
              Icons.warning_amber_rounded,
              size: 70,
              color: Colors.white.withAlpha(190),
            ),
          ],
        ),
      ),
    );
  }
}
