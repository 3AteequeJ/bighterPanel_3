import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class VerifiedDocDets extends StatelessWidget {
  final String id;

  const VerifiedDocDets({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Txt(text: "Doctor Profile"),
        backgroundColor: Colours.HunyadiYellow,
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizer.h_10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(context),
              SizedBox(height: Sizer.h_10),
              _buildGallerySection(context),
              SizedBox(height: Sizer.h_10),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Txt(
                    text: "Delete",
                    fontColour: Colours.txt_white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.Red,
                    padding: EdgeInsets.symmetric(
                      vertical: Sizer.h_10,
                      horizontal: Sizer.w_20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    glb.ConfirmationBox(
                      context,
                      "Doctor and all his data will be removed.",
                      () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: Sizer.radius_10 * 3,
              backgroundColor: Colours.HunyadiYellow,
              backgroundImage: NetworkImage(getDocImg(id)),
            ),
            InkWell(
              onTap: () => _showImageDialog(context, getDocImg(id)),
              child: CircleAvatar(
                radius: Sizer.radius_10 / 2,
                backgroundColor: Colors.grey[300],
                child:
                    Icon(Icons.remove_red_eye_outlined, size: Sizer.h_10 * 2),
              ),
            ),
          ],
        ),
        SizedBox(width: Sizer.w_10),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Sizer.h_10 / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Name", getDocNM(id)),
                _buildInfoRow("Email", getDocEmail(id)),
                _buildInfoRow("Mobile", getDocMobno(id)),
                _buildInfoRow("Degree", getDocDeg(id)),
                _buildInfoRow("Speciality", getDocSpe(id)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizer.h_10 * 2),
      child: Row(
        children: [
          Txt(
            text: "$title: ",
          ),
          Expanded(child: Txt(text: value)),
        ],
      ),
    );
  }

  Widget _buildGallerySection(BuildContext context) {
    final images = [
      getDocImg2(id),
      getDocImg3(id),
      getDocImg4(id),
      getDocImg5(id),
    ];

    return Wrap(
      runSpacing: Sizer.h_10,
      spacing: Sizer.w_10 / 2,
      children: images.map((img) => DocImageViewer(imageUrl: img)).toList(),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}

class DocImageViewer extends StatelessWidget {
  final String imageUrl;

  const DocImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adaptive.w(25),
      height: Adaptive.h(40),
      decoration: BoxDecoration(
        color: Colours.HunyadiYellow.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Iconsax.image, size: Sizer.h_10 * 2),
              ),
            ),
          ),
          InkWell(
            onTap: () => _showImageDialog(context, imageUrl),
            child: Container(
              // height: Sizer.h_10,
              decoration: BoxDecoration(
                color: Colours.HunyadiYellow.withOpacity(0.6),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(Sizer.Pad / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(text: "View"),
                      SizedBox(width: Sizer.w_10 / 2),
                      Icon(Iconsax.image, size: Sizer.h_10 * 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}

String getDocNM(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).name;
String getDocEmail(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).mail;
String getDocMobno(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).mobno;
String getDocDeg(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).Degree;
String getDocSpe(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).speciality;
String getDocImg(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).img;
String getDocImg2(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).img2;
String getDocImg3(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).img3;
String getDocImg4(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).img4;
String getDocImg5(String id) =>
    glb.Models.AllDocs_lst.firstWhere((doc) => doc.ID == id).img5;
