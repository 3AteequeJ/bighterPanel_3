import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/Admin/SideMenuPages/doctors/unverifiedDoctors/UnverifiedDocDet.dart';

class UnverifiedDoc_card extends StatelessWidget {
  final AllDoc_model doctor;
  final int index;

  const UnverifiedDoc_card({
    super.key,
    required this.doctor,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Only show if doctor is unverified
    if (doctor.verified != '0') return const SizedBox.shrink();

    final isMobile = MediaQuery.of(context).size.width <= 600;
    final backgroundColor = index.isOdd
        ? Colours.blue.withOpacity(0.5)
        : Colours.orange.withOpacity(0.5);

    return InkWell(
      onTap: () => _navigateToDetail(context),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(2.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: isMobile
            ? _buildMobileLayout(context)
            : _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),
        SizedBox(width: 4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                text: doctor.name,
                fntWt: FontWeight.bold,
                size: 12.sp,
                overflow: TextOverflow.ellipsis,
                maxLn: 2,
              ),
              Txt(
                text: doctor.speciality,
                size: 10.sp,
                overflow: TextOverflow.ellipsis,
                maxLn: 1,
              ),
              Txt(
                text: doctor.Degree,
                size: 10.sp,
                fontColour: Colors.black45,
                overflow: TextOverflow.ellipsis,
                maxLn: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      text: doctor.name,
                      fntWt: FontWeight.bold,
                      size: 12.sp,
                      overflow: TextOverflow.ellipsis,
                      maxLn: 2,
                    ),
                    Txt(
                      text: doctor.speciality,
                      size: 10.sp,
                      overflow: TextOverflow.ellipsis,
                      maxLn: 1,
                    ),
                    Txt(
                      text: doctor.Degree,
                      size: 10.sp,
                      fontColour: Colors.black45,
                      overflow: TextOverflow.ellipsis,
                      maxLn: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 10.h,
      height: 10.h,
      child: Image.network(
        doctor.img,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset("assets/images/doc.png"),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UnverifiedDocDet(
          deg: doctor.Degree,
          mail: doctor.mail,
          mobno: doctor.mobno,
          name: doctor.name,
          sep: doctor.speciality,
          cert_img: doctor.CertImg,
          conCert_img: doctor.CouncilCertImg,
          doc_img: doctor.img,
          id_img: doctor.idImg,
          doc_id: doctor.ID,
        ),
      ),
    );
  }
}
