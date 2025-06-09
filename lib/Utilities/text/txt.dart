import 'package:bighter_panel/Utilities/colours.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class Txt extends StatefulWidget {
  Txt(
      {super.key,
      required this.text,
      this.size = 16,
      this.fontFam = 'Poppins',
      this.fontColour = Colours.txt_black,
      this.fntWt = FontWeight.normal,
      this.overflow = TextOverflow.ellipsis,
      this.maxLn = 3,
      this.textAlignment = TextAlign.left});
  final String text;
  double size;
  String fontFam;
  Color fontColour;
  FontWeight fntWt;
  TextOverflow overflow;
  int maxLn;
  TextAlign textAlignment;
  @override
  State<Txt> createState() => _TxtState();
}

class _TxtState extends State<Txt> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: widget.maxLn,
      textAlign: widget.textAlignment,
      style: TextStyle(
          // leadingDistribution: TextLeadingDistribution.proportional,
          fontSize: widget.size,
          fontFamily: widget.fontFam,
          color: widget.fontColour,
          fontWeight: widget.fntWt,
          overflow: widget.overflow),
    );
  }
}
