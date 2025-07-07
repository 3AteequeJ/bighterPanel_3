import 'dart:math';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:math';

class ClinicDets_pg extends StatefulWidget {
  const ClinicDets_pg(
      {super.key, required this.clinicID, required String ClinicDets_pg});

  final String clinicID;

  @override
  State<ClinicDets_pg> createState() => _ClinicDets_pgState();
}

class _ClinicDets_pgState extends State<ClinicDets_pg> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  late String img1, img2, img3, img4, img5;

  @override
  void initState() {
    super.initState();
    nameController.text = getName(widget.clinicID);
    mobileController.text = getMobno(widget.clinicID);
    addressController.text = getAddrs(widget.clinicID);
    img1 = getImg1(widget.clinicID);
    img2 = getImg2(widget.clinicID);
    img3 = getImg3(widget.clinicID);
    img4 = getImg4(widget.clinicID);
    img5 = getImg5(widget.clinicID);
  }

  Widget buildImageTile(String imageUrl, VoidCallback onUpload) {
    return Container(
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
                "$imageUrl?cache_bust=${Random().nextInt(10000)}",
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Iconsax.image),
              ),
            ),
          ),
          InkWell(
            onTap: onUpload,
            child: Container(
              color: Colours.HunyadiYellow.withOpacity(0.6),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(text: "View"),
                  Icon(Iconsax.eye),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.RosePink,
        title: Txt(text: "Clinic Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Txt(
                text: "Clinic Profile Settings",
                fntWt: FontWeight.bold,
                size: 16,
                fontColour: Colours.RussianViolet,
              ),
            ),
            SizedBox(height: Sizer.h_50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 10.w,
                      backgroundColor: Colours.HunyadiYellow,
                      backgroundImage: NetworkImage(
                        "$img1?cache_bust=${Random().nextInt(10000)}",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // _pickImage("1", widget.clinicID);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Iconsax.eye),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Sizer.w_10),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Clinic Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Sizer.radius_10 / 5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: mobileController,
                              decoration: InputDecoration(
                                labelText: "Contact Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Sizer.radius_10 / 5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email ID",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Sizer.radius_10 / 5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                labelText: "Location",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      Sizer.radius_10 / 5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Sizer.h_50),
            Txt(text: "Clinic Images", size: 14, fontColour: Colours.txt_grey),
            Divider(color: Colours.divider_grey),
            Wrap(
              spacing: Sizer.w_10,
              runSpacing: Sizer.h_10,
              children: [
                buildImageTile(img2, () {/* Upload img2 */}),
                buildImageTile(img3, () {/* Upload img3 */}),
                buildImageTile(img4, () {/* Upload img4 */}),
                buildImageTile(img5, () {/* Upload img5 */}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String getName(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.name ?? "";
String getMobno(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.mobno ?? "";
String getAddrs(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.address ?? "";
String getImg1(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.img1 ?? "";
String getImg2(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.img2 ?? "";
String getImg3(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.img3 ?? "";
String getImg4(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.img4 ?? "";
String getImg5(String id) =>
    glb.Models.AllClinics_lst.firstWhere((c) => c.ID == id)?.img5 ?? "";
