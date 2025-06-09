import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';

class Dashboadrd extends StatefulWidget {
  const Dashboadrd({super.key});

  @override
  State<Dashboadrd> createState() => _DashboadrdState();
}

class _DashboadrdState extends State<Dashboadrd> {
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
                runSpacing: Sizer.h_10,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colours.orange,
                      borderRadius: BorderRadius.circular(Sizer.radius_10 / 5),
                    ),
                    height: Sizer.h_50 * 2.5,
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 8,
                    // constraints: BoxConstraints(minHeight: 100, minWidth: 100),
                    child: Padding(
                      padding: EdgeInsets.all(Sizer.Pad / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  currentWidth <= 600 ? 50.w : Sizer.w_50 * 2,
                              child: Image.asset("assets/images/inClinic.png")),
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
                  Container(
                    height: Sizer.h_50 * 2.5,
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 8,
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
                  Container(
                    height: Sizer.h_50 * 2.5,
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 8,
                    decoration: BoxDecoration(
                      color: Colours.orange,
                      borderRadius: BorderRadius.circular(Sizer.radius_10 / 5),
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
                              child: Image.asset("assets/images/docs.png")),
                          SizedBox(
                            width: Sizer.w_20 / 2,
                          ),
                          Expanded(
                            child: Txt(
                              text: "Total doctors",
                              size: 12,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(.5),
                            child: Padding(
                              padding: EdgeInsets.all(Sizer.Pad / 3),
                              child: Txt(text: "${glb.Tdocs}"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   height: Sizer.h_50 * 2.5,
                  //   width: Sizer.w_50 * 8,
                  //   decoration: BoxDecoration(
                  //     color: Colours.green,
                  //     borderRadius: BorderRadius.circular(Sizer.radius_10 / 5),
                  //   ),
                  //   // constraints: BoxConstraints(minHeight: 100, minWidth: 100),
                  //   child: Padding(
                  //     padding: EdgeInsets.all(Sizer.Pad / 2),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         SizedBox(
                  //             width: Sizer.w_50 * 2,
                  //             child: Image.asset("assets/images/docs.png")),
                  //         SizedBox(
                  //           width: Sizer.w_20 / 2,
                  //         ),
                  //         Expanded(
                  //           child: Txt(
                  //             text: "Total nurses",
                  //             size: 12,
                  //           ),
                  //         ),
                  //         CircleAvatar(
                  //           backgroundColor: Colors.white.withOpacity(.5),
                  //           child: Padding(
                  //             padding: EdgeInsets.all(Sizer.Pad / 3),
                  //             child: Txt(text: "03"),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
