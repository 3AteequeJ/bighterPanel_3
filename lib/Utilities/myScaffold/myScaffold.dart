

import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/errorScreen/ScreenError.dart';
import 'package:flutter/material.dart';

class myScaffold extends StatefulWidget {
  const myScaffold({
    super.key,
    required this.app_bar,
    required this.widGet,
  });
  final AppBar app_bar;
  final Widget widGet;
  @override
  State<myScaffold> createState() => _myScaffoldState();
}

class _myScaffoldState extends State<myScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.app_bar,
      body: Dtyp(context) == "mobile"
          ? ScreenError()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: widget.widGet,
              ),
            ),
    );
  }
}
