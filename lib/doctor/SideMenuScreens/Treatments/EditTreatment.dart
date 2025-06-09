// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import '../../../Utilities/colours.dart';
import '../../../Utilities/customSizedBox.dart';
import '../../../Utilities/sizer.dart';
import '../../../Utilities/text/txt.dart';
import '../../../models/Treatments_model.dart';

class EditTreatment extends StatefulWidget {
  const EditTreatment({
    super.key,
    required this.Treatment_id,
  });
  final String Treatment_id;
  @override
  State<EditTreatment> createState() => _EditTreatmentState();
}

List<String> list = ['per session', 'whole procedure'];

class _EditTreatmentState extends State<EditTreatment> {
  TextEditingController trtmnt_cont = TextEditingController();
  TextEditingController price_cont = TextEditingController();
  TextEditingController duration_cont = TextEditingController();
  TextEditingController desc_cont = TextEditingController();

  String dropdownValue = list.first;

  @override
  void initState() {
    // TODO: implement initState
    trtmnt_cont.text = getTreatmentNM(widget.Treatment_id);
    price_cont.text = getTreatment_price(widget.Treatment_id);
    duration_cont.text = getTreatmentDuration(widget.Treatment_id);
    desc_cont.text = getTreatmentDesc(widget.Treatment_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.RosePink,
        title: Txt(
          text: "Edit treatment",
          fontColour: Colours.txt_white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizer.Pad),
        child: Container(
          height: 150,
          width: 100.w,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Container(
              constraints: BoxConstraints(maxWidth: 1000),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 350,
                        child: TextField(
                          controller: trtmnt_cont,
                          decoration: InputDecoration(
                            labelText: "Treatment",
                            hoverColor: Colours.HunyadiYellow,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: price_cont,
                          decoration: InputDecoration(
                            labelText: "Price",
                            prefixText: "₹ ",
                            hoverColor: Colours.HunyadiYellow,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      w200SizedBox(
                        wd: 100,
                        child: TextField(
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          // ],
                          controller: duration_cont,
                          decoration: InputDecoration(
                            labelText: "Duration",
                            // prefixText: "please mention ",
                            hoverColor: Colours.HunyadiYellow,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      w200SizedBox(
                        wd: 500,
                        child: TextField(
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          // ],
                          controller: desc_cont,
                          decoration: InputDecoration(
                            labelText: "Description",
                            // prefixText: "please mention ",
                            hoverColor: Colours.HunyadiYellow,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          if (price_cont.text.isEmpty ||
                              trtmnt_cont.text.isEmpty) {
                            // glb.errorToast(
                            //     context, "Enter all the details.");
                          } else {
                            String a = trtmnt_cont.text.trim();
                            String b = price_cont.text.trim();
                            String c = duration_cont.text.trim();
                            String d = desc_cont.text.trim();
                            // glb.loading(context);
                            UpdateTreatments_async(
                              widget.Treatment_id,
                              a,
                              b,
                              c,
                              d,
                            );
                          }
                        },
                        child: Txt(text: "Update"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  UpdateTreatments_async(String treatment_id, String trtmnt, String price,
      String duration, String desc) async {
    print("get treatments async ${glb.doctor.doc_id}");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.updateTreatment);

    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          'treatment_id': treatment_id,
          // 'doc_id': '',
          "treatment": "$trtmnt",
          "price": "$price",
          'duration': '$duration',
          'Description': '$desc',
        },
      );
      print(res.statusCode);
      print(res.body);
      // var bdy = jsonDecode(res.body);
      // List b = jsonDecode(res.body);
      if (res.statusCode == 200) {
        getTreatments_async();
        glb.SuccessToast(context, "Done");
        trtmnt_cont.clear();
        price_cont.clear();
        duration_cont.clear();
        desc_cont.clear();
      } else {
        glb.errorToast(context, "Something went wrong");
      }

      // print(bdy);
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<Treatments_model> TM = [];
  getTreatments_async() async {
    TM = [];
    print("get treatments async ${glb.doctor.doc_id}");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getDocTreatments);
    String BD = '';
    String docID = '';
    if (glb.usrTyp == '1') {
      BD = '0';
      docID = glb.doctor.doc_id;
    } else {
      BD = '1';
      docID = glb.clinicBranchDoc.doc_id;
    }
    print("docID = $docID");
    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          // 'doc_id': '${glb.doctor.doc_id}',
          'doc_id': '$docID',
          'branch_doc': '$BD',
        },
      );
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);

      for (int i = 0; i < b.length; i++) {
        setState(() {
          TM.add(
            Treatments_model(
              ID: bdy[i]['ID'].toString(),
              doc_id: bdy[i]['doc_id'].toString(),
              treatment: bdy[i]['treatment'].toString(),
              price: bdy[i]['price'].toString(),
              rating: bdy[i]['rating'].toString(),
              desc: bdy[i]['Description'].toString(),
              duration: bdy[i]['duration'].toString(),
            ),
          );
        });
      }
      setState(() {
        glb.Models.Treatments_lst = TM;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => glb.usrTyp == '1'
                    ? DocHome_pg(
                        pgNO: 3,
                      )
                    : clinicHome_pg(
                        pgNO: 4,
                      )));
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}

getTreatmentNM(String id) {
  String a = '';
  for (int i = 0; i < glb.Models.Treatments_lst.length; i++) {
    if (id == glb.Models.Treatments_lst[i].ID) {
      a = glb.Models.Treatments_lst[i].treatment;
      break;
    }
  }
  return a;
}

getTreatment_price(String id) {
  String a = '';
  for (int i = 0; i < glb.Models.Treatments_lst.length; i++) {
    if (id == glb.Models.Treatments_lst[i].ID) {
      a = glb.Models.Treatments_lst[i].price;
      break;
    }
  }
  return a;
}

getTreatmentDesc(String id) {
  String a = '';
  for (int i = 0; i < glb.Models.Treatments_lst.length; i++) {
    if (id == glb.Models.Treatments_lst[i].ID) {
      a = glb.Models.Treatments_lst[i].desc;
      break;
    }
  }
  return a;
}

getTreatmentDuration(String id) {
  String a = '';
  for (int i = 0; i < glb.Models.Treatments_lst.length; i++) {
    if (id == glb.Models.Treatments_lst[i].ID) {
      a = glb.Models.Treatments_lst[i].duration;
      break;
    }
  }
  return a;
}
