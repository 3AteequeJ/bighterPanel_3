import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Cards/Appointments_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class video_appointments extends StatefulWidget {
  const video_appointments({super.key});

  @override
  State<video_appointments> createState() => _video_appointmentsState();
}

class _video_appointmentsState extends State<video_appointments> {
  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(7.sp),
        child: Column(
          children: [
            Txt(
              text: "Video appointments",
              fntWt: FontWeight.bold,
              size: 14,
              fontColour: Colours.RussianViolet,
            ),
            SizedBox(
              height: 1.37.h,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colours.RosePink,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(0.55.w),
            //         ),
            //       ),
            //       onPressed: () {
            //         Navigator.pushNamed(context, RG.AddDoc_rt);
            //       },
            //       child: Row(
            //         children: [
            //           Txt(
            //             text: "Add new doctor",
            //             fontColour: Colours.txt_white,
            //           ),
            //           Icon(
            //             Iconsax.add,
            //             color: Colours.icn_white,
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 1.37.h,
            ),
            Expanded(
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
                        AM: glb.Models.appointments_lst.reversed
                            .toList()[index],
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
