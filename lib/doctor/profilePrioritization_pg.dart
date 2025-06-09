import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Utils/global.dart' as glb;

class ProfilePrioritization extends StatefulWidget {
  const ProfilePrioritization({super.key});

  @override
  State<ProfilePrioritization> createState() => _ProfilePrioritizationState();
}

class _ProfilePrioritizationState extends State<ProfilePrioritization> {
  String slot = '0';
  @override
  void initState() {
    // TODO: implement initState
    get_featuredDocpricing_async();
    Check_featSlotAvailability_async();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Txt(text: "Profile Prioritization"),
      ),
      body: Column(
        children: [
          Row(),
          Material(
            elevation: 5,
            color: Colors.transparent,
            child: Container(
              width: 70.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Sizer.radius_10 / 5)),
              child: Padding(
                padding: EdgeInsets.all(Sizer.w_50),
                child: Txt(
                    maxLn: 50,
                    text:
                        "Submit your profile for admin approval to gain top placement in our listings. Once approved, your profile will be highlighted, increasing your visibility and making it easier for patients to find and book appointments with you. This feature ensures that only verified and trusted doctors are prominently displayed, enhancing the quality of care provided to our patients"),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: Sizer.Pad, right: Sizer.Pad),
            child: Wrap(
              spacing: Sizer.w_10,

              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ? First slot
                Material(
                  elevation: 5,
                  color: Colors.transparent,
                  child: Container(
                    width: 20.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Sizer.radius_10 / 5)),
                    child: Column(
                      children: [
                        Container(
                          height: Sizer.h_50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colours.gold.withOpacity(.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizer.radius_10 / 5),
                              topRight: Radius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                          child: Txt(
                            text: "First slot",
                            size: 24,
                            fntWt: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ? 1st slot week
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Txt(
                                    text:
                                        "₹ ${glb.ProfilePrioritization_pricing.s1_w}",
                                    size: 24,
                                    fntWt: FontWeight.bold,
                                  ),
                                  Txt(text: "/week")
                                ],
                              ),

                              Visibility(
                                visible:
                                    glb.ProfilePrioritization_pricing.s1_w_ava,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        slot = '4';
                                      });
                                      razor_pay(glb
                                          .ProfilePrioritization_pricing.s1_w);
                                    },
                                    child: Txt(text: "Select"),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colours.divider_grey,
                              ),
                              // ?1st slot month
                              Row(
                                children: [
                                  Txt(
                                    text:
                                        "₹ ${glb.ProfilePrioritization_pricing.s1_m}",
                                    size: 24,
                                    fntWt: FontWeight.bold,
                                  ),
                                  Txt(text: "/month")
                                ],
                              ),

                              Visibility(
                                visible:
                                    glb.ProfilePrioritization_pricing.s1_m_ava,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        slot = '1';
                                      });
                                      razor_pay(glb
                                          .ProfilePrioritization_pricing.s1_m);
                                    },
                                    child: Txt(text: "Select"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ? Second slot
                Material(
                  elevation: 5,
                  color: Colors.transparent,
                  child: Container(
                    width: 20.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Sizer.radius_10 / 5)),
                    child: Column(
                      children: [
                        Container(
                          height: Sizer.h_50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colours.silver.withOpacity(.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizer.radius_10 / 5),
                              topRight: Radius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                          child: Txt(
                            text: "Second slot",
                            size: 24,
                            fntWt: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Txt(
                                    text:
                                        "₹ ${glb.ProfilePrioritization_pricing.s2_w}",
                                    size: 24,
                                    fntWt: FontWeight.bold,
                                  ),
                                  Txt(text: "/week")
                                ],
                              ),

                              Visibility(
                                visible:
                                    glb.ProfilePrioritization_pricing.s2_w_ava,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        slot = '5';
                                      });
                                      razor_pay(glb
                                          .ProfilePrioritization_pricing.s2_w);
                                    },
                                    child: Txt(text: "Select"),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colours.divider_grey,
                              ),
                              // ? 2nd slot month
                              Row(
                                children: [
                                  Txt(
                                    text:
                                        "₹ ${glb.ProfilePrioritization_pricing.s2_m}",
                                    size: 24,
                                    fntWt: FontWeight.bold,
                                  ),
                                  Txt(text: "/month")
                                ],
                              ),

                              Visibility(
                                visible:
                                    glb.ProfilePrioritization_pricing.s2_m_ava,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        slot = '2';
                                      });
                                      razor_pay(glb
                                          .ProfilePrioritization_pricing.s2_m);
                                    },
                                    child: Txt(text: "Select"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ? Third slot
                Material(
                  elevation: 5,
                  color: Colors.transparent,
                  child: Container(
                    width: 20.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Sizer.radius_10 / 5)),
                    child: Column(
                      children: [
                        Container(
                          height: Sizer.h_50,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colours.bronze.withOpacity(.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizer.radius_10 / 5),
                              topRight: Radius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                          child: Txt(
                            text: "Third slot",
                            size: 24,
                            fntWt: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ? 3rd slot week
                              Row(
                                children: [
                                  Txt(
                                    text:
                                        "₹ ${glb.ProfilePrioritization_pricing.s3_w}",
                                    size: 24,
                                    fntWt: FontWeight.bold,
                                  ),
                                  Txt(text: "/week")
                                ],
                              ),

                              Visibility(
                                visible:
                                    glb.ProfilePrioritization_pricing.s3_w_ava,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        slot = '6';
                                      });
                                      razor_pay(glb
                                          .ProfilePrioritization_pricing.s3_w);
                                    },
                                    child: Txt(text: "Select"),
                                  ),
                                ),
                              ),

                              Divider(
                                color: Colours.divider_grey,
                              ),
                              // ? 3rd slot month
                              Row(
                                children: [
                                  Txt(
                                    text:
                                        "₹ ${glb.ProfilePrioritization_pricing.s3_m}",
                                    size: 24,
                                    fntWt: FontWeight.bold,
                                  ),
                                  Txt(text: "/month")
                                ],
                              ),

                              Visibility(
                                visible:
                                    glb.ProfilePrioritization_pricing.s3_m_ava,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        slot = '3';
                                      });
                                      razor_pay(glb
                                          .ProfilePrioritization_pricing.s3_m);
                                    },
                                    child: Txt(text: "Select"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  addFeaturedDoc_async() async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.addFeaturedDoc);

    print(
      glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
    );
    print(
      glb.usrTyp == '1'
          ? glb.doctor.speciality
          : glb.clinicBranchDoc.speciality,
    );
    print(
      glb.usrTyp == '1' ? glb.doctor.city_id : glb.clinicBranchDoc.branch_id,
    );
    print("payment id = $Payment_ID");
    try {
      var res = await http.post(url, body: {
        'doc_id':
            glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
        'branch_doc': glb.usrTyp == '1' ? "0" : "1",
        'speciality': glb.usrTyp == '1'
            ? glb.doctor.speciality
            : glb.clinicBranchDoc.speciality,
        'city_id': glb.usrTyp == '1'
            ? glb.doctor.city_id
            : glb.clinicBranchDoc.city_id,
        'slot': slot,
        'payment_id': Payment_ID,
      });
      print("add fd stat code: ${res.statusCode}");
      print(res.body);

      if (res.body == "User already present") {
        glb.errorToast(context, "Something went wrong");
      } else {
        if (res.statusCode == 200) {
          glb.SuccessToast(context, "Successful");
          setState(() {
            glb.featuredDoc = true;
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocHome_pg(
                          pgNO: 0,
                        )));
          });
        }
      }
    } catch (e) {}
  }

  Check_featSlotAvailability_async() async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.featDocSlotAvailability);

    print(
      glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
    );
    print(
      glb.usrTyp == '1'
          ? glb.doctor.speciality
          : glb.clinicBranchDoc.speciality,
    );
    print(
      glb.usrTyp == '1' ? glb.doctor.city_id : glb.clinicBranchDoc.branch_id,
    );

    try {
      var res = await http.post(url, body: {
        'speciality': glb.usrTyp == '1'
            ? glb.doctor.speciality
            : glb.clinicBranchDoc.speciality,
        'city_id': glb.usrTyp == '1'
            ? glb.doctor.city_id
            : glb.clinicBranchDoc.city_id,
      });
      print("add fd stat code: ${res.statusCode}");
      print(res.body);

      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);

      for (int i = 0; i < b.length; i++) {
        setState(() {
          if (bdy[i]['slot'].toString() == '1') {
            glb.ProfilePrioritization_pricing.s1_m_ava = false;
          } else if (bdy[i]['slot'].toString() == '2') {
            glb.ProfilePrioritization_pricing.s2_m_ava = false;
          } else if (bdy[i]['slot'].toString() == '3') {
            glb.ProfilePrioritization_pricing.s3_m_ava = false;
          } else if (bdy[i]['slot'].toString() == '4') {
            glb.ProfilePrioritization_pricing.s1_w_ava = false;
          } else if (bdy[i]['slot'].toString() == '5') {
            glb.ProfilePrioritization_pricing.s2_w_ava = false;
          } else if (bdy[i]['slot'].toString() == '6') {
            glb.ProfilePrioritization_pricing.s3_w_ava = false;
          }
        });
      }
    } catch (e) {}
  }

  String Payment_ID = "";

  razor_pay(String amt) {
    Razorpay razorpay = Razorpay();

    var options = {
      // rzp_live_BbZVdPkRGox44t
      'key': 'rzp_test_JUWKRLHkq2fyIe',
      'amount': amt + "00",
      'name': 'Bighter',
      'description': 'Medicine',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,

      'prefill': {'contact': '7618735999', 'email': 'ateeque.mj@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.code.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.paymentId.toString());
    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
    setState(() {
      Payment_ID = response.paymentId.toString();
    });
    List<Map<String, String>> invoice = [];

    addFeaturedDoc_async();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  get_featuredDocpricing_async() async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getFeaturedDocPricing);

    try {
      var res = await http.get(url);

      print(res.statusCode);
      print(res.body);

      var bdy = jsonDecode(res.body);

      setState(() {
        glb.ProfilePrioritization_pricing.s1_w = bdy[0]['1s_w'].toString();
        glb.ProfilePrioritization_pricing.s2_w = bdy[0]['2s_w'].toString();
        glb.ProfilePrioritization_pricing.s3_w = bdy[0]['3s_w'].toString();

        glb.ProfilePrioritization_pricing.s1_m = bdy[0]['1s_m'].toString();
        glb.ProfilePrioritization_pricing.s2_m = bdy[0]['2s_m'].toString();
        glb.ProfilePrioritization_pricing.s3_m = bdy[0]['3s_m'].toString();
      });
    } catch (e) {}
  }


}
