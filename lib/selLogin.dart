import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Utilities/Responsive.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/Clinic/clinic_pg.dart';

import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class UserSel extends StatefulWidget {
  const UserSel({super.key});

  @override
  State<UserSel> createState() => _UserSelState();
}

class _UserSelState extends State<UserSel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            SizedBox(
              height: Sizer.h_50,
            ),
            Txt(
              text: "Bighter",
              fontColour: Colours.blue,
              size: 22,
              fntWt: FontWeight.bold,
            ),
            SizedBox(
              height: Sizer.h_50,
            ),
            Wrap(
              spacing: Sizer.h_10,
              runSpacing: Sizer.w_10 * 5,
              children: [
                Material(
                  elevation: 10,
                  shadowColor: Color.fromARGB(255, 175, 212, 247),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizer.radius_10 / 5),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        glb.usrTyp = '0';
                      });
                      print("Admin login");

                      // Navigator.pushNamed(context, RG.login_rt);
                      Navigator.pushNamed(context, RG.login_rt);
                    },
                    child: w200SizedBox(
                      wd: Sizer.w_50 * 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 175, 212, 247),
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Image.asset(
                                          "assets/images/admin.png")),
                                  Txt(text: "Admin login"),
                                ],
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: Sizer.icn_50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 10,
                  shadowColor: Color.fromARGB(255, 233, 215, 160),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizer.radius_10),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("Doctor login");
                      setState(() {
                        glb.usrTyp = '1';
                      });
                      Navigator.pushNamed(context, RG.login_rt);
                      print("Doctor login in ");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => logi(),
                      //   ),
                      // );
                    },
                    child: w200SizedBox(
                      wd: Sizer.w_50 * 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 233, 215, 160),
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 100,
                                      height: 50,
                                      child:
                                          Image.asset("assets/images/doc.png")),
                                  Txt(text: "Doctor login"),
                                ],
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: Sizer.icn_50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: Sizer.h_50,
                //   width: Sizer.w_50,
                // ),
                Material(
                  elevation: 10,
                  shadowColor: Color(0xffEED3D9),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizer.radius_10 / 5),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        glb.usrTyp = '2';
                      });
                      print("Clinic login");
                      Navigator.pushNamed(context, RG.login_rt);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => clinicHome_pg()));
                    },
                    child: w200SizedBox(
                      wd: Sizer.w_50 * 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffEED3D9),
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 100,
                                      height: 50,
                                      child: Image.asset(
                                          "assets/images/clinic.png")),
                                  Txt(text: "Clinic login"),
                                ],
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: Sizer.icn_50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
