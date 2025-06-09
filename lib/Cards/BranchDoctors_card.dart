import 'package:bighter_panel/Admin/SideMenuPages/doctors/VerifiedDoctors/VerifiedDocDets.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/models/BranchDocs_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class BranchDoctors_card extends StatefulWidget {
  const BranchDoctors_card({
    super.key,
    required this.AD,
  });
  final BranchDoctors_model AD;
  @override
  State<BranchDoctors_card> createState() => BranchDoctors_cardState();
}

class BranchDoctors_cardState extends State<BranchDoctors_card> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colours.divider_grey,
            ),
            left: BorderSide(width: (1.302 / 5).w, color: Colours.orange),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(7.sp),
          child: currentWidth <= 600
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 0.651.w,
                        ),
                        CircleAvatar(
                          radius: currentWidth <= 600 ? 10.w : 2.77.w,
                          backgroundImage: NetworkImage(
                            widget.AD.img1,
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
                    Visibility(
                      visible: glb.clinicRole == '0',
                      child: Container(
                        height: 100, width: 300,
                        // constraints: BoxConstraints(maxWidth: 300, maxHeight: 100),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colours.Red,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Txt(text: widget.AD.branch_nm),
                                  Txt(
                                    text: widget.AD.city,
                                    overflow: TextOverflow.ellipsis,
                                    maxLn: 1,
                                  ),
                                  Txt(
                                    text: widget.AD.state,
                                    maxLn: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      },
                      child: Txt(text: "Details"),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 0.651.w,
                        ),
                        CircleAvatar(
                          radius: currentWidth <= 600 ? 10.w : 2.77.w,
                          backgroundImage: NetworkImage(
                            widget.AD.img1,
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
                    Visibility(
                      visible: glb.clinicRole == '0',
                      child: Container(
                        height: 100, width: 300,
                        // constraints: BoxConstraints(maxWidth: 300, maxHeight: 100),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colours.Red,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Txt(text: widget.AD.branch_nm),
                                  Txt(
                                    text: widget.AD.city,
                                    overflow: TextOverflow.ellipsis,
                                    maxLn: 1,
                                  ),
                                  Txt(
                                    text: widget.AD.state,
                                    maxLn: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      },
                      child: Txt(text: "Details"),
                    )
                  ],
                ),
        ),
      ),
    );
    ;
  }
}
