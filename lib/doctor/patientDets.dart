import 'dart:math';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({
    super.key,
    required this.usrNM,
    required this.img,
    required this.mail,
    required this.usrMobno,
  });
  final String usrNM;
  final String usrMobno;
  final String mail;
  final String img;
  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colours.RosePink,
        centerTitle: true,
        title: Txt(text: "Patient Details"),
      ),
      body: Column(
        children: [
          Container(
            // height: Sizer.h_50 * 2.5,
            // color: Colours.nonPhoto_blue,
            child: Padding(
              padding: EdgeInsets.all(Sizer.Pad),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: Sizer.radius_10 * 2,
                    backgroundColor: Colours.HunyadiYellow,
                    foregroundImage: NetworkImage(widget.img,),
                  ),
                  SizedBox(
                    width: Sizer.w_20,
                  ),
                  SizedBox(
                    width: 50.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(text: "Name: ${widget.usrNM}"),
                            Txt(text: "Mobile number: ${widget.usrMobno}"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(text: "Mail: ${widget.mail}"),
                            // Txt(text: "Blood group: A+"),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Divider(
          //   color: Colours.divider_grey,
          // ),
          // Txt(text: "Medical history"),
          // Divider(
          //   color: Colours.divider_grey,
          // ),
        ],
      ),
    );
  }
}
