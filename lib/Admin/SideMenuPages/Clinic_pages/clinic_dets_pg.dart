import 'dart:math';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';

class ClinicDets_pg extends StatefulWidget {
  const ClinicDets_pg({
    super.key,
    required this.ClinicID,
  });
  final String ClinicID;
  @override
  State<ClinicDets_pg> createState() => _ClinicDets_pgState();
}

class _ClinicDets_pgState extends State<ClinicDets_pg> {
  TextEditingController nm_cont = TextEditingController();
  TextEditingController mobno_cont = TextEditingController();
  TextEditingController email_cont = TextEditingController();
  TextEditingController addrs_cont = TextEditingController();

  String img1 = "", img2 = "", img3 = "", img4 = "", img5 = "";

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      nm_cont.text = getName(widget.ClinicID);
      mobno_cont.text = getMobno(widget.ClinicID);
      addrs_cont.text = getAddrs(widget.ClinicID);
      img1 = getImg1(widget.ClinicID);
      img2 = getImg2(widget.ClinicID);
      img3 = getImg3(widget.ClinicID);
      img4 = getImg4(widget.ClinicID);
      img5 = getImg5(widget.ClinicID);
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.RosePink,
        title: Txt(text: "Clinic details"),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: currentWidth >= 600
                ? Column(
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
                                        child: Image.network(
                                          "${img1}?cache_bust=${Random().nextInt(10000)}",
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Iconsax.image5);
                                          },
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // _pickImage("1", glb.clinic.clinic_id);
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
                                Container(
                                  // color: Colors.red,
                                  width: 70.w,
                                  height: (6.853 * 3).h,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          w200SizedBox(
                                            wd: (3.255 * 6).w,
                                            child: TextField(
                                              controller: nm_cont,
                                              decoration: InputDecoration(
                                                labelText: "Clinic name",
                                                hoverColor:
                                                    Colours.HunyadiYellow,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Sizer.radius_10 / 5),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          w200SizedBox(
                                            wd: (3.255 * 6).w,
                                            child: TextField(
                                              controller: mobno_cont,
                                              decoration: InputDecoration(
                                                labelText: "Contact number",
                                                hoverColor:
                                                    Colours.HunyadiYellow,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Sizer.radius_10 / 5),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     // if (nm_cont.text.trim() == glb.clinic.clinic_name &&
                                          //     //     adrs_cont.text.trim() == glb.clinic.address) {
                                          //     // } else {
                                          //     //   glb.loading(context);
                                          //     //   Update_clinic_dets_async(
                                          //     //       nm_cont.text.trim(), adrs_cont.text.trim());
                                          //     // }
                                          //   },
                                          //   child: Txt(
                                          //     text: 'Update',
                                          //     fntWt: FontWeight.bold,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          w200SizedBox(
                                            wd: (3.255 * 6).w,
                                            child: TextField(
                                              // controller: nm_cont,
                                              decoration: InputDecoration(
                                                labelText: "Email ID",
                                                hoverColor:
                                                    Colours.HunyadiYellow,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Sizer.radius_10 / 5),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          w200SizedBox(
                                            wd: (3.255 * 8).w,
                                            child: TextField(
                                              controller: addrs_cont,
                                              decoration: InputDecoration(
                                                labelText: "Location",
                                                hoverColor:
                                                    Colours.HunyadiYellow,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Sizer.radius_10 / 5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
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
                            Divider(
                              color: Colours.divider_grey,
                            ),
                            // Txt(text: img1),
                            // Txt(text: img2),
                            // Txt(text: img3),
                            // Txt(text: img4),
                            // Txt(text: img5),
                            Wrap(
                              spacing: Sizer.w_10,
                              runSpacing: Sizer.h_10,
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.3),
                                    border: Border.all(),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Image.network(
                                            "${img2}?cache_bust=${Random().nextInt(10000)}",
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
                                          // _pickImage("2", glb.clinic.clinic_id);
                                        },
                                        child: Container(
                                          color:
                                              Colours.HunyadiYellow.withOpacity(
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
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.3),
                                    border: Border.all(),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Image.network(
                                            "${img3}?cache_bust=${Random().nextInt(10000)}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Iconsax.image);
                                            },
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // _pickImage("3", glb.clinic.clinic_id);
                                        },
                                        child: Container(
                                          color:
                                              Colours.HunyadiYellow.withOpacity(
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
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.3),
                                    border: Border.all(),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Image.network(
                                            "${img4}?cache_bust=${Random().nextInt(10000)}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Iconsax.image);
                                            },
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // _pickImage("4", glb.clinic.clinic_id);
                                        },
                                        child: Container(
                                          color:
                                              Colours.HunyadiYellow.withOpacity(
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
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.3),
                                    border: Border.all(),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Image.network(
                                            "${img5}?cache_bust=${Random().nextInt(10000)}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Iconsax.image);
                                            },
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // _pickImage("5", glb.clinic.clinic_id);
                                        },
                                        child: Container(
                                          color:
                                              Colours.HunyadiYellow.withOpacity(
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
                  )
                : Padding(
                    padding: EdgeInsets.all(Sizer.Pad),
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
                                    radius: 50,
                                    backgroundColor: Colours.HunyadiYellow,
                                    child: Image.network(
                                      "${img1}?cache_bust=${Random().nextInt(10000)}",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Iconsax.image5);
                                      },
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // _pickImage("1", glb.clinic.clinic_id);
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
                            SizedBox(
                              width: Sizer.w_10,
                            ),
                            Expanded(
                              child: Wrap(
                                runSpacing: Sizer.h_10 * 2,
                                spacing: Sizer.w_10,
                                children: [
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
                                  w200SizedBox(
                                    wd: (3.255 * 6).w,
                                    child: TextField(
                                      controller: mobno_cont,
                                      decoration: InputDecoration(
                                        labelText: "Contact number",
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: Sizer.h_10 * 2,
                        ),

                        TextField(
                          // controller: nm_cont,
                          decoration: InputDecoration(
                            labelText: "Email ID",
                            hoverColor: Colours.HunyadiYellow,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Sizer.h_10 * 2,
                        ),
                        TextField(
                          controller: addrs_cont,
                          decoration: InputDecoration(
                            labelText: "Location",
                            hoverColor: Colours.HunyadiYellow,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizer.radius_10 / 5),
                            ),
                          ),
                        ),

                        Txt(
                          text: "Clinic images",
                          size: 14,
                          fontColour: Colours.txt_grey,
                        ),
                        Divider(
                          color: Colours.divider_grey,
                        ),
                        // Txt(text: img1),
                        // Txt(text: img2),
                        // Txt(text: img3),
                        // Txt(text: img4),
                        // Txt(text: img5),
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
                                        "${img2}?cache_bust=${Random().nextInt(10000)}",
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
                                      // _pickImage("2", glb.clinic.clinic_id);
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
                                        "${img3}?cache_bust=${Random().nextInt(10000)}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Iconsax.image);
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // _pickImage("3", glb.clinic.clinic_id);
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
                                        "${img4}?cache_bust=${Random().nextInt(10000)}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Iconsax.image);
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // _pickImage("4", glb.clinic.clinic_id);
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
                                        "${img5}?cache_bust=${Random().nextInt(10000)}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Iconsax.image);
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // _pickImage("5", glb.clinic.clinic_id);
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
                  )),
      ),
    );
  }

  getName(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].name;
        break;
      }
    }
    return a;
  }

  getMobno(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].mobno;
        break;
      }
    }
    return a;
  }

  getAddrs(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].address;
        break;
      }
    }
    return a;
  }

  getImg1(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].img1;
        break;
      }
    }
    return a;
  }

  getImg2(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].img2;
        break;
      }
    }
    return a;
  }

  getImg3(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].img3;
        break;
      }
    }
    return a;
  }

  getImg4(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].img4;
        break;
      }
    }
    return a;
  }

  getImg5(String ClinicID) {
    String a = "";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].img5;
        break;
      }
    }
    return a;
  }
}
