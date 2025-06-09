import 'dart:convert';

import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import '../../../../models/AllDoc_model.dart';

class VerifiedDocDets extends StatefulWidget {
  const VerifiedDocDets({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<VerifiedDocDets> createState() => _VerifiedDocDetsState();
}

class _VerifiedDocDetsState extends State<VerifiedDocDets> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colours.RosePink,
          title: Txt(text: "Verified Doctor details"),
        ),
        body: currentWidth > 600
            ? Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 2.w,
                        runSpacing: 3.h,
                        children: [
                          Container(
                            height: currentWidth <= 600
                                ? Sizer.h_50
                                : (6.853 * 3).h,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: currentWidth <= 600
                                      ? Sizer.radius_10 * 8
                                      : (2.77 * 2).w,
                                  backgroundImage: NetworkImage(""),
                                  backgroundColor: Colours.HunyadiYellow,
                                  child: Image.network(
                                    "${getDocImg(widget.id)}",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image5);
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider:
                                                      NetworkImage("")));
                                        });
                                    // _pickImage();
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
                            width: 50.w,
                            height: 20.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colours.divider_grey),
                                            borderRadius:
                                                BorderRadius.circular(2.w)),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.sp),
                                          child: Txt(
                                              text:
                                                  "Name: ${getDocNM(widget.id)}"),
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colours.divider_grey),
                                          borderRadius:
                                              BorderRadius.circular(2.w)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Txt(
                                            text:
                                                "Email:  ${getDocEmail(widget.id)}"),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colours.divider_grey),
                                          borderRadius:
                                              BorderRadius.circular(2.w)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Txt(
                                            text:
                                                "Mobile number: ${getDocMobno(widget.id)}"),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colours.divider_grey),
                                          borderRadius:
                                              BorderRadius.circular(2.w)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Txt(
                                            text:
                                                "Degree: ${getDocDeg(widget.id)}"),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colours.divider_grey),
                                          borderRadius:
                                              BorderRadius.circular(2.w)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Txt(
                                            text:
                                                "Speciality: ${getDocSpe(widget.id)}"),
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
                        text: "Images",
                        fontColour: Colours.txt_grey,
                      ),
                      // Txt(text: getDocImg3(widget.id)),
                      Divider(
                        color: Colours.divider_grey,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    "${getDocImg2(widget.id)}",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            "${getDocImg2(widget.id)}",
                                          )));
                                        });
                                    // _pickImage();
                                    // selectImage('idp');
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    getDocImg3(widget.id),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            getDocImg3(widget.id),
                                          )));
                                        });
                                    // _pickImage();
                                    // selectImage('cp');
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //
                          SizedBox(
                            width: 100,
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    getDocImg4(widget.id),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            getDocImg4(widget.id),
                                          )));
                                        });
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //
                          SizedBox(
                            width: 100,
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    getDocImg5(widget.id),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    // _pickImage();
                                    // selectImage('ccp');
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            getDocImg5(widget.id),
                                          )));
                                        });
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Sizer.h_50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colours.Red),
                              onPressed: () {
                                glb.ConfirmationBox(
                                    context,
                                    "Doctor and all his data will be removed.",
                                    () {});
                              },
                              child: Txt(text: "Delete")),
                          // ElevatedButton(
                          //     // style: ElevatedButton.styleFrom(s),
                          //     onPressed: () {
                          //       // Update_doc_verifi_async(widget.doc_id);
                          //     },
                          //     child: Txt(
                          //       text: "Verify",
                          //       fontColour: Colours.txt_white,
                          //     )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(Sizer.Pad),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Sizer.h_50 * 2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colours.HunyadiYellow,
                                  backgroundImage:
                                      NetworkImage(getDocImg(widget.id)),
                                  // child: Image.network(
                                  //   "${getDocImg(widget.id)}",
                                  //   errorBuilder: (context, error, stackTrace) {
                                  //     return Icon(Iconsax.image5);
                                  //   },
                                  // ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                                      getDocImg(widget.id))));
                                        });
                                    // _pickImage();
                                  },
                                  child: CircleAvatar(
                                    // radius: 0.55.w,
                                    backgroundColor: Colors.grey[300],
                                    child: Icon(Icons.remove_red_eye_outlined),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Sizer.w_20,
                          ),
                          Expanded(
                            child: Wrap(
                              runSpacing: Sizer.h_10 * 2,
                              spacing: Sizer.w_10,
                              children: [
                                Txt(text: "Name: ${getDocNM(widget.id)}"),
                                Txt(text: "Email:  ${getDocEmail(widget.id)}"),
                                Txt(
                                    text:
                                        "Mobile number: ${getDocMobno(widget.id)}"),
                                Txt(text: "Degree: ${getDocDeg(widget.id)}"),
                                Txt(text: "Speciality: ${getDocSpe(widget.id)}")
                              ],
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: Sizer.h_10,
                      ),
                      // todo: Images
                      Wrap(
                        runSpacing: Sizer.h_10,
                        spacing: Sizer.w_10,
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    "${getDocImg2(widget.id)}",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            "${getDocImg2(widget.id)}",
                                          )));
                                        });
                                    // _pickImage();
                                    // selectImage('idp');
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    getDocImg3(widget.id),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            getDocImg3(widget.id),
                                          )));
                                        });
                                    // _pickImage();
                                    // selectImage('cp');
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    getDocImg4(widget.id),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            getDocImg4(widget.id),
                                          )));
                                        });
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
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
                                  child:
                                      // Center(
                                      // child: _imageFile == null
                                      //     ? Text('No image selected')
                                      //     : Image.file(io.File(_imageFile!.path)),
                                      Image.network(
                                    // "${glb.clinic.img2}",
                                    getDocImg5(widget.id),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Iconsax.image);
                                    },
                                  ),
                                ),
                                // ),
                                InkWell(
                                  onTap: () async {
                                    // _pickImage();
                                    // selectImage('ccp');
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              child: PhotoView(
                                                  imageProvider: NetworkImage(
                                            getDocImg5(widget.id),
                                          )));
                                        });
                                  },
                                  child: Container(
                                    color:
                                        Colours.HunyadiYellow.withOpacity(0.6),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Txt(text: "View"),
                                        Icon(Iconsax.image),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Sizer.h_10),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colours.Red),
                            onPressed: () {
                              glb.ConfirmationBox(
                                  context,
                                  "Doctor and all his data will be removed.",
                                  () {});
                            },
                            child: Txt(text: "Delete")),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Delete_doc_async() async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.delete_doc);

    try {
      var res = await http.post(url, body: {
        'branch_doc': '${getBrach_doc(widget.id)}',
        'doc_id': '${widget.id}',
      });
    } catch (e) {}
  }
}

getDocNM(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].name;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocEmail(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].mail;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocMobno(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].mobno;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocDeg(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].Degree;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocSpe(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].speciality;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocImg(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].img;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocImg2(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].img2;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocImg3(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].img3;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocImg4(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].img4;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}

getDocImg5(String id) {
  String a = "";
  for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
    // print("1= " + i.toString());
    if (glb.Models.AllDocs_lst[i].ID == id) {
      a = glb.Models.AllDocs_lst[i].img5;
      break;
    }
    // print("2= " + i.toString());
  }
  return a;
}
