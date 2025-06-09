import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Treatments/EditTreatment.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Treatments/Treatments.dart';
import 'package:bighter_panel/models/Treatments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class Treatments_card extends StatefulWidget {
  const Treatments_card({
    super.key,
    required this.tm,
    required this.update,
  });
  final Treatments_model tm;
  final Function update;
  @override
  State<Treatments_card> createState() => _Treatments_cardState();
}

class _Treatments_cardState extends State<Treatments_card> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Row(
            children: [
              currentWidth <= 600
                  ? Column(
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     glb.ConfirmationBox(context, "Remove treatment", () {
                        //       DelTreatments_async(widget.tm.ID);
                        //     });
                        //   },
                        //   child: CircleAvatar(
                        //     backgroundColor: Colours.Red,
                        //     child: Icon(
                        //       Iconsax.minus,
                        //     ),
                        //   ),
                        // ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  currentWidth <= 600 ? Sizer.w_20 : Sizer.w_50,
                                  currentWidth <= 600
                                      ? Sizer.h_10 * 2
                                      : Sizer.h_50),
                              backgroundColor: Colours.Red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Sizer.radius_10),
                                  bottomLeft: Radius.circular(Sizer.radius_10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              glb.ConfirmationBox(context, "Remove treatment",
                                  () {
                                DelTreatments_async(widget.tm.ID);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colours.icn_white,
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(Sizer.w_50, Sizer.h_50),
                              backgroundColor: Colours.nonPhoto_blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Sizer.radius_10),
                                  bottomRight: Radius.circular(Sizer.radius_10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditTreatment(
                                            Treatment_id: widget.tm.ID,
                                          )));
                            },
                            child: Icon(
                              Icons.edit_note_outlined,
                              color: Colours.icn_white,
                            ))
                      ],
                    )
                  : Row(
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     glb.ConfirmationBox(context, "Remove treatment", () {
                        //       DelTreatments_async(widget.tm.ID);
                        //     });
                        //   },
                        //   child: CircleAvatar(
                        //     backgroundColor: Colours.Red,
                        //     child: Icon(
                        //       Iconsax.minus,
                        //     ),
                        //   ),
                        // ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  currentWidth <= 600 ? Sizer.w_20 : Sizer.w_50,
                                  currentWidth <= 600
                                      ? Sizer.h_10 * 2
                                      : Sizer.h_50),
                              backgroundColor: Colours.Red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Sizer.radius_10),
                                  bottomLeft: Radius.circular(Sizer.radius_10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              glb.ConfirmationBox(context, "Remove treatment",
                                  () {
                                DelTreatments_async(widget.tm.ID);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colours.icn_white,
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(Sizer.w_50, Sizer.h_50),
                              backgroundColor: Colours.nonPhoto_blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Sizer.radius_10),
                                  bottomRight: Radius.circular(Sizer.radius_10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditTreatment(
                                            Treatment_id: widget.tm.ID,
                                          )));
                            },
                            child: Icon(
                              Icons.edit_note_outlined,
                              color: Colours.icn_white,
                            ))
                      ],
                    ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: currentWidth <= 600
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 3,
                            child: Txt(
                              text: widget.tm.treatment,
                              maxLn: 1,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Txt(text: "₹ " + widget.tm.price),
                              )),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Sizer.w_50 * 3,
                            child: Txt(
                              text: widget.tm.treatment,
                              maxLn: 1,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Txt(text: "₹ " + widget.tm.price),
                              )),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DelTreatments_async(String id) async {
    print("get treatments async ${glb.doctor.doc_id}");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.del_docTrtmnts);

    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          // 'doc_id': '${glb.doctor.doc_id}',
          'ID': '$id',
        },
      );
      print(res.statusCode);
      print("body = " + res.body);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        glb.SuccessToast(context, "Done");
        widget.update();
      }
      print(bdy);
    } catch (e) {
      print("Exception => $e");
    }
  }
}
