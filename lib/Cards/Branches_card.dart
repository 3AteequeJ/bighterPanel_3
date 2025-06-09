import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/branches_model.dart';
import 'package:flutter/material.dart';

import '../Utilities/sizer.dart';

class Branches_card extends StatefulWidget {
  const Branches_card({super.key, required this.bm});
  final Branches_model bm;
  @override
  State<Branches_card> createState() => _Branches_cardState();
}

class _Branches_cardState extends State<Branches_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(border: Border.all()),
      constraints: BoxConstraints(minHeight: 50),
      child: Padding(
        padding: EdgeInsets.all(Sizer.Pad / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: widget.bm.name,
                    fntWt: FontWeight.bold,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colours.orange,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(text: widget.bm.city),
                          Txt(text: widget.bm.state),
                        ],
                      )
                    ],
                  ),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Txt(text: "Edit"),
                  // )
                ],
              ),
            ),
            Container(
              height: 100,
              child: Image.network(
                "src",
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/images/clinic.png");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
