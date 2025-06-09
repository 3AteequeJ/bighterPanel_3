// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/commonScreens/addDoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class profile_settings extends StatefulWidget {
  const profile_settings({super.key});

  @override
  State<profile_settings> createState() => _profile_settingsState();
}

class _profile_settingsState extends State<profile_settings> {
  TextEditingController nm_cont = TextEditingController();
  TextEditingController mobno_cont = TextEditingController();
  TextEditingController mail_cont = TextEditingController();
  TextEditingController pswd_cont = TextEditingController();
  TextEditingController address_cont = TextEditingController();
  TextEditingController locLnk_cont = TextEditingController();
  TextEditingController clinicFee_cont = TextEditingController();
  TextEditingController onlineFee_cont = TextEditingController();
  TextEditingController personalStmt_cont = TextEditingController();
  TextEditingController exp_cont = TextEditingController();
  TextEditingController speciality_cont = TextEditingController();
  bool isHid = true;
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    setState(() {
      // DefaultCacheManager().removeFile(glb.doctor.img);
      // DefaultCacheManager().removeFile(glb.doctor.img1);
      // DefaultCacheManager().removeFile(glb.doctor.img2);
      // DefaultCacheManager().removeFile(glb.doctor.img3);
      // DefaultCacheManager().removeFile(glb.doctor.img4);

      if (glb.usrTyp == '1') {
        nm_cont.text = glb.doctor.name;
        mobno_cont.text = glb.doctor.mobile_no;
        mail_cont.text = glb.doctor.email;
        pswd_cont.text = glb.doctor.pswd;
        address_cont.text = glb.doctor.address;
        locLnk_cont.text = glb.doctor.LocationLnk;
        clinicFee_cont.text = glb.doctor.fees_clinic;
        onlineFee_cont.text = glb.doctor.fees_online;
        personalStmt_cont.text = glb.doctor.personal_stmt;
        exp_cont.text = glb.doctor.experience;
        speciality_cont.text = glb.doctor.speciality;
      } else {
        nm_cont.text = glb.clinicBranchDoc.name;
        mobno_cont.text = glb.clinicBranchDoc.mobile_no;
        mail_cont.text = glb.clinicBranchDoc.email;
        pswd_cont.text = glb.clinicBranchDoc.pswd;
        address_cont.text = glb.clinicBranchDoc.address;
        locLnk_cont.text = glb.clinicBranchDoc.LocationLnk;
        clinicFee_cont.text = glb.clinicBranchDoc.fees_clinic;
        onlineFee_cont.text = glb.clinicBranchDoc.fees_online;
        personalStmt_cont.text = glb.clinicBranchDoc.personal_stmt;
        exp_cont.text = glb.clinicBranchDoc.experience;
        speciality_cont.text = glb.clinicBranchDoc.speciality;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return currentWidth <= 600
        ? Padding(
            padding: EdgeInsets.all(Sizer.Pad),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: Sizer.h_50 * 2,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: Sizer.radius_10 * 5,
                                backgroundColor: Colours.HunyadiYellow,

                                backgroundImage: NetworkImage(
                                  "${glb.doctor.img}?cache_bust=${Random().nextInt(10000)}",
                                ),
                                // child: Image.network(
                                //   "${glb.doctor.img}?cache_bust=${Random().nextInt(10000)}",
                                //   errorBuilder: (context, error, stackTrace) {
                                //     return Icon(Iconsax.image5);
                                //   },
                                // ),
                              ),
                              InkWell(
                                onTap: () {
                                  _pickImage('doctor_img');
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
                        Expanded(
                            child: Wrap(
                          runAlignment: WrapAlignment.start,
                          spacing: Sizer.w_20,
                          runSpacing: Sizer.h_10,
                          children: [
                            // todo: name
                            w200SizedBox(
                              wd: (3.255 * 6).w,
                              child: TextField(
                                controller: nm_cont,
                                decoration: InputDecoration(
                                  labelText: "Doctor name",
                                  hoverColor: Colours.HunyadiYellow,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                            // todo: email tf
                            w200SizedBox(
                              wd: (3.255 * 6).w,
                              child: TextField(
                                enabled: false,
                                controller: mail_cont,
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
                            // todo: mobno tf
                            w200SizedBox(
                              wd: (3.255 * 6).w,
                              child: TextField(
                                controller: mobno_cont,
                                enabled: false,
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
                            // todo: pswd tf
                            w200SizedBox(
                              wd: (3.255 * 6).w,
                              child: TextField(
                                controller: pswd_cont,
                                obscureText: isHid,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hoverColor: Colours.HunyadiYellow,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHid = !isHid;
                                      });
                                    },
                                    icon: Icon(isHid
                                        ? Iconsax.eye
                                        : Iconsax.eye_slash),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                            // todo: consultation fee tf
                            // todo: pswd tf
                            w200SizedBox(
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

                            //  todo: address tf
                            w200SizedBox(
                              wd: (3.255 * 6).w,
                              child: TextFormField(
                                controller: address_cont,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Address",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (nm_cont.text.trim() == glb.clinic.clinic_name &&
                              mobno_cont.text.trim() == glb.clinic.address) {
                          } else {
                            glb.loading(context);
                            Update_doc_dets_async(
                              nm_cont.text.trim(),
                              mobno_cont.text.trim(),
                              mail_cont.text.trim(),
                              pswd_cont.text.trim(),
                              address_cont.text.trim(),
                            );
                          }
                        },
                        child: Txt(
                          text: 'Update',
                          fntWt: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Sizer.h_10,
                    ),
                    Txt(
                      text: "Images",
                      fontColour: Colours.txt_grey,
                    ),

                    // ElevatedButton(
                    //     onPressed: () {
                    //       _pickImage();
                    //     },
                    //     child: Txt(text: "update img")),
                    Divider(
                      color: Colours.divider_grey,
                    ),
                    Padding(
                      padding: EdgeInsets.all(Sizer.Pad),
                      child: Wrap(
                        spacing: Sizer.w_10,
                        runSpacing: Sizer.h_10,
                        children: [
                          // ? Image 1
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colours.HunyadiYellow.withOpacity(0.3),
                              border: Border.all(),
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      glb.ConfirmationBox(context,
                                          "You want to delete this image?", () {
                                        Remove_single_img("img1");
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colours.Red,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    glb.doctor.img1,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                Container(
                                  color: Colours.HunyadiYellow.withOpacity(0.6),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    child: PhotoView(
                                                        imageProvider:
                                                            NetworkImage(
                                                  glb.doctor.img1,
                                                )));
                                              });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 50,
                                          color: Colours.nonPhoto_blue,
                                          child: Icon(
                                              Icons.remove_red_eye_outlined),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _pickImage('img1');
                                          },
                                          child: Container(
                                            height: 50,
                                            color: Colours.green,
                                            child: Icon(Icons.upload),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ? Image 2
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colours.HunyadiYellow.withOpacity(0.3),
                              border: Border.all(),
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      glb.ConfirmationBox(context,
                                          "You want to delete this image?", () {
                                        Remove_single_img("img2");
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colours.Red,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    glb.doctor.img2,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                Container(
                                  color: Colours.HunyadiYellow.withOpacity(0.6),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    child: PhotoView(
                                                        imageProvider:
                                                            NetworkImage(
                                                  glb.doctor.img2,
                                                )));
                                              });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 50,
                                          color: Colours.nonPhoto_blue,
                                          child: Icon(
                                              Icons.remove_red_eye_outlined),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _pickImage('img2');
                                          },
                                          child: Container(
                                            height: 50,
                                            color: Colours.green,
                                            child: Icon(Icons.upload),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ? Image 3
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colours.HunyadiYellow.withOpacity(0.3),
                              border: Border.all(),
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      glb.ConfirmationBox(context,
                                          "You want to delete this image?", () {
                                        Remove_single_img("img3");
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colours.Red,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    glb.doctor.img3,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                Container(
                                  color: Colours.HunyadiYellow.withOpacity(0.6),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    child: PhotoView(
                                                        imageProvider:
                                                            NetworkImage(
                                                  glb.doctor.img1,
                                                )));
                                              });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 50,
                                          color: Colours.nonPhoto_blue,
                                          child: Icon(
                                              Icons.remove_red_eye_outlined),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _pickImage('img3');
                                          },
                                          child: Container(
                                            height: 50,
                                            color: Colours.green,
                                            child: Icon(Icons.upload),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ? Image 4
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colours.HunyadiYellow.withOpacity(0.3),
                              border: Border.all(),
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      glb.ConfirmationBox(context,
                                          "You want to delete this image?", () {
                                        Remove_single_img("img4");
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colours.Red,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    glb.doctor.img4,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                Container(
                                  color: Colours.HunyadiYellow.withOpacity(0.6),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    child: PhotoView(
                                                        imageProvider:
                                                            NetworkImage(
                                                  glb.doctor.img1,
                                                )));
                                              });
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 50,
                                          color: Colours.nonPhoto_blue,
                                          child: Icon(
                                              Icons.remove_red_eye_outlined),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            _pickImage('img4');
                                          },
                                          child: Container(
                                            height: 50,
                                            color: Colours.green,
                                            child: Icon(Icons.upload),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Txt(
                      text: "Doctor profile settings",
                      fntWt: FontWeight.bold,
                      size: 18,
                      fontColour: Colours.RussianViolet,
                    ),
                  ),
                  SizedBox(
                    height: Sizer.h_50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      7.sp,
                    ),
                    child: Row(
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
                                  glb.usrTyp == '1'
                                      ? "${glb.doctor.img}?cache_bust=${Random().nextInt(10000)}"
                                      : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                                ),
                                // child: Image.network(
                                //   "${glb.doctor.img}?cache_bust=${Random().nextInt(10000)}",
                                //   errorBuilder: (context, error, stackTrace) {
                                //     return Icon(Iconsax.image5);
                                //   },
                                // ),
                              ),
                              InkWell(
                                onTap: () {
                                  _pickImage('doctor_img');
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
                        Expanded(
                          child: Wrap(
                            spacing: Sizer.w_10,
                            runSpacing: Sizer.h_10,
                            children: [
                              // todo: name
                              w200SizedBox(
                                wd: (3.255 * 6).w,
                                child: TextField(
                                  controller: nm_cont,
                                  decoration: InputDecoration(
                                    labelText: "Doctor name",
                                    hoverColor: Colours.HunyadiYellow,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
                              // todo: email tf
                              w200SizedBox(
                                wd: (3.255 * 6).w,
                                child: TextField(
                                  controller: mail_cont,
                                  enabled: false,
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
                              // todo: mobno tf
                              w200SizedBox(
                                wd: (3.255 * 6).w,
                                child: TextField(
                                  controller: mobno_cont,
                                  enabled: false,
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
                              // todo: pswd tf
                              SizedBox(
                                width: Sizer.w_50 * 6,
                                child: TextField(
                                  controller: pswd_cont,
                                  obscureText: isHid,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    hoverColor: Colours.HunyadiYellow,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isHid = !isHid;
                                        });
                                      },
                                      icon: Icon(isHid
                                          ? Iconsax.eye
                                          : Iconsax.eye_slash),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
// todo: consultation fee tf
// todo: pswd tf
                              SizedBox(
                                width: Sizer.w_50 * 6,
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

                              //  todo: address tf
                              SizedBox(
                                width: Sizer.w_50 * 6,
                                child: TextFormField(
                                  controller: address_cont,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (nm_cont.text.trim() ==
                                            glb.clinic.clinic_name &&
                                        mobno_cont.text.trim() ==
                                            glb.clinic.address) {
                                    } else {
                                      glb.loading(context);
                                      glb.usrTyp == '1'
                                          ? Update_doc_dets_async(
                                              nm_cont.text.trim(),
                                              mobno_cont.text.trim(),
                                              mail_cont.text.trim(),
                                              pswd_cont.text.trim(),
                                              address_cont.text.trim(),
                                            )
                                          : Update_clinic_dets_async(
                                              nm_cont.text.trim(),
                                              address_cont.text.trim(),
                                              mobno_cont.text.trim(),
                                              mail_cont.text.trim(),
                                              pswd_cont.text.trim(),
                                            );

                                      //

                                      //
                                    }
                                  },
                                  child: Txt(
                                    text: 'Update',
                                    fntWt: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Sizer.h_50,
                  ),
                  SizedBox(
                    height: Sizer.h_10,
                  ),
                  Txt(
                    text: "Images",
                    fontColour: Colours.txt_grey,
                  ),
                  Divider(
                    color: Colours.divider_grey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Sizer.Pad),
                    child: Wrap(
                      spacing: Sizer.w_10,
                      runSpacing: Sizer.h_10,
                      children: [
                        ImageContainer(
                          glb.usrTyp == '1'
                              ? glb.doctor.img1
                              : glb.clinicBranchDoc.img2 +
                                  "?cache_bust=${Random().nextInt(10000)}",
                          glb.usrTyp == '1' ? "img1" : '2',
                        ),
                        ImageContainer(
                          glb.usrTyp == '1'
                              ? glb.doctor.img2
                              : glb.clinicBranchDoc.img3 +
                                  "?cache_bust=${Random().nextInt(10000)}",
                          glb.usrTyp == '1' ? "img2" : '3',
                        ),
                        ImageContainer(
                          glb.usrTyp == '1'
                              ? glb.doctor.img3
                              : glb.clinicBranchDoc.img4 +
                                  "?cache_bust=${Random().nextInt(10000)}",
                          glb.usrTyp == '1' ? "img3" : '4',
                        ),
                        ImageContainer(
                          glb.usrTyp == '1'
                              ? glb.doctor.img4
                              : glb.clinicBranchDoc.img5 +
                                  "?cache_bust=${Random().nextInt(10000)}",
                          glb.usrTyp == '1' ? "img4" : '5',
                        ),
                      ],
                    ),
                  ),
                  Txt(
                    text: "Additional fields",
                    fontColour: Colours.txt_grey,
                  ),
                  Divider(
                    color: Colours.divider_grey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Wrap(
                      runSpacing: 5.h,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 25.w,
                              child: TextField(
                                controller: locLnk_cont,
                                decoration: InputDecoration(
                                  labelText: "Location link",
                                  hoverColor: Colours.HunyadiYellow,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Only digits allowed
                                ],
                                controller: exp_cont,
                                decoration: InputDecoration(
                                  labelText: "Experience",
                                  hoverColor: Colours.HunyadiYellow,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Txt(text: "Consultation fees"),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 25.w,
                                child: TextField(
                                  controller: clinicFee_cont,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Only digits allowed
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Clinic fee",
                                    hoverColor: Colours.HunyadiYellow,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25.w,
                                child: TextField(
                                  controller: onlineFee_cont,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Only digits allowed
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Online fee",
                                    hoverColor: Colours.HunyadiYellow,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Sizer.radius_10 / 5),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Txt(text: "Personal statement"),
                        TextField(
                          controller: personalStmt_cont,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your message',
                          ),
                          maxLines: 10, // Allows infinite lines
                          keyboardType: TextInputType.multiline,
                        ),
                        // CircleAvatar(
                        //   backgroundColor: Colours.RosePink.withOpacity(0.5),
                        //   child: Icon(Icons.add),
                        // ),
                        ElevatedButton(
                            onPressed: () {
                              String clinic_f = clinicFee_cont.text.trim();
                              String online_f = onlineFee_cont.text.trim();
                              String ps = personalStmt_cont.text.trim();
                              String loc_lnk = locLnk_cont.text.trim();
                              String exp = exp_cont.text.trim();
                              Update_additional_dets_async(
                                  clinic_f, online_f, ps, loc_lnk, exp);
                            },
                            child: Txt(text: "Update additional fields"))
                      ],
                    ),
                  )
                  // Txt(
                  //   text: "Images",
                  //   size: 14,
                  //   fontColour: Colours.txt_grey,
                  // ),
                  // Divider(
                  //   color: Colours.divider_grey,
                  // ),
                  // Wrap(
                  //   spacing: Sizer.w_10,
                  //   runSpacing: Sizer.h_10,
                  //   children: [
                  //     Container(
                  //       height: 200,
                  //       width: 200,
                  //       decoration: BoxDecoration(
                  //         color: Colours.HunyadiYellow.withOpacity(0.3),
                  //         border: Border.all(),
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           Txt(text: "ID"),
                  //           Expanded(
                  //             child: Center(
                  //               child: Image.network(
                  //                 "${glb.doctor.img1}",
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   return Icon(Iconsax.image);
                  //                 },
                  //               ),
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: () async {
                  //               // _pickImage("2", glb.clinic.clinic_id);
                  //             },
                  //             child: Container(
                  //               color: Colours.HunyadiYellow.withOpacity(0.6),
                  //               height: 50,
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Txt(text: "View"),
                  //                   Icon(Iconsax.eye4),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 200,
                  //       width: 200,
                  //       decoration: BoxDecoration(
                  //         color: Colours.HunyadiYellow.withOpacity(0.3),
                  //         border: Border.all(),
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           Txt(text: "Degree certificate"),
                  //           Expanded(
                  //             child: Center(
                  //               child: Image.network(
                  //                 "${glb.doctor.img2}",
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   return Icon(Iconsax.image);
                  //                 },
                  //               ),
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               // _pickImage("3", glb.clinic.clinic_id);
                  //             },
                  //             child: Container(
                  //               color: Colours.HunyadiYellow.withOpacity(0.6),
                  //               height: 50,
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Txt(text: "View"),
                  //                   Icon(Iconsax.eye4),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 200,
                  //       width: 200,
                  //       decoration: BoxDecoration(
                  //         color: Colours.HunyadiYellow.withOpacity(0.3),
                  //         border: Border.all(),
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           Txt(text: "Medical council certificate"),
                  //           Expanded(
                  //             child: Center(
                  //               child: Image.network(
                  //                 "${glb.doctor.img3}",
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   return Icon(Iconsax.image);
                  //                 },
                  //               ),
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               // _pickImage("4", glb.clinic.clinic_id);
                  //               _pickImage();
                  //             },
                  //             child: Container(
                  //               color: Colours.HunyadiYellow.withOpacity(0.6),
                  //               height: 50,
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Txt(text: "View"),
                  //                   Icon(Iconsax.eye4),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          );
  }

  ImageContainer(String image, String img_no) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colours.HunyadiYellow.withOpacity(0.3),
        border: Border.all(),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                glb.ConfirmationBox(context, "You want to delete this image?",
                    () {
                  Remove_single_img(img_no);
                });
              },
              child: Icon(
                Icons.close,
                color: Colours.Red,
              ),
            ),
          ),
          Expanded(
            child:
                // Center(
                // child: _imageFile == null
                //     ? Text('No image selected')
                //     : Image.file(io.File(_imageFile!.path)),
                Image.network(
              // "${glb.clinic.img2}",
              image,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Iconsax.image);
              },
            ),
          ),
          Container(
            color: Colours.HunyadiYellow.withOpacity(0.6),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                              child: PhotoView(
                                  imageProvider: NetworkImage(
                            image,
                          )));
                        });
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colours.nonPhoto_blue,
                    child: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(img_no);
                    },
                    child: Container(
                      height: 50,
                      color: Colours.green,
                      child: Icon(Icons.upload),
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

  Update_clinic_dets_async(
    String name,
    String adrs,
    String mob_no,
    String email,
    String pswd,
  ) async {
    print("Update_clinic_dets_async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.UpdateClinic);
    var boody = {};
    if (glb.clinicRole == '0') {
      boody = {
        'clinic_role': '0',
        'clinic_name': '$name',
        'clinic_id': '${glb.clinic.clinic_id}',
        'address': "$adrs",
        'pswd': pswd,
      };
    } else if (glb.clinicRole == '1') {
      boody = {
        'clinic_role': '1',
        'branch_name': '$name',
        'branch_id': '${glb.clinicBranch.branch_id}',
        'address': "$adrs",
        'pswd': pswd,
      };
    } else {
      boody = {
        'clinic_role': '2',
        'branchDoc_name': '$name',
        'branchDoc_id': '${glb.clinicBranchDoc.doc_id}',
        'master_credentials_id': glb.clinicBranchDoc.credentials_id,
        'password': pswd,
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

      if (res.statusCode == 200) {
        Navigator.pop(context);
        setState(() {
          if (glb.clinicRole == '0') {
            c_login_async(glb.clinic.usr_nm, glb.clinic.pswd, "");
          } else if (glb.clinicRole == '1') {
            c_login_async(glb.clinicBranch.usr_nm, glb.clinic.pswd, "");
          } else if (glb.clinicRole == '2') {
            c_login_async(glb.clinicBranchDoc.usr_nm, glb.clinic.pswd, "");
          }

          // login_async(glb.clinic.contact_no, glb.clinic.pswd, 'dets');
        });
      }

      setState(() {});
    } catch (e) {
      print("Exception => $e");
    }
  }

  Update_doc_dets_async(String name, String mobno, String mail, String pswd,
      String address) async {
    print("Update_clinic_dets_async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.UpdateDocDet);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'doc_id': "${glb.doctor.doc_id}",
        'name': '$name',
        'mobile_no': '${glb.doctor.mobile_no}',
        'email_id': "${glb.doctor.email}",
        'pswd': "${glb.doctor.pswd}",
        'address': "${address}",
      });
      print(res.statusCode);
      print(res.body);

      if (res.body == '1') {
        setState(() {
          print("11");
          glb.usrTyp == '1'
              ? login_async(glb.doctor.mobile_no, glb.clinic.pswd, "")
              : c_login_async(glb.doctor.mobile_no, glb.clinic.pswd, "");
        });
      }

      setState(() {});
    } catch (e) {
      print("Exception => $e");
    }
  }

  Update_additional_dets_async(String clinic_f, String online_f, String ps,
      String loc_lnk, String exp) async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.UpdateAdditionalFields);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'doc_id': glb.usrTyp == '1'
            ? "${glb.doctor.doc_id}"
            : "${glb.clinicBranchDoc.doc_id}",
        'branch_doc': glb.usrTyp == '1' ? '0' : '1',
        'clinic_fee': clinic_f,
        'online_fee': online_f,
        'ps': ps,
        'loc_lnk': loc_lnk,
        'exp': exp,
      });
      print(res.statusCode);
      print(res.body);

      if (res.body == '1') {
        setState(() {
          print("11");
          glb.usrTyp == '1'
              ? login_async(glb.doctor.mobile_no, glb.clinic.pswd, "")
              : c_login_async(glb.doctor.mobile_no, glb.clinic.pswd, "");
        });
      }

      setState(() {});
    } catch (e) {
      print("Exception => $e");
    }
  }

  File? _imageFile;
  Future<void> _pickImage(String img_no) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print("vv");
        print(_imageFile!.path);
        glb.loading(context);
        // _sendImage1(imgNO, clinic_id);
        glb.usrTyp == '1'
            ? _senddocImage1(img_no)
            : _sendImage1(img_no, glb.clinicBranchDoc.doc_id);
        // updateDocImg();
      });
    }
  }

  c_login_async(String data, String Password, String updt) async {
    print("clinic Login async ");

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
            glb.clinicBranchDoc.fees_clinic = bdy[0]['fees_clinic'].toString();
            glb.clinicBranchDoc.pswd = bdy[0]['password'].toString();
            glb.clinicBranchDoc.fees_online = bdy[0]['fees_online'].toString();
            glb.clinicBranchDoc.LocationLnk = bdy[0]['location_lnk'].toString();
            glb.clinicBranchDoc.experience = bdy[0]['experience'].toString();
            glb.clinicBranchDoc.personal_stmt =
                bdy[0]['personal_statement'].toString();
          });
        }

        glb.SuccessToast(context, "Done");
        // Navigator.pushNamed(context, RG.Clinic_homePG_rt);
      }
    } catch (e) {
      print("Exception => $e");
    }
  }

  updateDocImg() async {
    final url = glb.API.baseURL + "update_doc_image";
    // final url = glb.API.baseURL + "new_admin_pharmacy";
    final file = _imageFile!.path;

    final response = await http.get(Uri.parse(file));
    final Uint8List imageData = response.bodyBytes;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        // "img",
        imageData,
        filename: '${glb.doctor.doc_id}_img2.jpg',
        // filename: 'caps_img.jpg',
      ),
    );
    print("Doc ID>> ${glb.doctor.doc_id}");
    request.fields['doc_id'] = "${glb.doctor.doc_id}";
    request.fields['image_name'] = "img2";
    // request.fields['image_number'] = "img3";
    print("sending img 2");
    try {
      print("try");
      final response = await request.send();
      print("res = ${response.statusCode}");
      print("res = ${response.headers}");

      if (response.statusCode == 200) {
        setState(() {
          login_async(glb.doctor.mobile_no, glb.doctor.pswd, "img");
        });
      } else {
        setState(() {});
      }
    } catch (e) {
      print("catch");
      print(e);
      setState(() {});
    }
    print("sending img exit");
  }

  Future<void> _senddocImage1(String img_no) async {
    print("sending doc img");
    print(img_no);

    final url = glb.API.baseURL + "update-doctor-images";
    // final url = glb.API.baseURL + "new_admin_pharmacy";
    final file = _imageFile!.path;
    print(file);
    print("^^^^^");
    final response = await http.get(Uri.parse(file));
    final Uint8List imageData = response.bodyBytes;
    print("image data length = ${img_no}");

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        // "img",
        imageData,
        filename: '${glb.doctor.doc_id}_${img_no}.jpg',
        // filename: 'caps_img.jpg',
      ),
    );
    print("Doc ID>> ${glb.doctor.doc_id}");
    request.fields['doc_id'] = "${glb.doctor.doc_id}";
    request.fields['image_name'] = "$img_no";
    // request.fields['image_number'] = "img3";
    print("sending img 2");
    try {
      print("try");
      final response = await request.send();
      var jawab = await http.Response.fromStream(response);
      print("Jawab = ${jawab.body}");
      print(jawab.statusCode);
      // print(jawab);
      print("res = ${response.statusCode}");

      if (response.statusCode == 200) {
        setState(() {
          login_async(glb.doctor.mobile_no, glb.doctor.pswd, "img");
        });
      } else {
        setState(() {});
      }
    } catch (e) {
      print("catch");
      print(e);
      setState(() {});
    }
    print("sending img exit");
  }

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
            c_login_async(glb.clinic.contact_no, glb.clinic.pswd, 'img');
          } else if (glb.clinicRole == '1') {
            c_login_async(
                glb.clinicBranch.usr_nm, glb.clinicBranch.pswd, 'img');
          } else if (glb.clinicRole == '2') {
            c_login_async(
                glb.clinicBranchDoc.usr_nm, glb.clinicBranchDoc.pswd, 'img');
          }

          // _response = 'Image uploaded successfully';
        });
      } else {
        setState(() {
          // _response = 'Failed to upload image';
        });
      }
    } catch (e) {
      print("catch");
      print(e);
      setState(() {
        // _response = 'Failed to upload image';
      });
    }

    print("sending img exit");
  }

  login_async(String data, String Password, String typ) async {
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

      setState(() {
        // glb.doctor.doc_id = bdy[0]['ID'].toString();
        // glb.doctor.name = bdy[0]['Name'].toString();
        // glb.doctor.mobile_no = bdy[0]['mobile_no'].toString();
        // glb.doctor.email = bdy[0]['email_id'].toString();
        // glb.doctor.pswd = bdy[0]['pswd'].toString();
        // glb.doctor.speciality = bdy[0]['Speciality'].toString();
        // glb.doctor.Degree = bdy[0]['Degree'].toString();
        // glb.doctor.clinic_id = bdy[0]['clinic_id'].toString();
        // glb.doctor.available = bdy[0]['available'].toString();
        // glb.doctor.rating = bdy[0]['Rating'].toString();
        if (typ == "img") {
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
        } else {
          glb.doctor.name = bdy[0]['Name'].toString();
          glb.doctor.mobile_no = bdy[0]['mobile_no'].toString();
          glb.doctor.email = bdy[0]['email_id'].toString();
          glb.doctor.pswd = bdy[0]['pswd'].toString();
          glb.doctor.experience = bdy[0]['experience'].toString();
          glb.doctor.LocationLnk = bdy[0]['location_lnk'].toString();
          glb.doctor.fees_clinic = bdy[0]['fees_clinic'].toString();
          glb.doctor.fees_online = bdy[0]['fees_online'].toString();
          glb.doctor.personal_stmt = bdy[0]['personal_statement'].toString();
        }

        Navigator.pop(context);
        glb.SuccessToast(context, "Done");
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  Remove_single_img(String img_no) async {
    // String url = glb.API.baseURL+ "DelAdminProd";
    Uri url = Uri.parse("");
    url = Uri.parse(glb.API.baseURL + "Del_Doctors_Img");

    try {
      var res = await http.post(
        url,
        body: {
          'doc_id': "${glb.doctor.doc_id}",
          'img_no': img_no,
        },
      );

      print("Del response == " + res.statusCode.toString());
      print(res.body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);
        login_async(glb.doctor.mobile_no, glb.doctor.pswd, "img");
      }
    } catch (e) {}
  }
}
