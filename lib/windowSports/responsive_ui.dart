import 'package:flutter/cupertino.dart';

class ResponsiveUi extends StatelessWidget {
  const ResponsiveUi({super.key, required this.mobile, required this.window});

  final Widget mobile;
  final Widget window;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapShot) {
      if (snapShot.maxWidth <= 600) {
        return mobile;
      } else {
        return window;
      }
    });
  }
}
