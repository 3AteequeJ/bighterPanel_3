import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';

import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnverifiedDocDet extends StatefulWidget {
  const UnverifiedDocDet({
    super.key,
    required this.doc_id,
    required this.deg,
    required this.mail,
    required this.mobno,
    required this.name,
    required this.sep,
    required this.cert_img,
    required this.conCert_img,
    required this.doc_img,
    required this.id_img,
  });
  final String doc_id;
  final String name;
  final String mail;
  final String mobno;
  final String deg;
  final String sep;
  final String doc_img;
  final String id_img;
  final String cert_img;
  final String conCert_img;
  @override
  State<UnverifiedDocDet> createState() => _UnverifiedDocDetState();
}

class _UnverifiedDocDetState extends State<UnverifiedDocDet> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colours.RosePink,
          title: Txt(text: "Doctor details"),
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
                            height: (6.853 * 3).h,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: (2.77 * 2).w,
                                  backgroundImage: NetworkImage(
                                      scale: CircularProgressIndicator
                                          .strokeAlignInside,
                                      "${widget.doc_img}"),
                                  backgroundColor: Colours.HunyadiYellow,
                                  // child: Image.network(
                                  //   "${widget.doc_img}",
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
                                                      widget.doc_img)));
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
                                          child:
                                              Txt(text: "Name: ${widget.name}"),
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colours.divider_grey),
                                          borderRadius:
                                              BorderRadius.circular(2.w)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child:
                                            Txt(text: "Email: ${widget.mail}"),
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
                                                "Mobile number: ${widget.mobno}"),
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
                                        child:
                                            Txt(text: "Degree: ${widget.deg}"),
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
                                                  "Speciality: ${widget.sep}")),
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
                      Divider(
                        color: Colours.divider_grey,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // alignment: WrapAlignment.spaceBetween,
                            // crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Txt(
                                text: "ID proof",
                                fntWt: FontWeight.bold,
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
                                        "${widget.id_img}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                                      imageProvider:
                                                          NetworkImage(
                                                              widget.id_img)));
                                            });
                                        // _pickImage();
                                        // selectImage('idp');
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
                            width: 100,
                          ),
                          Column(
                            // alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                text: "Degree certificate",
                                fntWt: FontWeight.bold,
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
                                        "${widget.cert_img}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                                      imageProvider:
                                                          NetworkImage(widget
                                                              .cert_img)));
                                            });
                                        // _pickImage();
                                        // selectImage('cp');
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
                          //
                          SizedBox(
                            width: 100,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // alignment: WrapAlignment.spaceBetween,
                            // crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Txt(
                                text: "Medical council certificate",
                                fntWt: FontWeight.bold,
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
                                        "${widget.conCert_img}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                                      imageProvider:
                                                          NetworkImage(widget
                                                              .conCert_img)));
                                            });
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
                          //
                        ],
                      ),
                      SizedBox(
                        height: Sizer.h_50,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            // style: ElevatedButton.styleFrom(s),
                            onPressed: () {
                              Update_doc_verifi_async(widget.doc_id);
                            },
                            child: Txt(
                              text: "Verify",
                              fontColour: Colours.txt_white,
                            )),
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
                        children: [
                          Container(
                            height: Sizer.h_50 * 2,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage("${widget.doc_img}"),
                                  backgroundColor: Colours.HunyadiYellow,
                                  // child: Image.network(
                                  //   "${widget.doc_img}",
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
                                                      widget.doc_img)));
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
                            width: Sizer.w_20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(text: "Name: ${widget.name}"),
                              Txt(text: "Email: ${widget.mail}"),
                              Txt(text: "Mobile number: ${widget.mobno}"),
                              Txt(text: "Degree: ${widget.deg}"),
                              Txt(text: "Speciality: ${widget.sep}"),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Sizer.h_10 * 3,
                      ),
                      Wrap(
                        spacing: Sizer.w_20,
                        runSpacing: Sizer.h_10 * 2,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // alignment: WrapAlignment.spaceBetween,
                            // crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Txt(
                                text: "ID proof",
                                fntWt: FontWeight.bold,
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
                                        "${widget.id_img}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                                      imageProvider:
                                                          NetworkImage(
                                                              widget.id_img)));
                                            });
                                        // _pickImage();
                                        // selectImage('idp');
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
                            width: 100,
                          ),
                          Column(
                            // alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                text: "Degree certificate",
                                fntWt: FontWeight.bold,
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
                                        "${widget.cert_img}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                                      imageProvider:
                                                          NetworkImage(widget
                                                              .cert_img)));
                                            });
                                        // _pickImage();
                                        // selectImage('cp');
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
                          //
                          SizedBox(
                            width: 100,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // alignment: WrapAlignment.spaceBetween,
                            // crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Txt(
                                text: "Medical council certificate",
                                fntWt: FontWeight.bold,
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
                                        "${widget.conCert_img}",
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                                      imageProvider:
                                                          NetworkImage(widget
                                                              .conCert_img)));
                                            });
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
                          //
                        ],
                      ),
                      SizedBox(
                        height: Sizer.h_10 * 3,
                      ),
                      ElevatedButton(
                          // style: ElevatedButton.styleFrom(s),
                          onPressed: () {
                            Update_doc_verifi_async(widget.doc_id);
                          },
                          child: Txt(
                            text: "Verify",
                            fontColour: Colours.txt_white,
                          )),
                    ],
                  ),
                ),
              ));
  }

  Update_doc_verifi_async(
    String doc_id,
  ) async {
    print("Update_clinic_dets_async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.UpdateDocVeri);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'doc_id': "${doc_id}",
        'verifi': '1',
      });
      print(res.statusCode);
      print(res.body);

      if (res.body == '1') {
        setState(() {
          getAllDocs_async();
        });
      }

      setState(() {});
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<AllDoc_model> ad = [];
  getAllDocs_async() async {
    ad = [];
    print("get all docs async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getAllDocs);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'all_docs': '1',
        'clinic_id': '0',
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      print(bdy[0]['clinic_name']);
      for (int i = 0; i < b.length; i++) {
        ad.add(
          AllDoc_model(
            ID: bdy[i]['ID'].toString(),
            branch_doc: '0',
            name: bdy[i]['Name'].toString(),
            mobno: bdy[i]['mobile_no'].toString(),
            img: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['doctor_img'].toString(),
            img2: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img1'].toString(),
            img3: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img2'].toString(),
            img4: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img3'].toString(),
            img5: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img4'].toString(),
            mail: bdy[i]['email_id'].toString(),
            pswd: bdy[i]['pswd'].toString(),
            speciality: bdy[i]['Speciality'].toString(),
            Degree: bdy[i]['Degree'].toString(),
            clinicID: bdy[i]['clinic_id'].toString(),
            available: bdy[i]['available'].toString(),
            rating: bdy[i]['Rating'].toString(),
            verified: bdy[i]['verified'].toString(),
            idImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['ID_proof'].toString(),
            CertImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['degree_certificate'].toString(),
            CouncilCertImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['medical_council_certificate'].toString(),
          ),
        );
      }
      setState(() {
        glb.Tdocs = b.length.toString();
        glb.Models.AllDocs_lst = ad;
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}
