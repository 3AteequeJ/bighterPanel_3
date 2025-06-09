// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bighter_panel/Cards/Treatments_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/commonScreens/addDoc.dart';
import 'package:bighter_panel/models/Treatments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';

class Treatments_scrn extends StatefulWidget {
  const Treatments_scrn({super.key});

  @override
  State<Treatments_scrn> createState() => _Treatments_scrnState();
}

List<String> list = ['per session', 'whole procedure', 'Enter manually'];

class _Treatments_scrnState extends State<Treatments_scrn> {
  TextEditingController trtmnt_cont = TextEditingController();
  TextEditingController price_cont = TextEditingController();
  TextEditingController price_per_cont = TextEditingController();
  TextEditingController duration_cont = TextEditingController();
  TextEditingController desc_cont = TextEditingController();
  TextEditingController hh_cont = TextEditingController();
  TextEditingController mm_cont = TextEditingController();

  String dropdownValue = list.first;
  bool tfVisi = false;
  @override
  void initState() {
    // TODO: implement initState
    getTreatments_async();
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        child: Column(
          children: [
            Row(),
            Txt(
              text: "ADD Treatments",
              fntWt: FontWeight.bold,
              fontColour: Colours.RussianViolet,
              size: 18,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                // height: 150,
                width: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Sizer.Pad),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 1000),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: Sizer.w_20,
                          runSpacing: Sizer.h_10,
                          children: [
                            SizedBox(
                              width: 350,
                              child: TextField(
                                controller: trtmnt_cont,
                                decoration: InputDecoration(
                                  labelText: "Treatment",
                                  hoverColor: Colours.HunyadiYellow,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Container(
                              width: 450,
                              // decoration: BoxDecoration(border: Border.all()),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      controller: price_cont,
                                      decoration: InputDecoration(
                                        labelText: "Price",
                                        prefixText: "₹ ",
                                        suffixText: "/",
                                        hoverColor: Colours.HunyadiYellow,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Sizer.radius_10 / 5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          dropdownColor: Colours.scaffold_white,
                                          value: dropdownValue,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.transparent,
                                          ),
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              dropdownValue = value!;
                                              if (dropdownValue ==
                                                  "Enter manually") {
                                                tfVisi = true;
                                              } else {
                                                tfVisi = false;
                                              }
                                            });
                                          },
                                          items: list
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Visibility(
                                        visible: tfVisi,
                                        child: SizedBox(
                                          width: 150,
                                          child: TextField(
                                            controller: price_per_cont,
                                            decoration: InputDecoration(
                                              labelText: "per",
                                              hoverColor: Colours.HunyadiYellow,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Sizer.radius_10 / 5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Sizer.radius_10 / 5),
                                    )
                                    // border: Border.all()
                                    ),
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Txt(
                                      text: "Duration",
                                      fntWt: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: TextField(
                                        onChanged: (value) {
                                          if (int.parse(value) > 24) {
                                            mm_cont.text = "";
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: hh_cont,
                                        decoration: InputDecoration(
                                          labelText: "hh",
                                          hoverColor: Colours.HunyadiYellow,
                                          focusColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Sizer.radius_10 / 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Txt(text: ":"),
                                    SizedBox(
                                      width: 60,
                                      child: TextField(
                                        onChanged: (value) {
                                          if (int.parse(value) > 60) {
                                            mm_cont.text = "";
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: mm_cont,
                                        decoration: InputDecoration(
                                          labelText: "mm",
                                          hoverColor: Colours.HunyadiYellow,
                                          focusColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Sizer.radius_10 / 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                                // TextField(
                                //   // inputFormatters: [
                                //   //   FilteringTextInputFormatter.digitsOnly,
                                //   // ],
                                //   controller: duration_cont,
                                //   decoration: InputDecoration(
                                //     labelText: "Duration",
                                //     // prefixText: "please mention ",
                                //     hoverColor: Colours.HunyadiYellow,
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(
                                //           Sizer.radius_10 / 5),
                                //     ),
                                //   ),
                                // ),

                                ),
                          ],
                        ),
                        SizedBox(
                          height: Sizer.h_50,
                        ),
                        Wrap(
                          spacing: Sizer.w_20,
                          runSpacing: Sizer.h_10,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(100, 50),
                              ),
                              onPressed: () {
                                if (price_cont.text.isEmpty ||
                                    trtmnt_cont.text.isEmpty) {
                                  glb.errorToast(
                                      context, "Enter all the details.");
                                } else {
                                  String a = trtmnt_cont.text.trim();
                                  String b = "";
                                  if (tfVisi == true) {
                                    b = price_cont.text.trim() +
                                        " /" +
                                        price_per_cont.text.trim();
                                  } else {
                                    b = price_cont.text.trim() +
                                        " /" +
                                        dropdownValue;
                                  }

                                  String c = "";
                                  if (int.parse(mm_cont.text) <= 0) {
                                    c = hh_cont.text.trim() + "hour";
                                  } else {
                                    c = hh_cont.text.trim() +
                                        " hour" +
                                        ":" +
                                        mm_cont.text.trim() +
                                        " minutes";
                                  }
                                  String d = desc_cont.text.trim();
                                  glb.loading(context);
                                  AddTreatments_async(
                                    a,
                                    b,
                                    c,
                                    d,
                                  );
                                }
                              },
                              child: Txt(text: "Add"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Txt(text: "My treatments"),
            Expanded(
                child: currentWidth > 600
                    ? GridView.builder(
                        itemCount: glb.Models.Treatments_lst.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 10, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Treatments_card(
                            tm: glb.Models.Treatments_lst[index],
                            update: getTreatments_async,
                          );
                        })
                    : ListView.builder(
                        itemCount: glb.Models.Treatments_lst.length,
                        itemBuilder: (context, index) {
                          return Treatments_card(
                            tm: glb.Models.Treatments_lst[index],
                            update: getTreatments_async,
                          );
                        }))
          ],
        ),
      ),
    );
  }

  List<Treatments_model> TM = [];
  getTreatments_async() async {
    TM = [];

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
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  AddTreatments_async(
      String trtmnt, String price, String duration, String desc) async {
    print("get treatments async ${glb.doctor.doc_id}");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.addDocTreatments);
    String BD = '';
    String docID = '';
    if (glb.usrTyp == '1') {
      BD = '0';
      docID = glb.doctor.doc_id;
    } else {
      BD = '1';
      docID = glb.clinicBranchDoc.doc_id;
    }
    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          'doc_id': '${docID}',
          // 'doc_id': '',
          "treatment": "$trtmnt",
          "price": "$price",
          'duration': '$duration',
          'desc': '$desc',
          'branch_doc': '$BD',
        },
      );
      print(res.statusCode);
      print(res.body);
      // var bdy = jsonDecode(res.body);
      // List b = jsonDecode(res.body);
      if (res.statusCode == 200) {
        getTreatments_async();
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);
        trtmnt_cont.clear();
        price_cont.clear();
        duration_cont.clear();
        desc_cont.clear();
      } else {
        Navigator.pop(context);
        glb.errorToast(context, "Something went wrong");
      }

      // print(bdy);
    } catch (e) {
      print("Exception => $e");
    }
  }
}
