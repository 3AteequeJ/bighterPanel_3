import 'dart:convert';

import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class DocDashboard extends StatefulWidget {
  const DocDashboard({super.key});

  @override
  State<DocDashboard> createState() => _DocDashboardState();
}

class _DocDashboardState extends State<DocDashboard> {
  bool light = true;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Switch(
                    // thumbIcon: thumbIcon,
                    value: light,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colours.orange,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                      });
                    },
                  ),
                  Txt(
                    text: light ? "Available" : "Unavailable",
                    fontColour: light ? Colors.green : Colours.orange,
                  )
                ],
              ),
              SizedBox(
                height: Sizer.h_10,
              ),
              Wrap(
                spacing: Sizer.w_20 / 3,
                children: [
                  InkWell(
                    onTap: () {
                      // getPharmacyPricing_async();
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocHome_pg(
                                      pgNO: 1,
                                    )));
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colours.orange,
                        borderRadius:
                            BorderRadius.circular(Sizer.radius_10 / 5),
                      ),
                      height: 17.132.h,
                      width: currentWidth <= 600 ? 100.w : 26.04.w,
                      // constraints: BoxConstraints(minHeight: 100, minWidth: 100),
                      child: Padding(
                        padding: EdgeInsets.all(Sizer.Pad / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:
                                    currentWidth <= 600 ? 50.w : Sizer.w_50 * 2,
                                child:
                                    Image.asset("assets/images/inClinic.png")),
                            SizedBox(
                              width: Sizer.w_20 / 2,
                            ),
                            Expanded(
                                child: Txt(
                              text: "Clinic appointments",
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
                                  text: "${glb.Tia}",
                                  // fontColour: Colours.green,
                                  fntWt: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DocHome_pg(
                                    pgNO: 1,
                                  )));
                    },
                    child: Container(
                      height: 17.132.h,
                      width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 8,
                      decoration: BoxDecoration(
                        color: Colours.green,
                        borderRadius:
                            BorderRadius.circular(Sizer.radius_10 / 5),
                      ),
                      // constraints: BoxConstraints(minHeight: 100, minWidth: 100),
                      child: Padding(
                        padding: EdgeInsets.all(Sizer.Pad / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width:
                                    currentWidth <= 600 ? 50.w : Sizer.w_50 * 2,
                                child:
                                    Image.asset("assets/images/videoCall.png")),
                            SizedBox(
                              width: Sizer.w_20 / 2,
                            ),
                            Expanded(
                              child: Txt(
                                text: "Video appointments",
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
                                  text: "${glb.Tva}",
                                  // fontColour: Colours.green,
                                  fntWt: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizer.h_50,
              ),
              Visibility(
                visible: !glb.featuredDoc,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colours.nonPhoto_blue),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RG.profile_prioritization_rt);

                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: Txt(
                      //           text: "Profile Prioritization",
                      //           fntWt: FontWeight.bold,
                      //         ),
                      //         content: SizedBox(
                      //           width: 70.w,
                      //           child: Txt(
                      //               text:
                      //                   "Submit your profile for admin approval to gain top placement in our listings. Once approved, your profile will be highlighted, increasing your visibility and making it easier for patients to find and book appointments with you. This feature ensures that only verified and trusted doctors are prominently displayed, enhancing the quality of care provided to our patients"),
                      //         ),
                      //         actions: [
                      //           ElevatedButton(
                      //               style: ElevatedButton.styleFrom(
                      //                   backgroundColor: Colours.Red,
                      //                   fixedSize: Size(
                      //                     Sizer.w_50 * 4,
                      //                     Sizer.h_50,
                      //                   )),
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Row(
                      //                 children: [
                      //                   Icon(
                      //                     Icons.cancel,
                      //                     color: Colours.icn_white,
                      //                   ),
                      //                   Txt(
                      //                     text: "Cancel",
                      //                     fontColour: Colours.txt_white,
                      //                   )
                      //                 ],
                      //               )),
                      //           ElevatedButton(
                      //               style: ElevatedButton.styleFrom(
                      //                   fixedSize: Size(
                      //                 Sizer.w_50 * 4,
                      //                 Sizer.h_50,
                      //               )),
                      //               onPressed: () {
                      //                 // addFeaturedDoc_async();

                      //                 // featuredDoc_async();
                      //               },
                      //               child: Row(
                      //                 children: [
                      //                   Txt(
                      //                     text: "Send request",
                      //                     fontColour: Colours.txt_white,
                      //                   ),
                      //                   Icon(
                      //                     Icons.double_arrow,
                      //                     color: Colours.icn_white,
                      //                   ),
                      //                 ],
                      //               ))
                      //         ],
                      //       );
                      //     });
                    },
                    child: Txt(
                      text: "Profile Prioritization",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getPharmacyPricing_async() async {
    print("get pharmacy pricing");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getPharmacyPricing);

    try {
      var res = await http.get(
        url,
      );
      var bdy = jsonDecode(res.body);
      print(res.statusCode);
      print(res.body);
      print("pharmacy pricing = " + bdy);

      setState(() {
        glb.pharmacyPricing.price = bdy[0]['price'].toString();
        glb.pharmacyPricing.price = bdy[0]['commission'].toString();
        glb.pharmacyPricing.price = bdy[0]['applicable'].toString();
      });
    } catch (e) {}
  }
}
