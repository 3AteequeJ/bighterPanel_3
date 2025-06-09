import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class VideoAppointments_pg extends StatefulWidget {
  const VideoAppointments_pg({super.key});

  @override
  State<VideoAppointments_pg> createState() => _VideoAppointments_pgState();
}

class _VideoAppointments_pgState extends State<VideoAppointments_pg> {
  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(7.sp),
        child: Column(
          children: [
            Txt(
              text: "Video Appointments",
              fntWt: FontWeight.bold,
              size: 18,
              fontColour: Colours.RussianViolet,
            ),
            SizedBox(
              height: 1.37.h,
            ),
            Container(
              height: 80.h,
              // width: 90.w,
              color: const Color.fromRGBO(255, 248, 225, 1),
              child: Scrollbar(
                thickness: 20,
                thumbVisibility: true,
                trackVisibility: true,
                controller: _firstController,
                child: ListView.builder(
                    itemCount: glb.Models.appointments_lst.length,
                    controller: _firstController,
                    itemBuilder: (context, index) {
                      return AppointmentRequest_cards(
                        AM: glb.Models.appointments_lst[index],
                        
                        typ: '1',
                        
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
