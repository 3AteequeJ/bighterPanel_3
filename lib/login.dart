// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';

class Login_pg extends StatefulWidget {
  const Login_pg({super.key});

  @override
  State<Login_pg> createState() => _Login_pgState();
}

TextEditingController usrNM_cont = TextEditingController();
TextEditingController pswd_cont = TextEditingController();

class _Login_pgState extends State<Login_pg> {
  bool obscure = true, usr_typ = true; //1 doc,0 clinic
  Offset os = Offset(0, 0);
  @override
  void initState() {
    // TODO: implement initState
    usrNM_cont.text = pswd_cont.text = "";
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding:
          deviceWidth <= 600 ? EdgeInsets.all(Sizer.Pad) : EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(IconlyLight.logout))),
            SizedBox(
              height: deviceWidth <= 600 ? Sizer.h_10 * 2 : Sizer.h_50 * 3,
            ),
            // Txt(text: deviceWidth.toString()),
            Center(
              child: SizedBox(
                width: deviceWidth <= 600 ? Sizer.w_full : 3.255.w * 8,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MouseRegion(
                      onExit: (event) {
                        setState(() {
                          os = Offset(0, 0);
                        });
                      },
                      onHover: (event) {
                        // print(event);
                        setState(() {
                          os = Offset(5, 5);
                        });
                      },
                      child: Text(
                        "Bighter",
                        style: TextStyle(
                          fontSize: Sizer.h_50,
                          color: Colours.blue,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                blurRadius: 2,
                                offset: os,
                                color: Colours.orange),
                          ],
                        ),
                      ),
                    ),
                    // Txt(
                    //   text: "Bighter",
                    //   fntWt: FontWeight.bold,
                    //   fontColour: Colours.blue,
                    //   size: 20,
                    // ),
                    SizedBox(
                      height: deviceWidth <= 600 ? 0 : Sizer.h_10 * 2,
                    ),
                    Txt(
                      text: glb.usrTyp == '2'
                          ? "Clinic Login"
                          : glb.usrTyp == '1'
                              ? "Doctor Login"
                              : glb.usrTyp == '0'
                                  ? "Admin Login"
                                  : "",
                      size: 16,
                      fontColour: Colours.txt_black,
                    ),
                    SizedBox(
                      height: Sizer.h_10 * 2,
                    ),

                    // Row(
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           usr_typ = true;
                    //         });
                    //       },
                    //       child: Container(
                    //         width: Sizer.w_50 * 3,
                    //         child: Center(child: Txt(text: "Doctor")),
                    //         decoration: BoxDecoration(
                    //           border: Border(
                    //             bottom: BorderSide(
                    //               color: usr_typ
                    //                   ? Colours.RosePink
                    //                   : Colours.RussianViolet,
                    //               width: usr_typ ? 3 : 0,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           usr_typ = false;
                    //         });
                    //       },
                    //       child: Container(
                    //         width: Sizer.w_50 * 3,
                    //         child: Center(child: Txt(text: "Clinic")),
                    //         decoration: BoxDecoration(
                    //           border: Border(
                    //             bottom: BorderSide(
                    //               color: usr_typ == false
                    //                   ? Colours.orange
                    //                   : Colours.RussianViolet,
                    //               width: usr_typ == false ? 3 : 0,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Txt(
                    //   text: "Clinic login",
                    //   fntWt: FontWeight.bold,
                    // ),
                    SizedBox(
                      height: 1.37.h * 2,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: Sizer.Pad, right: Sizer.Pad),
                      child: Container(
                        width: deviceWidth <= 600 ? Sizer.w_full : 3.255.w * 6,
                        constraints: BoxConstraints(minWidth: 3.255.w * 4),
                        child: TextField(
                          controller: usrNM_cont,
                          decoration: InputDecoration(
                            labelText: "Email/Contact no",
                            hintText: "",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Sizer.h_10 * 3,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: Sizer.Pad, right: Sizer.Pad),
                      child: SizedBox(
                        width: deviceWidth <= 600 ? Sizer.w_full : 3.255.w * 6,
                        child: TextField(
                          controller: pswd_cont,
                          obscureText: obscure,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hoverColor: Colours.HunyadiYellow,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: Icon(
                                  obscure ? Icons.remove_red_eye : Icons.lock),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Sizer.h_10 * 2,
                    ),

                    Padding(
                      padding:
                          EdgeInsets.only(left: Sizer.Pad, right: Sizer.Pad),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colours.orange,
                          fixedSize: Size(
                              deviceWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                              Sizer.h_10),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Sizer.radius_10 / 5),
                          ),
                        ),
                        onPressed: () {
                          glb.loading(context);
                          String d = usrNM_cont.text.trim();
                          String p = pswd_cont.text.trim();
                          if (d.isEmpty || p.isEmpty) {
                            glb.errorToast(context, "Enter all the details");
                          } else {
                            if (glb.usrTyp == '2') {
                              // login_async(d, p);
                              print("here");
                              clinicLogin_async(d, p);
                            } else if (glb.usrTyp == '1') {
                              login_async(d, p);
                            } else if (glb.usrTyp == '0' &&
                                d == 'admin' &&
                                p == 'admin') {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => adminHome_pg()));
                            } else {
                              glb.errorToast(context, "Wrong details");
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Txt(text: "Login"),
                      ),
                    ),
                    SizedBox(
                      height: Sizer.h_10 * 2,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: Sizer.Pad, right: Sizer.Pad),
                      child: Visibility(
                        visible: glb.usrTyp == '1',
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colours.blue,
                              fixedSize: Size(
                                  deviceWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                                  Sizer.h_10),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizer.radius_10 / 5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, RG.register_rt);
                            },
                            child: Txt(
                              text: "Register",
                              fontColour: Colours.txt_white,
                            )),
                      ),
                    ),
                    // SizedBox(
                    //   height: Sizer.h_10 * 2,
                    // ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     fixedSize: Size(3.255.w * 6, 6.853.h),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(Sizer.radius_10 / 5),
                    //     ),
                    //   ),
                    //   onPressed: () {},
                    //   child: Txt(text: "Admin"),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  login_async(String data, String Password) async {
    print("Login async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.login);
    if (glb.usrTyp == '2') {
      url = Uri.parse(glb.API.baseURL + glb.API.Clogin);
    } else if (glb.usrTyp == '1') {
      url = Uri.parse(glb.API.baseURL + glb.API.Dlogin);
    }
    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          // 'data': '123456789',
          'data': '$data',
        },
      );
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      print(bdy);
      if (bdy.length == 0) {
        glb.errorToast(context, "Account not found\nRegister to get started");
        Navigator.pop(context);
      }
      if (glb.usrTyp == '2') {
        setState(() {
          glb.clinic.clinic_id = bdy[0]['ID'].toString();
          glb.clinic.clinic_name = bdy[0]['clinic_name'].toString();
          glb.clinic.contact_no = bdy[0]['mobile_no'].toString();
          glb.clinic.pswd = bdy[0]['pswd'].toString();
          glb.clinic.email_id = bdy[0]['email_id'].toString();
          glb.clinic.address = bdy[0]['address'].toString();
          glb.clinic.img1 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img1'].toString();
          glb.clinic.img2 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img2'].toString();
          glb.clinic.img3 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img3'].toString();
          glb.clinic.img4 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img4'].toString();
          glb.clinic.img5 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img5'].toString();
        });
        if (Password == glb.clinic.pswd) {
          Navigator.pushReplacementNamed(context, RG.Clinic_homePG_rt);
        } else {
          glb.errorToast(context, "Wrong password");
          Navigator.pop(context);
        }
      } else if (glb.usrTyp == '1') {
        print("Verified hai kya? ${bdy[0]['verified'].toString()}");
        if (bdy[0]['verified'].toString() == '0') {
          Navigator.pop(context);
          glb.ConfirmationBox(context, "You are not yet verified", () {
            Navigator.pop(context);
          });
        } else {
          setState(
            () {
              glb.doctor.doc_id = bdy[0]['ID'].toString();
              glb.doctor.name = bdy[0]['Name'].toString();
              glb.doctor.mobile_no = bdy[0]['mobile_no'].toString();
              glb.doctor.email = bdy[0]['email_id'].toString();
              glb.doctor.pswd = bdy[0]['pswd'].toString();
              glb.doctor.speciality = bdy[0]['Speciality'].toString();
              glb.doctor.Degree = bdy[0]['Degree'].toString();
              glb.doctor.clinic_id = bdy[0]['clinic_id'].toString();
              glb.doctor.available = bdy[0]['available'].toString();
              glb.doctor.rating = bdy[0]['Rating'].toString();
              glb.doctor.img = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['doctor_img'].toString();
              glb.doctor.img1 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img1'].toString();
              glb.doctor.img2 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img2'].toString();
              glb.doctor.img3 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img3'].toString();
              glb.doctor.img4 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img4'].toString();
              glb.doctor.IDProof = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['ID_proof'].toString();
              glb.doctor.degree_certificate =
                  "${glb.API.baseURL}images/doctor_images/" +
                      bdy[0]['degree_certificate'].toString();
              glb.doctor.medical_council_certificate =
                  "${glb.API.baseURL}images/doctor_images/" +
                      bdy[0]['medical_council_certificate'].toString();
              glb.doctor.available_from = bdy[0]['available_from'].toString();
              glb.doctor.available_to = bdy[0]['available_to'].toString();
              glb.doctor.address = bdy[0]['address'].toString();
              glb.doctor.city_id = bdy[0]['city_id'].toString();
              glb.doctor.pharmacy_user = bdy[0]['pharmacy_user'].toString();
              glb.doctor.experience = bdy[0]['experience'].toString();
              glb.doctor.LocationLnk = bdy[0]['location_lnk'].toString();
              glb.doctor.fees_clinic = bdy[0]['fees_clinic'].toString();
              glb.doctor.fees_online = bdy[0]['fees_online'].toString();
              glb.doctor.personal_stmt =
                  bdy[0]['personal_statement'].toString();
            },
          );
          if (Password == glb.doctor.pswd) {
            Navigator.pushReplacementNamed(context, RG.Doc_homePG_rt);
            if (bdy[0]['pharmacy_user'].toString() == '1') {
              setState(() {
                glb.pharmacy_user = true;
              });
            }
          } else {
            glb.errorToast(context, "Wrong password");
            Navigator.pop(context);
          }
        }
      }
    } catch (e) {
      print("Exception => $e");
    }
  }

  clinicLogin_async(String userNM, String paswd) async {
    print("clinic login async");
    Uri url = Uri.parse(glb.API.baseURL + "getCliniLogin");
    try {
      var res = await http.post(
        url,
        body: {
          'user_name': userNM,
        },
      );

      // print("stat = ${res.statusCode}");
      // print("body = ${res.body}");
      print("?? ${res.body}");
      if (res.body.isEmpty || res.body.toString() == "none") {
        Navigator.pop(context);
        glb.errorToast(context, "User not found");
      } else {
        var bdy = jsonDecode(res.body);
        var body = bdy[0];
        if (paswd == body['password'].toString()) {
          glb.clinicRole = bdy[0]['role'].toString();
          if (bdy[0]['role'].toString() == '0') {
            glb.clinic.clinic_id = body['ID'].toString();
            glb.clinic.usr_nm = body['user_name'].toString();
            glb.clinic.clinic_name = body['clinic_name'].toString();
            glb.clinic.contact_no = body['mobile_no'].toString();
            glb.clinic.pswd = body['password'].toString();
            glb.clinic.email_id = body['email_id'].toString();
            glb.clinic.address = body['address'].toString();
            glb.clinic.img1 = "${glb.API.baseURL}images/clinic_images/" +
                body['img1'].toString();
            glb.clinic.img2 = "${glb.API.baseURL}images/clinic_images/" +
                body['img2'].toString();
            glb.clinic.img3 = "${glb.API.baseURL}images/clinic_images/" +
                body['img3'].toString();
            glb.clinic.img4 = "${glb.API.baseURL}images/clinic_images/" +
                body['img4'].toString();
            glb.clinic.img5 = "${glb.API.baseURL}images/clinic_images/" +
                body['img5'].toString();

            Navigator.pushReplacementNamed(context, RG.Clinic_homePG_rt);
          } else if (bdy[0]['role'].toString() == '1') {
            glb.clinicBranch.branch_id = body['branch_id'].toString();
            glb.clinicBranch.usr_nm = body['user_name'].toString();
            glb.clinicBranch.pswd = body['password'].toString();
            glb.clinicBranch.credentials_id = body['credentials_id'].toString();
            glb.clinicBranch.clinic_name = body['name'].toString();
            glb.clinicBranch.contact_no = body['mob_no'].toString();
            glb.clinicBranch.email_id = body['email_id'].toString();
            glb.clinicBranch.clinicAddress = body['address'].toString();

            glb.clinicBranch.img1 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img1'].toString();
            glb.clinicBranch.img2 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img2'].toString();
            glb.clinicBranch.img3 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img3'].toString();
            glb.clinicBranch.img4 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img4'].toString();
            glb.clinicBranch.img5 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img5'].toString();

            print("Here");
            Navigator.pushReplacementNamed(context, RG.Clinic_homePG_rt);
          } else if (bdy[0]['role'].toString() == '2') {
            glb.clinicBranchDoc.doc_id = body['id'].toString();
            glb.clinicBranchDoc.usr_nm = body['user_name'].toString();
            glb.clinicBranchDoc.pswd = body['password'].toString();
            glb.clinicBranchDoc.credentials_id =
                body['credentials_id'].toString();
            glb.clinicBranchDoc.branch_id = body['branch_id'].toString();
            glb.clinicBranchDoc.name = body['name'].toString();
            glb.clinicBranchDoc.mobile_no = body['mob_no'].toString();
            glb.clinicBranchDoc.email = body['email'].toString();
            glb.clinicBranchDoc.Degree = body['degree'].toString();
            glb.clinicBranchDoc.speciality = body['speciality'].toString();
            glb.clinicBranchDoc.img1 =
                "${glb.API.baseURL}images/branchDoc_images/" +
                    bdy[0]['img1'].toString();
            glb.clinicBranchDoc.img2 =
                "${glb.API.baseURL}images/branchDoc_images/" +
                    bdy[0]['img2'].toString();
            glb.clinicBranchDoc.img3 =
                "${glb.API.baseURL}images/branchDoc_images/" +
                    bdy[0]['img3'].toString();
            glb.clinicBranchDoc.img4 =
                "${glb.API.baseURL}images/branchDoc_images/" +
                    bdy[0]['img4'].toString();
            glb.clinicBranchDoc.img5 =
                "${glb.API.baseURL}images/branchDoc_images/" +
                    bdy[0]['img5'].toString();
            glb.clinicBranchDoc.address = bdy[0]['branch_address'].toString();
            glb.clinicBranchDoc.available_from =
                bdy[0]['available_from'].toString();
            glb.clinicBranchDoc.available_to =
                bdy[0]['available_to'].toString();
            Navigator.pushReplacementNamed(context, RG.Clinic_homePG_rt);
            glb.clinicBranchDoc.city_id = bdy[0]['city_id'].toString();
            glb.clinicBranchDoc.fees_clinic = bdy[0]['fees_clinic'].toString();
            glb.clinicBranchDoc.fees_online = bdy[0]['fees_online'].toString();
            glb.clinicBranchDoc.LocationLnk = bdy[0]['location_lnk'].toString();
            glb.clinicBranchDoc.experience = bdy[0]['experience'].toString();
            glb.clinicBranchDoc.personal_stmt =
                bdy[0]['personal_statement'].toString();
          }
        } else {
          glb.errorToast(context, "Wrong password");
        }
      }
    } catch (e) {}
  }

  Doc_login_async(String data, String Password) async {
    print("getDoc Login async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.Dlogin);
    if (glb.usrTyp == '1') {
      url = Uri.parse(glb.API.baseURL + glb.API.Dlogin);
    }
    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          // 'data': '123456789',
          'data': '$data',
        },
      );
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      print(bdy);
      if (glb.usrTyp == '2') {
        Navigator.pushNamed(context, RG.Doc_homePG_rt);
      }
    } catch (e) {
      print("Exception => $e");
    }
  }
}
