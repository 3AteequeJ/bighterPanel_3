import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';

class ScreenError extends StatefulWidget {
  const ScreenError({super.key});

  @override
  State<ScreenError> createState() => _ScreenErrorState();
}

class _ScreenErrorState extends State<ScreenError> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Open in full screen",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
