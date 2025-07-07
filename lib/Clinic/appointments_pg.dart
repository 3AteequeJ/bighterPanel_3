import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Cards/NewAppointments_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class Appointments_pg extends StatefulWidget {
  const Appointments_pg({super.key});

  @override
  State<Appointments_pg> createState() => _Appointments_pgState();
}

List<String> filter = [
  'All',
  'In-Clinic',
  'Video',
  'Ongoing',
  'Completed',
  'Cancled',
];

class _Appointments_pgState extends State<Appointments_pg> {
  int InClinic_count = 0,
      video_count = 0,
      ongoing_count = 0,
      completed_count = 0,
      cancled_count = 0;

  final ScrollController _firstController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    getCount();
  }

  String filter_value = filter.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(7.sp),
        child: Column(
          children: [
            Txt(
              text: "All Appointments",
              fntWt: FontWeight.bold,
              size: 14,
              fontColour: Colours.RussianViolet,
            ),
            SizedBox(
              height: 1.37.h,
            ),
            Container(
              color: Colours.RosePink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Sizer.Pad),
                              child: Txt(
                                  text:
                                      "In-Clinic appointments: $InClinic_count"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Sizer.Pad),
                              child:
                                  Txt(text: "Video appointments: $video_count"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Sizer.Pad),
                              child: Txt(text: "Ongoing: $ongoing_count"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Sizer.Pad),
                              child: Txt(text: "Completed: $completed_count"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(Sizer.Pad),
                              child: Txt(text: "Cancled: $cancled_count"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  DropdownButton(
                    value: filter_value,
                    items: filter.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        filter_value = value!;
                      });
                    },
                  )
                ],
              ),
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
                      return NewAppointments_card(
                        appointment: glb.Models.appointments_lst[index],
                        filter: filter_value,
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  getCount() {
    for (int i = 0; i < glb.Models.appointments_lst.length; i++) {
      if (DateTime.parse(glb.Models.appointments_lst[i].dt_time)
              .isBefore(DateTime.now()) ||
          DateTime.parse(glb.Models.appointments_lst[i].dt_time)
              .isAtSameMomentAs(DateTime.now())) {
        setState(() {
          completed_count = completed_count + 1;
          glb.Models.appointments_lst[i].status = '1';
        });
      } else {
        if (glb.Models.appointments_lst[i].status == '0') {
          setState(() {
            ongoing_count = ongoing_count + 1;
          });
        } else if (glb.Models.appointments_lst[i].status == '1') {
          setState(() {
            completed_count = completed_count + 1;
          });
        } else if (glb.Models.appointments_lst[i].status == '2') {
          setState(() {
            cancled_count = cancled_count + 1;
          });
        }
      }

      if (glb.Models.appointments_lst[i].type == '0') {
        InClinic_count = InClinic_count + 1;
      } else if (glb.Models.appointments_lst[i].type == '1') {
        video_count = video_count + 1;
      }
    }
  }
}
