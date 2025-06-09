import 'package:bighter_panel/Admin/SideMenuPages/doctors/VerifiedDoctors/doctors.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:bighter_panel/Admin/Home_pg.dart' as hp;

class Main_pg extends StatefulWidget {
  const Main_pg({super.key});

  @override
  State<Main_pg> createState() => _Main_pgState();
}

class _Main_pgState extends State<Main_pg> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: EdgeInsets.all(Sizer.Pad),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: Sizer.w_20 / 3,
                runSpacing: Sizer.h_10,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colours.orange,
                      borderRadius: BorderRadius.circular(2.77.w),
                    ),
                    height: Sizer.h_50 * 2.5,
                    width: currentWidth <= 600 ? 100.w : 26.04.w,
                    // constraints: BoxConstraints(minHeight: 100, minWidth: 100),
                    child: Padding(
                      padding: EdgeInsets.all(Sizer.Pad / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  currentWidth <= 600 ? 20.w : Sizer.w_50 * 2,
                              child: Image.asset("assets/images/inClinic.png")),
                          SizedBox(
                            width: Sizer.w_20 / 2,
                          ),
                          Expanded(
                              child: Txt(
                            text: "Total Clinics",
                            size: 12,
                          )),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(0.55.w),
                            ),
                            child: Center(
                                child: Txt(
                              text: "${glb.Tclinics}",
                              // fontColour: Colours.orange,
                              fntWt: FontWeight.bold,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Sizer.h_50 * 2.5,
                    width: currentWidth <= 600 ? 100.w : 26.04.w,
                    decoration: BoxDecoration(
                      color: Colours.green,
                      borderRadius: BorderRadius.circular(Sizer.radius_10 / 5),
                    ),
                    // constraints: BoxConstraints(minHeight: 100, minWidth: 100),
                    child: Padding(
                      padding: EdgeInsets.all(Sizer.Pad / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => allDocs_pg()));
                            },
                            child: SizedBox(
                                 width: currentWidth <= 600 ? 20.w : Sizer.w_50 * 2,
                                child: Image.asset("assets/images/docs.png")),
                          ),
                          SizedBox(
                            width: Sizer.w_20 / 2,
                          ),
                          Expanded(
                            child: Txt(
                              text: "Total doctors",
                              size: 12,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5),
                              borderRadius: BorderRadius.circular(0.55.w),
                            ),
                            child: Center(
                              child: Txt(
                                text: "${glb.Tdocs}",
                                // fontColour: Colours.green,
                                fntWt: FontWeight.bold,
                              ),
                            ),
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.white.withOpacity(.5),
                          //   child: Padding(
                          //     padding: EdgeInsets.all(Sizer.Pad / 3),
                          //     child: Txt(text: "06"),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
