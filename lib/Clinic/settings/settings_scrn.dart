// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Utils/global.dart' as glb;

class Settings_scrn extends StatefulWidget {
  const Settings_scrn({super.key});

  @override
  State<Settings_scrn> createState() => _Settings_scrnState();
}

class _Settings_scrnState extends State<Settings_scrn> {
  TextEditingController nm_cont = TextEditingController();
  TextEditingController adrs_cont = TextEditingController();
  TextEditingController mobno_cont = TextEditingController();
  TextEditingController email_cont = TextEditingController();
  TextEditingController speciality_cont = TextEditingController();
  TextEditingController deg_cont = TextEditingController();

  // TextEditingController Docnm_cont = TextEditingController();

  String state_dropdownValue = "Select state";
  String city_dropdownValue = "Select city";
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      if (glb.clinicRole == '0') {
        nm_cont.text = glb.clinic.clinic_name;
        adrs_cont.text = glb.clinic.address;
      } else if (glb.clinicRole == '1') {
        nm_cont.text = glb.clinicBranch.clinic_name;
        adrs_cont.text = glb.clinicBranch.clinicAddress;
      } else if (glb.clinicRole == '2') {
        nm_cont.text = glb.clinicBranchDoc.name;
        adrs_cont.text = glb.clinicBranchDoc.address;
        mobno_cont.text = glb.clinicBranchDoc.mobile_no;
        email_cont.text = glb.clinicBranchDoc.email;
        speciality_cont.text = glb.clinicBranchDoc.speciality;
        deg_cont.text = glb.clinicBranchDoc.Degree;
      }

      // city_dropdownValue = ""
    });
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: currentWidth <= 600
            ? Column(
                children: [
                  Container(
                    height: Sizer.h_50 * 2,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: Sizer.radius_10 * 5,
                          backgroundColor: Colours.HunyadiYellow,
                          child: Image.network(
                            glb.clinicRole == '0'
                                ? "${glb.clinic.img1}?cache_bust=${Random().nextInt(10000)}"
                                : glb.clinicRole == '1'
                                    ? "${glb.clinicBranch.img1}?cache_bust=${Random().nextInt(10000)}"
                                    : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Iconsax.image5);
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (glb.clinicRole == '0') {
                              _pickImage("1", glb.clinic.clinic_id);
                            } else if (glb.clinicRole == '1') {
                              _pickImage("1", glb.clinicBranch.branch_id);
                            } else if (glb.clinicRole == '2') {
                              _pickImage("1", glb.clinicBranchDoc.doc_id);
                            }
                          },
                          child: CircleAvatar(
                            // radius: 0.55.w,
                            backgroundColor: Colors.grey[300],
                            child: Icon(Iconsax.camera),
                          ),
                        )
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: Sizer.w_10,
                    runSpacing: Sizer.h_10,
                    children: [
                      w200SizedBox(
                        wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                        child: TextField(
                          controller: nm_cont,
                          decoration: InputDecoration(
                            labelText: "Clinic name",
                            hoverColor: Colours.HunyadiYellow,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: glb.clinicRole == '2',
                        child: w200SizedBox(
                          wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                          child: TextField(
                            controller: mobno_cont,
                            decoration: InputDecoration(
                              labelText: "Mobile number",
                              hoverColor: Colours.HunyadiYellow,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizer.radius_10 / 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: glb.clinicRole == '2',
                        child: w200SizedBox(
                          wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                          child: TextField(
                            controller: email_cont,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hoverColor: Colours.HunyadiYellow,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizer.radius_10 / 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: glb.clinicRole == '2',
                        child: w200SizedBox(
                          wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                          child: TextField(
                            enabled: false,
                            controller: deg_cont,
                            decoration: InputDecoration(
                              labelText: "Degree",
                              hoverColor: Colours.HunyadiYellow,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizer.radius_10 / 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: glb.clinicRole == '2',
                        child: w200SizedBox(
                          wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                          child: TextField(
                            enabled: false,
                            controller: speciality_cont,
                            decoration: InputDecoration(
                              labelText: "Speciality",
                              hoverColor: Colours.HunyadiYellow,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizer.radius_10 / 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // w200SizedBox(
                      //   wd: (3.255 * 8).w,
                      //   child: TextField(
                      //     controller: adrs_cont,
                      //     decoration: InputDecoration(
                      //       labelText: "Address",
                      //       hoverColor: Colours.HunyadiYellow,
                      //       border: OutlineInputBorder(
                      //         borderRadius:
                      //             BorderRadius.circular(Sizer.radius_10 / 5),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Visibility(
                        visible: glb.clinicRole != '2',
                        child: SizedBox(
                          width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                          child: TextFormField(
                            controller: adrs_cont,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Address",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      //       SizedBox(
                      //   height: 100,
                      //   width: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                      //   child: DropdownSearch<String>(
                      //     popupProps: PopupProps.menu(
                      //       showSelectedItems: true,
                      //       showSearchBox: true,
                      //       searchFieldProps: TextFieldProps(),
                      //     ),
                      //     items: cm.map((city) => city.nm).toList(),
                      //     dropdownDecoratorProps: DropDownDecoratorProps(
                      //         dropdownSearchDecoration: InputDecoration(
                      //       labelText: "Select a city",
                      //       hintText: "Search for a city",
                      //     )),
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         city_dropdownValue = newValue!;
                      //         print(state_dropdownValue);
                      //         var selectedCity =
                      //             cm.firstWhere((city) => city.nm == newValue);
                      //         print('Selected city ID: ${selectedCity!.id}');
                      //       });
                      //     },
                      //     selectedItem: city_dropdownValue,
                      //   ),
                      // ),

                      ElevatedButton(
                        onPressed: () {
                          if (nm_cont.text.trim() == glb.clinic.clinic_name &&
                              adrs_cont.text.trim() == glb.clinic.address) {
                          } else {
                            glb.loading(context);
                            Update_clinic_dets_async(
                              nm_cont.text.trim(),
                              adrs_cont.text.trim(),
                              mobno_cont.text.trim(),
                              email_cont.text.trim(),
                            );
                          }
                        },
                        child: Txt(
                          text: 'Update',
                          fntWt: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Sizer.h_50,
                  ),
                  Txt(
                    text: "Clinic images",
                    size: 14,
                    fontColour: Colours.txt_grey,
                  ),
                  Wrap(
                    spacing: Sizer.w_10,
                    runSpacing: Sizer.h_10,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colours.HunyadiYellow.withOpacity(0.3),
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  glb.clinicRole == '0'
                                      ? "${glb.clinic.img2}?cache_bust=${Random().nextInt(10000)}"
                                      : glb.clinicRole == '1'
                                          ? "${glb.clinicBranch.img2}?cache_bust=${Random().nextInt(10000)}"
                                          : "${glb.clinicBranchDoc.img2}?cache_bust=${Random().nextInt(10000)}",
                                  // "https://bighterapp.bighter.com/images/clinic_images/4_Cimg_1.jpg",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Iconsax.image);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (glb.clinicRole == '0') {
                                  _pickImage("2", glb.clinic.clinic_id);
                                } else if (glb.clinicRole == '1') {
                                  _pickImage("2", glb.clinicBranch.branch_id);
                                } else if (glb.clinicRole == '2') {
                                  _pickImage("2", glb.clinicBranchDoc.doc_id);
                                }
                              },
                              child: Container(
                                color: Colours.HunyadiYellow.withOpacity(0.6),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Txt(text: "upload"),
                                    Icon(Iconsax.document_upload),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colours.HunyadiYellow.withOpacity(0.3),
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  glb.clinicRole == '0'
                                      ? "${glb.clinic.img3}?cache_bust=${Random().nextInt(10000)}"
                                      : glb.clinicRole == '1'
                                          ? "${glb.clinicBranch.img3}?cache_bust=${Random().nextInt(10000)}"
                                          : "${glb.clinicBranchDoc.img3}?cache_bust=${Random().nextInt(10000)}",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Iconsax.image);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (glb.clinicRole == '0') {
                                  _pickImage("3", glb.clinic.clinic_id);
                                } else if (glb.clinicRole == '1') {
                                  _pickImage("3", glb.clinicBranch.branch_id);
                                } else if (glb.clinicRole == '2') {
                                  _pickImage("3", glb.clinicBranchDoc.doc_id);
                                }
                              },
                              child: Container(
                                color: Colours.HunyadiYellow.withOpacity(0.6),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Txt(text: "upload"),
                                    Icon(Iconsax.document_upload),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colours.HunyadiYellow.withOpacity(0.3),
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  glb.clinicRole == '0'
                                      ? "${glb.clinic.img4}?cache_bust=${Random().nextInt(10000)}"
                                      : glb.clinicRole == '1'
                                          ? "${glb.clinicBranch.img4}?cache_bust=${Random().nextInt(10000)}"
                                          : "${glb.clinicBranchDoc.img4}?cache_bust=${Random().nextInt(10000)}",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Iconsax.image);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (glb.clinicRole == '0') {
                                  _pickImage("4", glb.clinic.clinic_id);
                                } else if (glb.clinicRole == '1') {
                                  _pickImage("4", glb.clinicBranch.branch_id);
                                } else if (glb.clinicRole == '2') {
                                  _pickImage("4", glb.clinicBranchDoc.doc_id);
                                }
                              },
                              child: Container(
                                color: Colours.HunyadiYellow.withOpacity(0.6),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Txt(text: "upload"),
                                    Icon(Iconsax.document_upload),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colours.HunyadiYellow.withOpacity(0.3),
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  glb.clinicRole == '0'
                                      ? "${glb.clinic.img5}?cache_bust=${Random().nextInt(10000)}"
                                      : glb.clinicRole == '1'
                                          ? "${glb.clinicBranch.img5}?cache_bust=${Random().nextInt(10000)}"
                                          : "${glb.clinicBranchDoc.img5}?cache_bust=${Random().nextInt(10000)}",
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Iconsax.image);
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (glb.clinicRole == '0') {
                                  _pickImage("5", glb.clinic.clinic_id);
                                } else if (glb.clinicRole == '1') {
                                  _pickImage("5", glb.clinicBranch.branch_id);
                                } else if (glb.clinicRole == '2') {
                                  _pickImage("5", glb.clinicBranchDoc.doc_id);
                                }
                              },
                              child: Container(
                                color: Colours.HunyadiYellow.withOpacity(0.6),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Txt(text: "upload"),
                                    Icon(Iconsax.document_upload),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Txt(
                      text: "Clinic profile settings",
                      fntWt: FontWeight.bold,
                      size: 14,
                      fontColour: Colours.RussianViolet,
                    ),
                  ),
                  SizedBox(
                    height: Sizer.h_50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: Sizer.w_10,
                          runSpacing: Sizer.h_10,
                          children: [
                            Container(
                              height: (6.853 * 3).h,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: (2.77 * 2).w,
                                    backgroundColor: Colours.HunyadiYellow,
                                    backgroundImage: NetworkImage(
                                      glb.clinicRole == '0'
                                          ? "${glb.clinic.img1}?cache_bust=${Random().nextInt(10000)}"
                                          : glb.clinicRole == '1'
                                              ? "${glb.clinicBranch.img1}?cache_bust=${Random().nextInt(10000)}"
                                              : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                                      // errorBuilder:
                                      //     (context, error, stackTrace) {
                                      //   return Icon(Iconsax.image5);
                                      // },
                                    ),
                                    // child: Image.network(
                                    //   glb.clinicRole == '0'
                                    //       ? "${glb.clinic.img1}?cache_bust=${Random().nextInt(10000)}"
                                    //       : glb.clinicRole == '1'
                                    //           ? "${glb.clinicBranch.img1}?cache_bust=${Random().nextInt(10000)}"
                                    //           : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                                    //   errorBuilder:
                                    //       (context, error, stackTrace) {
                                    //     return Icon(Iconsax.image5);
                                    //   },
                                    // ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (glb.clinicRole == '0') {
                                        _pickImage("1", glb.clinic.clinic_id);
                                      } else if (glb.clinicRole == '1') {
                                        _pickImage(
                                            "1", glb.clinicBranch.branch_id);
                                      } else if (glb.clinicRole == '2') {
                                        _pickImage(
                                            "1", glb.clinicBranchDoc.doc_id);
                                      }
                                    },
                                    child: CircleAvatar(
                                      // radius: 0.55.w,
                                      backgroundColor: Colors.grey[300],
                                      child: Icon(Iconsax.camera),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            w200SizedBox(
                              wd: (3.255 * 6).w,
                              child: TextField(
                                controller: nm_cont,
                                decoration: InputDecoration(
                                  labelText: "Clinic name",
                                  hoverColor: Colours.HunyadiYellow,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: glb.clinicRole == '2',
                              child: w200SizedBox(
                                wd: (3.255 * 6).w,
                                child: TextField(
                                  controller: mobno_cont,
                                  decoration: InputDecoration(
                                    labelText: "Mobile number",
                                    hoverColor: Colours.HunyadiYellow,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: glb.clinicRole == '2',
                              child: w200SizedBox(
                                wd: (3.255 * 6).w,
                                child: TextField(
                                  controller: email_cont,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hoverColor: Colours.HunyadiYellow,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: glb.clinicRole == '2',
                              child: w200SizedBox(
                                wd: (3.255 * 6).w,
                                child: TextField(
                                  enabled: false,
                                  controller: deg_cont,
                                  decoration: InputDecoration(
                                    labelText: "Degree",
                                    hoverColor: Colours.HunyadiYellow,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: glb.clinicRole == '2',
                              child: w200SizedBox(
                                wd: (3.255 * 6).w,
                                child: TextField(
                                  enabled: false,
                                  controller: speciality_cont,
                                  decoration: InputDecoration(
                                    labelText: "Speciality",
                                    hoverColor: Colours.HunyadiYellow,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // w200SizedBox(
                            //   wd: (3.255 * 8).w,
                            //   child: TextField(
                            //     controller: adrs_cont,
                            //     decoration: InputDecoration(
                            //       labelText: "Address",
                            //       hoverColor: Colours.HunyadiYellow,
                            //       border: OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.circular(Sizer.radius_10 / 5),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Visibility(
                              visible: glb.clinicRole != '2',
                              child: SizedBox(
                                width: Sizer.w_50 * 6,
                                child: TextFormField(
                                  controller: adrs_cont,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            //       SizedBox(
                            //   height: 100,
                            //   width: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                            //   child: DropdownSearch<String>(
                            //     popupProps: PopupProps.menu(
                            //       showSelectedItems: true,
                            //       showSearchBox: true,
                            //       searchFieldProps: TextFieldProps(),
                            //     ),
                            //     items: cm.map((city) => city.nm).toList(),
                            //     dropdownDecoratorProps: DropDownDecoratorProps(
                            //         dropdownSearchDecoration: InputDecoration(
                            //       labelText: "Select a city",
                            //       hintText: "Search for a city",
                            //     )),
                            //     onChanged: (String? newValue) {
                            //       setState(() {
                            //         city_dropdownValue = newValue!;
                            //         print(state_dropdownValue);
                            //         var selectedCity =
                            //             cm.firstWhere((city) => city.nm == newValue);
                            //         print('Selected city ID: ${selectedCity!.id}');
                            //       });
                            //     },
                            //     selectedItem: city_dropdownValue,
                            //   ),
                            // ),

                            ElevatedButton(
                              onPressed: () {
                                if (nm_cont.text.trim() ==
                                        glb.clinic.clinic_name &&
                                    adrs_cont.text.trim() ==
                                        glb.clinic.address) {
                                } else {
                                  glb.loading(context);
                                  Update_clinic_dets_async(
                                    nm_cont.text.trim(),
                                    adrs_cont.text.trim(),
                                    mobno_cont.text.trim(),
                                    email_cont.text.trim(),
                                  );
                                }
                              },
                              child: Txt(
                                text: 'Update',
                                fntWt: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Sizer.h_50,
                        ),
                        Txt(
                          text: "Clinic images",
                          size: 14,
                          fontColour: Colours.txt_grey,
                        ),
                        // Txt(
                        //   text: glb.clinicBranchDoc.img1,
                        //   fontColour: Colours.txt_grey,
                        // ),
                        // Txt(
                        //   text: glb.clinicBranchDoc.img2,
                        //   fontColour: Colours.txt_grey,
                        // ),
                        // Txt(
                        //   text: glb.clinicBranchDoc.img3,
                        //   fontColour: Colours.txt_grey,
                        // ),
                        // Txt(
                        //   text: glb.clinicBranchDoc.img4,
                        //   fontColour: Colours.txt_grey,
                        // ),
                        // Txt(
                        //   text: glb.clinicBranchDoc.img5,
                        //   fontColour: Colours.txt_grey,
                        // ),
                        Divider(
                          color: Colours.divider_grey,
                        ),
                        Wrap(
                          spacing: Sizer.w_10,
                          runSpacing: Sizer.h_10,
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        glb.clinicRole == '0'
                                            ? "${glb.clinic.img2}?cache_bust=${Random().nextInt(10000)}"
                                            : glb.clinicRole == '1'
                                                ? "${glb.clinicBranch.img2}?cache_bust=${Random().nextInt(10000)}"
                                                : "${glb.clinicBranchDoc.img2}?cache_bust=${Random().nextInt(10000)}",
                                        // "https://bighterapp.bighter.com/images/clinic_images/4_Cimg_1.jpg",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Iconsax.image);
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (glb.clinicRole == '0') {
                                        _pickImage("2", glb.clinic.clinic_id);
                                      } else if (glb.clinicRole == '1') {
                                        _pickImage(
                                            "2", glb.clinicBranch.branch_id);
                                      } else if (glb.clinicRole == '2') {
                                        _pickImage(
                                            "2", glb.clinicBranchDoc.doc_id);
                                      }
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "upload"),
                                          Icon(Iconsax.document_upload),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        glb.clinicRole == '0'
                                            ? "${glb.clinic.img3}?cache_bust=${Random().nextInt(10000)}"
                                            : glb.clinicRole == '1'
                                                ? "${glb.clinicBranch.img3}?cache_bust=${Random().nextInt(10000)}"
                                                : "${glb.clinicBranchDoc.img3}?cache_bust=${Random().nextInt(10000)}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Iconsax.image);
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (glb.clinicRole == '0') {
                                        _pickImage("3", glb.clinic.clinic_id);
                                      } else if (glb.clinicRole == '1') {
                                        _pickImage(
                                            "3", glb.clinicBranch.branch_id);
                                      } else if (glb.clinicRole == '2') {
                                        _pickImage(
                                            "3", glb.clinicBranchDoc.doc_id);
                                      }
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "upload"),
                                          Icon(Iconsax.document_upload),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        glb.clinicRole == '0'
                                            ? "${glb.clinic.img4}?cache_bust=${Random().nextInt(10000)}"
                                            : glb.clinicRole == '1'
                                                ? "${glb.clinicBranch.img4}?cache_bust=${Random().nextInt(10000)}"
                                                : "${glb.clinicBranchDoc.img4}?cache_bust=${Random().nextInt(10000)}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Iconsax.image);
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (glb.clinicRole == '0') {
                                        _pickImage("4", glb.clinic.clinic_id);
                                      } else if (glb.clinicRole == '1') {
                                        _pickImage(
                                            "4", glb.clinicBranch.branch_id);
                                      } else if (glb.clinicRole == '2') {
                                        _pickImage(
                                            "4", glb.clinicBranchDoc.doc_id);
                                      }
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "upload"),
                                          Icon(Iconsax.document_upload),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.network(
                                        glb.clinicRole == '0'
                                            ? "${glb.clinic.img5}?cache_bust=${Random().nextInt(10000)}"
                                            : glb.clinicRole == '1'
                                                ? "${glb.clinicBranch.img5}?cache_bust=${Random().nextInt(10000)}"
                                                : "${glb.clinicBranchDoc.img5}?cache_bust=${Random().nextInt(10000)}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Iconsax.image);
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (glb.clinicRole == '0') {
                                        _pickImage("5", glb.clinic.clinic_id);
                                      } else if (glb.clinicRole == '1') {
                                        _pickImage(
                                            "5", glb.clinicBranch.branch_id);
                                      } else if (glb.clinicRole == '2') {
                                        _pickImage(
                                            "5", glb.clinicBranchDoc.doc_id);
                                      }
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "upload"),
                                          Icon(Iconsax.document_upload),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Update_clinic_dets_async(
    String name,
    String adrs,
    String mob_no,
    String email,
  ) async {
    print("Update_clinic_dets_async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.UpdateClinic);
    var boody = {};
    if (glb.clinicRole == '0') {
      boody = {
        'clinic_role': '0',
        'clinic_name': '$name',
        'clinic_id': '${glb.clinic.clinic_id}',
        'address': "$adrs"
      };
    } else if (glb.clinicRole == '1') {
      boody = {
        'clinic_role': '1',
        'branch_name': '$name',
        'branch_id': '${glb.clinicBranch.branch_id}',
        'address': "$adrs"
      };
    } else {
      boody = {
        'clinic_role': '2',
        'branchDoc_name': '$name',
        'branchDoc_id': '${glb.clinicBranchDoc.doc_id}',
        'branchDoc_mobno': "$mob_no",
        'branchDoc_email': "$email",
      };
    }

    try {
      var res = await http.post(url,
          headers: {
            'accept': 'application/json',
          },
          body: boody);
      print(res.statusCode);
      print(res.body);

      if (res.body == '1') {
        setState(() {
          print("11");
          if (glb.clinicRole == '0') {
            clinicLogin_async(glb.clinic.usr_nm, glb.clinic.pswd);
          } else if (glb.clinicRole == '1') {
            clinicLogin_async(glb.clinicBranch.usr_nm, glb.clinic.pswd);
          } else if (glb.clinicRole == '2') {
            clinicLogin_async(glb.clinicBranchDoc.usr_nm, glb.clinic.pswd);
          }

          // login_async(glb.clinic.contact_no, glb.clinic.pswd, 'dets');
        });
      }

      setState(() {});
    } catch (e) {
      print("Exception => $e");
    }
  }

  File? _imageFile;
  Future<void> _pickImage(
    String imgNO,
    String clinic_id,
  ) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print("vv");
        print(_imageFile!.path);
        glb.loading(context);
        _sendImage1(imgNO, clinic_id);
        // _senddocImage1();
      });
    }
  }

  // upload() async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse(glb.API.baseURL + glb.API.upload_clinic_img));
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       filename: 'img3',

  //     ),
  //   );

  //   // request.files.add("clinic_id":"");
  //   request.fields['image_number'] = "img3";
  //   request.fields['doctor_id'] = "3";
  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully');
  //   } else {
  //     print('Failed to upload image');
  //   }
  // }

  String _response = '';

  Future<void> _sendImage1(String imgNO, String clinic_id) async {
    print("sending img");
    print(">>>> $clinic_id");
    print("clinic role = ${glb.clinicRole}");
    String url = glb.API.baseURL + glb.API.upload_clinic_img;
    final file = _imageFile!.path;
    String imgNM = "_Cimg_${imgNO}.jpg";
    if (glb.clinicRole == '1') {
      url = glb.API.baseURL + "upload_branch_img";
      imgNM = "_Bimg_${imgNO}.jpg";
    } else if (glb.clinicRole == '2') {
      url = glb.API.baseURL + "upload_branchDoc_img";
      imgNM = "_BDimg_${imgNO}.jpg";
    }

    final response = await http.get(Uri.parse(file));
    final Uint8List imageData = response.bodyBytes;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      http.MultipartFile.fromBytes(
        'img',
        imageData,
        filename: '${clinic_id}${imgNM}',
      ),
    );
    request.fields['image_number'] = "img${imgNO}";
    if (glb.clinicRole == '0') {
      request.fields['doctor_id'] = "${clinic_id}"; // Clinic ID
    } else if (glb.clinicRole == '1') {
      request.fields['branch_id'] =
          "${glb.clinicBranch.branch_id}"; // Branch ID
    } else if (glb.clinicRole == '2') {
      request.fields['DoctorID'] =
          "${glb.clinicBranchDoc.doc_id}"; // Branch doctor ID
    }

    print(file);
    print("sending img 2");
    try {
      print("try");
      final response = await request.send();
      print("sts code = ${response.statusCode}");
      print("hdr = ${response.headers}");
// print(response.b)
      if (response.statusCode == 200) {
        setState(() {
          if (glb.clinicRole == '0') {
            login_async(glb.clinic.contact_no, glb.clinic.pswd, 'img');
          } else if (glb.clinicRole == '1') {
            login_async(glb.clinicBranch.usr_nm, glb.clinicBranch.pswd, 'img');
          } else if (glb.clinicRole == '2') {
            login_async(
                glb.clinicBranchDoc.usr_nm, glb.clinicBranchDoc.pswd, 'img');
          }

          _response = 'Image uploaded successfully';
        });
      } else {
        setState(() {
          _response = 'Failed to upload image';
        });
      }
    } catch (e) {
      print("catch");
      print(e);
      setState(() {
        _response = 'Failed to upload image';
      });
    }

    print("sending img exit");
  }

  login_async(String data, String Password, String updt) async {
    print("Login async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.login);
    if (glb.usrTyp == '2') {
      url = Uri.parse(glb.API.baseURL + "getCliniLogin");
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
          'user_name': '$data',
        },
      );
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      print(bdy);
      if (glb.usrTyp == '2') {
        if (updt == "img") {
          setState(() {
            // glb.clinic.clinic_id = bdy[0]['ID'].toString();
            // glb.clinic.clinic_name = bdy[0]['clinic_name'].toString();
            // glb.clinic.contact_no = bdy[0]['mobile_no'].toString();
            // glb.clinic.pswd = bdy[0]['pswd'].toString();
            // glb.clinic.email_id = bdy[0]['email_id'].toString();
            // glb.clinic.address = bdy[0]['address'].toString();
            if (glb.clinicRole == '0') {
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
            } else if (glb.clinicRole == '1') {
              glb.clinicBranch.img1 =
                  "${glb.API.baseURL}images/branch_images/" +
                      bdy[0]['img1'].toString();
              glb.clinicBranch.img2 =
                  "${glb.API.baseURL}images/branch_images/" +
                      bdy[0]['img2'].toString();
              glb.clinicBranch.img3 =
                  "${glb.API.baseURL}images/branch_images/" +
                      bdy[0]['img3'].toString();
              glb.clinicBranch.img4 =
                  "${glb.API.baseURL}images/branch_images/" +
                      bdy[0]['img4'].toString();
              glb.clinicBranch.img5 =
                  "${glb.API.baseURL}images/branch_images/" +
                      bdy[0]['img5'].toString();
            } else if (glb.clinicRole == '2') {
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
            }
          });
        } else {
          setState(() {
            glb.clinic.clinic_name = bdy[0]['clinic_name'].toString();
            glb.clinic.address = bdy[0]['address'].toString();
          });
        }

        glb.SuccessToast(context, "Done");
        // Navigator.pushNamed(context, RG.Clinic_homePG_rt);
      }
    } catch (e) {
      print("Exception => $e");
    }
    Navigator.pop(context);
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
        }
      }
    } catch (e) {}
    glb.SuccessToast(context, "Done");
    Navigator.pop(context);
  }
}
