import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllAppointments_card extends StatefulWidget {
  const AllAppointments_card({super.key});

  @override
  State<AllAppointments_card> createState() => _AllAppointments_cardState();
}

class _AllAppointments_cardState extends State<AllAppointments_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colours.divider_grey,
            ),
            // left: BorderSide(
            //     width: (1.302 / 5).w,
            //     color: widget.AD.available == '0'
            //         ? Colours.orange
            //         : Colours.green),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(7.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(text: "09/04/24 - 4:30 pm"),
              SizedBox(
                width: 0.651.w,
              ),
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 2.77.w,
                      backgroundColor: Colours.nonPhoto_blue,
                      // child: Image.network(
                      //   widget.AD.img,
                      //   errorBuilder: (context, error, stackTrace) {
                      //     return Image.asset("assets/images/doc.png");
                      //   },
                      // )
                    ),
                    SizedBox(
                      width: 0.651.w,
                    ),
                    Txt(text: "Patient name"),
                  ],
                ),
              ),
              SizedBox(
                width: 0.651.w,
              ),
              Container(
                  child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Txt(text: "Details")),
                  SizedBox(
                    width: 0.651.w,
                  ),
                  ElevatedButton(onPressed: () {}, child: Txt(text: "Details")),
                  SizedBox(
                    width: 0.651.w,
                  ),
                  ElevatedButton(onPressed: () {}, child: Txt(text: "Details")),
                ],
              )),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
