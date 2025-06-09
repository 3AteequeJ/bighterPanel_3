// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/patientDets.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class AppointmentRequest_cards extends StatefulWidget {
  const AppointmentRequest_cards({
    super.key,
    required this.AM,
    // required this.sts,
    required this.typ,
    // required this.pg,
  });
  final Appointments_model AM;
  // final String sts;
  final String typ;
  // final String pg;
  @override
  State<AppointmentRequest_cards> createState() =>
      _AppointmentRequest_cardsState();
}

class _AppointmentRequest_cardsState extends State<AppointmentRequest_cards> {
  bool Vis = true;
  var a;
  @override
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.typ == widget.AM.type,
      child: Padding(
        padding: EdgeInsets.all(7.sp),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colours.nonPhoto_blue.withOpacity(.6),
            // borderRadius: BorderRadius.circular(Sizer.radius_10),
            border: Border(
                left: BorderSide(
                    width: 3,
                    color: widget.AM.type == '0'
                        ? Colours.RosePink
                        : Colours.green),
                bottom: BorderSide(
                  color: Color.fromARGB(255, 102, 83, 83),
                )),
          ),
          child: Padding(
            padding: EdgeInsets.all(7.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colours.icn_black,
                      // size: Sizer.icn_50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Txt(text: glb.getDateTIme(widget.AM.dt_time)),
                        Txt(text: glb.getDate(widget.AM.dt_time))
                      ],
                    ),
                  ],
                ),
                VerticalDivider(
                  color: Colours.orange,
                ),
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: ClipRect(
                          child: Image.network(
                            // fit: BoxFit.cover,
                            "${widget.AM.usr_img}",
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/images/user.png");
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Sizer.w_10,
                      ),
                      Txt(text: "${widget.AM.userNM}")
                    ],
                  ),
                ),
                Visibility(
                  visible: glb.usrTyp != '1',
                  child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: ClipRect(
                            child: Image.network(
                              // fit: BoxFit.cover,
                              getDocimg(widget.AM.doc_id),
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/images/doc.png");
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Sizer.w_10,
                        ),
                        Txt(text: "${getDocNM(widget.AM.doc_id)}")
                      ],
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colours.orange,
                ),
                // glb.usrTyp == '2'
                //     ? Container(
                //         child: Row(
                //           children: [
                //             CircleAvatar(
                //               child: ClipRRect(
                //                 child: Image.network(
                //                   fit: BoxFit.cover,
                //                   "${getDocimg(widget.AM.doc_id)}",
                //                   errorBuilder: (context, error, stackTrace) {
                //                     return Image.asset("assets/images/user.png");
                //                   },
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //               width: Sizer.w_10,
                //             ),
                //             Txt(text: "${getDocNM(widget.AM.doc_id)}")
                //           ],
                //         ),
                //       )
                //     :
                Visibility(
                    visible: glb.clinicRole == '0',
                    child: Column(
                      children: [
                        Txt(
                          text: widget.AM.clinicNM,
                        ),
                        Txt(
                          text: widget.AM.city,
                        ),
                        Txt(
                          text: widget.AM.state,
                        ),
                      ],
                    )),
                Visibility(
                  visible: glb.clinicRole == '2',
                  child: Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colours.nonPhoto_blue,
                            ),
                            onPressed: () {
                              // Navigator.pushNamed(context, RG.PatientDetails_rt);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PatientDetails(
                                            usrNM: "${widget.AM.userNM}",
                                            img: widget.AM.usr_img,
                                            mail: widget.AM.usr_mail,
                                            usrMobno: widget.AM.usr_mobno,
                                          )));
                            },
                            child: Txt(text: "Details")),
                        SizedBox(
                          width: Sizer.w_10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {},
                            child: Txt(text: "Done"))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  updtSts_async(String id) async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.update_status);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'app_id': "${id}",
        'sts': '1',
      });
      print(res.statusCode);
      print(res.body);
      var bdy = json.decode(res.body);

      if (res.body == "1") {
        glb.SuccessToast(context, "Done");
        getDocAppointments_async();
      }
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<Appointments_model> AM = [];
  getDocAppointments_async() async {
    AM = [];
    print("getDocAppointments_async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getDocAppointments);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'all': '1',
        'doctor_id': "${glb.doctor.doc_id}",
      });
      print(res.statusCode);
      print(res.body);
      var bdy = json.decode(res.body);
      List b = json.decode(res.body);
      print(bdy[0]['status']);
      for (int i = 0; i < b.length; i++) {
        AM.add(
          Appointments_model(
            ID: bdy[i]['ID'].toString(),
            userID: bdy[i]['user_id'].toString(),
            userNM: bdy[i]['name'].toString(),
            clinicID: bdy[i]['clinic_id'].toString(),
            dt_time: bdy[i]['timing'].toString(),
            usr_img: "${glb.API.baseURL}images/user_images/" +
                bdy[i]['user_img'].toString(),
            type: bdy[i]['type'].toString(),
            status: bdy[i]['status'].toString(),
            doc_id: bdy[i]['doctor_id'].toString(),
            usr_mail: bdy[i]['mobile_no'].toString(),
            usr_mobno: bdy[i]['email_id'].toString(),
            clinicNM: bdy[i]['branch_nm'].toString(),
            city: bdy[i]['city'].toString(),
            state: bdy[i]['state'].toString(),
            doc_nm: bdy[i]['doc_nm'].toString(),
            doc_img: bdy[i]['doc_img'].toString(),
          ),
        );
      }
      setState(() {
        Navigator.pushReplacementNamed(context, RG.Doc_homePG_rt);
        glb.Models.appointments_lst = AM;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}

getDocNM(String doc_id) {
  String a = "";
  for (int i = 0; i < glb.Models.BranchDoc_lst.length; i++) {
    if (doc_id == glb.Models.BranchDoc_lst[i].id) {
      a = glb.Models.BranchDoc_lst[i].name;
      break;
    } else {
      a = "";
    }
  }
  return a;
}

getDocimg(String doc_id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    if (doc_id == glb.Models.AllDocs_lst[i].ID) {
      a = glb.Models.AllDocs_lst[i].img;
      break;
    } else {
      a = "";
    }
  }
  return a;
}

getBrach_doc(String doc_id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    if (doc_id == glb.Models.AllDocs_lst[i].ID) {
      a = glb.Models.AllDocs_lst[i].img;
      break;
    } else {
      a = "";
    }
  }
  return a;
}
