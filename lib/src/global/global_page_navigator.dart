import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/global/actions/actions_toast.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';

toPage({
  String? name,
  Widget? page,
  bool removePreviusPages = false,
  bool fade = false,
}) {
  if (name != null) {
    log('Navigate to: $name');
  }
  if (name != null) {
    if (removePreviusPages) {
      return Navigator.pushNamedAndRemoveUntil(
        ctx!,
        name,
        (Route<dynamic> route) => false,
      );
    } else {
      return Navigator.pushNamed(
        ctx!,
        name,
      );
    }
  } else if (page != null) {
    if (removePreviusPages) {
      return Navigator.pushAndRemoveUntil(
        ctx!,
        fade
            ? CustomPageRoute(page)
            : CupertinoPageRoute(
                builder: (BuildContext context) => page,
              ),
        (Route<dynamic> route) => false,
      );
    } else {
      return Navigator.push(
        ctx!,
        fade
            ? CustomPageRoute(page)
            : MaterialPageRoute(
                builder: (BuildContext context) => page,
              ),
      );
    }
  } else {
    return showToast('Upps! no va a nunguna lado', type: 'error');
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute(this.child);
  @override
  //  implement barrierColor
  Color get barrierColor => const Color.fromARGB(255, 255, 255, 255);

  @override
  String get barrierLabel => "";

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);
}
