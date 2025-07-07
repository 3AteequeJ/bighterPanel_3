import 'package:bighter_panel/Admin/SideMenuPages/doctors/VerifiedDoctors/VerifiedDocDets.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class AllDocs_card extends StatefulWidget {
  const AllDocs_card({
    super.key,
    required this.AD,
  });
  final AllDoc_model AD;
  @override
  State<AllDocs_card> createState() => _AllDocs_cardState();
}

class _AllDocs_cardState extends State<AllDocs_card> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.AD.verified == '1',
      child: Padding(
        padding: EdgeInsets.all(14.sp),
        child: Container(
          width: 20.w,
          height: currentWidth <= 600 ? 10.h : 5.55.h,

          decoration: BoxDecoration(
            color: Colors.red,
            border: Border(
              bottom: BorderSide(
                color: Colours.divider_grey,
              ),
              left: BorderSide(
                  width: (1.302 / 5).w,
                  color: widget.AD.available == '0'
                      ? Colours.orange
                      : Colours.green),
            ),
          ),
          child:
          Padding(
            padding: EdgeInsets.all(7.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 0.651.w,
                    ),
                    CircleAvatar(
                      radius: currentWidth <= 600 ? 6.w : 2.77.w,
                      backgroundImage: NetworkImage(
                        widget.AD.img,
                      ),
                      onBackgroundImageError: (exception, stackTrace) {
                        Image.asset("assets/images/doc.png");
                      },
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Txt(
                          text: "${widget.AD.name}",
                          maxLn: 1,
                          fntWt: FontWeight.bold,
                        ),
                        Txt(
                          text: "${widget.AD.speciality}",
                          size: 10,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 0.651.w,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.nonPhoto_blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.55.w),
                    ),
                  ),
                  onPressed: () {
                    print(widget.AD.name);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifiedDocDets(
                                  id: widget.AD.ID,
                                )));
                  },
                  child: Txt(text: "Details"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
