import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/theme/theme.dart';
import 'package:gestionriesgos/src/widgets/widget_text.dart';

PreferredSizeWidget appBarPages({
  String title = 'Title Here',
  String? subtitle,
  bool showArrow = true,
  Widget? widgetRight,
  Function()? onTapBack,
}) {
  return AppBar(
    backgroundColor: kprimaryColor,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    leading: showArrow
        ? IconButton(
            onPressed: () => onTapBack != null ? onTapBack() : back(),
            icon: const Icon(
              Icons.chevron_left_outlined,
              color: Colors.white,
            ),
          )
        : const SizedBox(),
    leadingWidth: showArrow ? 35 : 0,
    title: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(
                title,
                type: 'subtitle',
                color: Colors.white,
              ),
              if (subtitle != null)
                text(
                  toTitleCase(subtitle),
                  type: 'body2',
                  size: 13,
                  maxLines: 1,
                  color: Colors.white,
                ),
            ],
          ),
        ),
        if (widgetRight != null) widgetRight
      ],
    ),
  );
}
