import 'package:bighter_panel/Admin/SideMenuPages/doctors/VerifiedDoctors/VerifiedDocDets.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllDocs_card_new extends StatelessWidget {
  const AllDocs_card_new({super.key, required this.AD});
  final AllDoc_model AD;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => VerifiedDocDets(id: AD.ID)));
      },
      borderRadius: BorderRadius.circular(2.w),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 4.5.h,
              backgroundImage: NetworkImage(AD.img),
              backgroundColor: Colors.grey.shade100,
              onBackgroundImageError: (_, __) {},
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(
                    text: AD.name,
                    size: 12.sp,
                    fntWt: FontWeight.bold,
                    fontColour: Colours.RussianViolet,
                  ),
                  Txt(
                    text: AD.speciality,
                    size: 10.sp,
                    fontColour: Colors.black54,
                  ),
                  Txt(
                    text: AD.Degree,
                    size: 10.sp,
                    fontColour: Colors.black45,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 2.5.h, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
