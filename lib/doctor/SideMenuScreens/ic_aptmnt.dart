import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Cards/Appointments_card.dart';
import 'package:bighter_panel/Cards/allDocs_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/patientDets.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class IC_aptmnts extends StatefulWidget {
  const IC_aptmnts({super.key});

  @override
  State<IC_aptmnts> createState() => _IC_aptmntsState();
}

class _IC_aptmntsState extends State<IC_aptmnts> {
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
              text: "In-clinic appointments",
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
            // SizedBox(
            //   height: 1.37.h,
            // ),
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
                        typ: '0',
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
