import 'package:bighter_panel/Admin/SideMenuPages/doctors/VerifiedDoctors/doctors.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class Main_pg extends StatefulWidget {
  const Main_pg({super.key});

  @override
  State<Main_pg> createState() => _Main_pgState();
}

class _Main_pgState extends State<Main_pg> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Padding(
      padding: EdgeInsets.all(Sizer.Pad),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: Sizer.w_20 / 3,
          runSpacing: Sizer.h_10,
          children: [
            _DashboardCard(
              color: Colours.orange,
              image: "assets/images/inClinic.png",
              label: "Total Clinics",
              value: "${glb.Tclinics}",
              isMobile: isMobile,
            ),
            _DashboardCard(
              color: Colours.green,
              image: "assets/images/docs.png",
              label: "Total Doctors",
              value: "${glb.Tdocs}",
              isMobile: isMobile,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => allDocs_pg()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final Color color;
  final String image;
  final String label;
  final String value;
  final bool isMobile;
  final VoidCallback? onTap;

  const _DashboardCard({
    required this.color,
    required this.image,
    required this.label,
    required this.value,
    required this.isMobile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMobile ? 100.w : 26.04.w,
        height: Sizer.h_50 * 2.5,
        padding: EdgeInsets.all(Sizer.Pad / 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2.5.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: isMobile ? 20.w : Sizer.w_50 * 2,
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            SizedBox(width: Sizer.w_10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: label,
                    size: 14.sp,
                    fntWt: FontWeight.w500,
                    fontColour: Colors.white,
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                    child: Center(
                      child: Txt(
                        text: value,
                        fntWt: FontWeight.bold,
                        size: 16.sp,
                        fontColour: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
