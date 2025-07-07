import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AppointmentAdmin_model.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class AdminAllAppointments_card extends StatelessWidget {
  const AdminAllAppointments_card({
    super.key,
    required this.am,
    required this.filter,
  });

  final AppointAdmin_model am;
  final String filter;

  bool get isVisible {
    switch (filter) {
      case 'All':
        return true;
      case 'Video':
        return am.typ == '1';
      case 'In-Clinic':
        return am.typ == '0';
      case 'Ongoing':
        return am.status == '0';
      case 'Cancled':
        return am.status == '2';
      case 'Completed':
        return am.status == '1';
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        height: Sizer.h_50 * 2,
        decoration: BoxDecoration(
          color: am.typ == '0'
              ? Colours.blue.withOpacity(0.5)
              : Colours.orange.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // 👤 User Info
            _circularImageTextColumn(
              imageUrl: am.usr_img,
              name: am.usr_nm,
              label: "",
            ),

            const VerticalDivider(width: 12),

            // 🩺 Doctor Info
            _circularImageTextColumn(
              imageUrl: am.doc_img,
              name: am.doc_nm,
              label: am.address.replaceAll('///', ', '),
              isDoctor: true,
            ),

            const Spacer(),

            // 🏥 Clinic and Time Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Txt(
                  text: glb.getDateTIme(am.Date_time),
                ),
                SizedBox(height: 0.5.h),
                Txt(
                  text: glb.getDate(am.Date_time),
                ),
                // SizedBox(height: 0.5.h),
                // Txt(
                //   text: am.Date_time,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circularImageTextColumn({
    required String imageUrl,
    required String name,
    required String label,
    bool isDoctor = false,
  }) {
    return Row(
      children: [
        Container(
          height: 10.h,
          width: 10.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            image: imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl.isEmpty
              ? Icon(Icons.person, size: 30.sp, color: Colors.grey[700])
              : null,
        ),
        SizedBox(width: 2.w),
        SizedBox(
          width: isDoctor ? 30.w : 20.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Txt(
                text: name.isNotEmpty ? name : "N/A",
              ),
              if (label.isNotEmpty)
                Txt(
                  text: label,
                  size: 14,
                  maxLn: 2,
                ),
            ],
          ),
        ),
      ],
    );
  }

  String getClinicNM(String clinic_id) {
    for (var clinic in glb.Models.AllClinics_lst) {
      if (clinic.ID == clinic_id) return clinic.name;
    }
    return "";
  }
}
