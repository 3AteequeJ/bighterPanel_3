import 'package:bighter_panel/Admin/SideMenuPages/Clinic_pages/clinic_dets_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllClinics_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class AllClinicsCard extends StatelessWidget {
  final AllClinics_model clinic;

  const AllClinicsCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    final imageUrl = getClinicImage(clinic.ID);

    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colours.divider_grey),
            left: BorderSide(width: 1.w, color: Colours.orange),
          ),
        ),
        padding: EdgeInsets.all(8.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: isMobile ? 10.w : 3.w,
              backgroundImage: NetworkImage(imageUrl),
              onBackgroundImageError: (_, __) =>
                  const AssetImage("assets/images/clinic.png"),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(text: clinic.name, fntWt: FontWeight.bold),
                  Txt(text: clinic.address, size: 10),
                  SizedBox(height: 1.h),
                  Row(
                    children: List.generate(5,
                        (_) => Icon(Icons.star, size: 16, color: Colors.amber)),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.nonPhoto_blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (glb.usrTyp == "0") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ClinicDets_pg(
                        ClinicDets_pg: clinic.ID,
                        clinicID: clinic.ID,
                      ),
                    ),
                  );
                }
              },
              child: Txt(text: "Details"),
            ),
          ],
        ),
      ),
    );
  }
}

String getClinicImage(String clinicID) {
  return glb.Models.AllClinics_lst
      .firstWhere(
        (clinic) => clinic.ID == clinicID,
        orElse: () => AllClinics_model(
            img1: "assets/images/clinic.png",
            ID: "",
            name: "",
            address: "",
            cityID: '',
            mobno: '',
            password: '',
            img2: '',
            img3: '',
            img4: '',
            img5: ''),
      )
      .img1;
}
