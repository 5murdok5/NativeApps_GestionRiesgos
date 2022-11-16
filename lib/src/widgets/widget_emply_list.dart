import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/widgets/widget_text.dart';

class EmplyPageText extends StatelessWidget {
  final String description;
  const EmplyPageText({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.app_shortcut_rounded,
          color: Colors.grey[300],
          size: 60,
        ),
        text(
          description,
          type: 'title2',
          textAlign: TextAlign.center,
          color: Colors.grey[300],
          padding: EdgeInsets.only(
            top: height * 0.03,
            bottom: height * 0.02,
            left: width * 0.2,
            right: width * 0.2,
          ),
        ),
      ],
    );
  }
}
