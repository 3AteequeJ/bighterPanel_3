import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Utils/global.dart' as glb;

class Pricing_pg extends StatefulWidget {
  const Pricing_pg({super.key});

  @override
  State<Pricing_pg> createState() => _Pricing_pgState();
}

List<String> apply_lst = [
  'Both',
  'price only',
  'comission only',
];

String dropdown_value = apply_lst.first;

class _Pricing_pgState extends State<Pricing_pg> {
  TextEditingController price_cont = TextEditingController();
  TextEditingController comission_cont = TextEditingController();
  TextEditingController w_s1 = TextEditingController();
  TextEditingController w_s2 = TextEditingController();
  TextEditingController w_s3 = TextEditingController();
  TextEditingController m_s1 = TextEditingController();
  TextEditingController m_s2 = TextEditingController();
  TextEditingController m_s3 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      price_cont.text = glb.pharmacyPricing.price;
      comission_cont.text = glb.pharmacyPricing.comission;
      w_s1.text = glb.ProfilePrioritization_pricing.s1_w;
      w_s2.text = glb.ProfilePrioritization_pricing.s2_w;
      w_s3.text = glb.ProfilePrioritization_pricing.s3_w;
      m_s1.text = glb.ProfilePrioritization_pricing.s1_m;
      m_s2.text = glb.ProfilePrioritization_pricing.s2_m;
      m_s3.text = glb.ProfilePrioritization_pricing.s3_m;
      if (glb.pharmacyPricing.applicable == '0') {
        dropdown_value = apply_lst.first;
      } else if (glb.pharmacyPricing.applicable == '1') {
        dropdown_value = apply_lst[1];
      } else {
        dropdown_value = apply_lst[2];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 5,
          color: Colors.transparent,
          child: Container(
            // height: Sizer.h_50 * 4,
            width: 70.w,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(Sizer.Pad),
              child: Column(
                children: [
                  Txt(
                    text: "Pharmacy pricing",
                    fntWt: FontWeight.bold,
                  ),
                  Divider(
                    color: Colours.divider_grey,
                  ),
                  Wrap(
                    spacing: Sizer.w_20,
                    children: [
                      Container(
                        height: Sizer.h_50,
                        width: Sizer.w_50 * 6,
                        child: Row(
                          children: [
                            Txt(text: "Price/month "),
                            Expanded(
                              child: TextField(
                                controller: price_cont,
                                decoration: InputDecoration(
                                  prefixText: "₹",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: Sizer.h_50,
                        width: Sizer.w_50 * 6,
                        child: Row(
                          children: [
                            Txt(text: "Comission "),
                            Expanded(
                              child: TextField(
                                controller: comission_cont,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  prefixText: "%",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: Sizer.h_50,
                        width: Sizer.w_50 * 6,
                        child: Row(
                          children: [
                            Txt(text: "Apply "),
                            DropdownButton(
                                value: dropdown_value,
                                items: apply_lst.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Txt(
                                      text: value,
                                      fontColour: Colours.txt_black,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdown_value = value!;
                                  });
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        String a = '';
                        //                     'Both',
                        // 'price only',
                        // 'comission only',
                        if (dropdown_value == 'Both') {
                          a = '0';
                        } else if (dropdown_value == 'price only') {
                          a = '1';
                        } else {
                          a = '2';
                        }
                        updatePharmPrice_async(
                            price_cont.text, comission_cont.text, a);
                      },
                      child: Txt(text: "Update"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Sizer.h_50,
        ),
        Material(
          elevation: 5,
          color: Colors.transparent,
          child: Container(
            // height: Sizer.h_50 * 4,
            width: 70.w,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(Sizer.Pad),
              child: Column(
                children: [
                  Txt(
                    text: "Profile prioritization pricing",
                    fntWt: FontWeight.bold,
                  ),
                  Divider(
                    color: Colours.divider_grey,
                  ),
                  Row(
                    // spacing: Sizer.w_20,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Txt(
                            text: "Week",
                            fntWt: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              Txt(text: "Slot 1"),
                              SizedBox(
                                width: Sizer.w_20,
                              ),
                              SizedBox(
                                width: Sizer.w_50 * 2,
                                child: TextField(
                                  controller: w_s1,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixText: "₹"),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Txt(text: "Slot 2"),
                              SizedBox(
                                width: Sizer.w_20,
                              ),
                              SizedBox(
                                width: Sizer.w_50 * 2,
                                child: TextField(
                                  controller: w_s2,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixText: "₹"),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Txt(text: "Slot 3"),
                              SizedBox(
                                width: Sizer.w_20,
                              ),
                              SizedBox(
                                width: Sizer.w_50 * 2,
                                child: TextField(
                                  controller: w_s3,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixText: "₹"),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Txt(
                            text: "Month",
                            fntWt: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              Txt(text: "Slot 1"),
                              SizedBox(
                                width: Sizer.w_20,
                              ),
                              SizedBox(
                                width: Sizer.w_50 * 2,
                                child: TextField(
                                  controller: m_s1,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixText: "₹"),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Txt(text: "Slot 2"),
                              SizedBox(
                                width: Sizer.w_20,
                              ),
                              SizedBox(
                                width: Sizer.w_50 * 2,
                                child: TextField(
                                  controller: m_s2,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixText: "₹"),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Txt(text: "Slot 3"),
                              SizedBox(
                                width: Sizer.w_20,
                              ),
                              SizedBox(
                                width: Sizer.w_50 * 2,
                                child: TextField(
                                  controller: m_s3,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixText: "₹"),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var p1 = w_s1.text.trim();
                        var p2 = w_s2.text.trim();
                        var p3 = w_s3.text.trim();
                        var p4 = m_s1.text.trim();
                        var p5 = m_s2.text.trim();
                        var p6 = m_s3.text.trim();

                        updateProfilePrioritizationPrice_async(
                            p1, p2, p3, p4, p5, p6);
                      },
                      child: Txt(text: "Update"))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  updatePharmPrice_async(
      String price, String Commission, String applicable) async {
    print("updating pharm price");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.updatePharmPrice);

    try {
      var res = await http.post(url, body: {
        'price': price,
        'commission': Commission,
        'applicable': applicable,
      });

      print(res.body);
      var bdy = jsonDecode(res.body);

      print("bdy = $bdy");
      if (bdy.toString() == '1') {
        print("here");
        glb.SuccessToast(context, "Pharmacy price updated");
        setState(() {
          glb.pharmacyPricing.price = price;
          glb.pharmacyPricing.comission = Commission;
          glb.pharmacyPricing.applicable = applicable;
        });
      }
    } catch (e) {}
  }

  updateProfilePrioritizationPrice_async(
      String p1, String p2, String p3, String p4, String p5, String p6) async {
    print("updating prioritization price");
    Uri url =
        Uri.parse(glb.API.baseURL + glb.API.updateProfileProritizationPrice);

    try {
      var res = await http.post(url, body: {
        '1s_w': p1,
        '2s_w': p2,
        '3s_w': p3,
        '1s_m': p4,
        '2s_m': p5,
        '3s_m': p6,
      });

      print(res.body);
      var bdy = jsonDecode(res.body);

      print("bdy = $bdy");
      if (bdy.toString() == '1') {
        print("here");
        glb.SuccessToast(context, "Profile prioritization price updated");
        setState(() {
          glb.ProfilePrioritization_pricing.s1_w = p1;
          glb.ProfilePrioritization_pricing.s2_w = p2;
          glb.ProfilePrioritization_pricing.s3_w = p3;
          glb.ProfilePrioritization_pricing.s1_m = p4;
          glb.ProfilePrioritization_pricing.s2_m = p5;
          glb.ProfilePrioritization_pricing.s3_m = p6;
        });
      }
    } catch (e) {}
  }
}
