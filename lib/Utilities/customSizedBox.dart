import 'package:flutter/cupertino.dart';

class w200SizedBox extends StatefulWidget {
  const w200SizedBox({
    super.key,
    // required this.hg,
    required this.wd,
    required this.child,
  });
  // final double hg;
  final double wd;
  final Widget child;
  @override
  State<w200SizedBox> createState() => _w200SizedBoxState();
}

class _w200SizedBoxState extends State<w200SizedBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: widget.hg,
      width: widget.wd,
      constraints: BoxConstraints(
        minWidth: 300,
        minHeight: 50,
      ),
      child: widget.child,
    );
  }
}
