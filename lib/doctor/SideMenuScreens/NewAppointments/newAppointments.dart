// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:bighter_panel/Cards/NewAppointments_card.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import '../../../Utilities/colours.dart';
import 'package:http/http.dart' as http;

class NewAppointments extends StatefulWidget {
  const NewAppointments({super.key});

  @override
  State<NewAppointments> createState() => _NewAppointmentsState();
}

List<String> filter = [
  'All',
  'In-Clinic',
  'Video',
  'Ongoing',
  'Completed',
  'Cancled',
];

class _NewAppointmentsState extends State<NewAppointments> {
  String filter_value = filter.first;
  int InClinic_count = 0,
      video_count = 0,
      ongoing_count = 0,
      completed_count = 0,
      cancled_count = 0;
  @override
  void initState() {
    // TODO: implement initState
    getCount();
    // getDocAppointments_async();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizer.Pad),
      child: Container(
        child: Column(
          children: [
            Txt(
              text: "Appointments",
              size: 18,
              fntWt: FontWeight.bold,
            ),
            //todo Statics container
            Container(
              color: Colours.RosePink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Txt(
                              text: "In-Clinic appointments: $InClinic_count"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Sizer.Pad),
                          child: Txt(text: "Video appointments: $video_count"),
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
                  DropdownButton(
                    value: filter_value,
                    items: filter.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Txt(
                          text: value,
                          fontColour: Colours.txt_white,
                        ),
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
            Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colours.green,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Txt(text: "In-Clinic"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colours.orange,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Txt(text: "Video"),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                // key: appointments_KEY,
                itemCount: glb.Models.appointments_lst.length,
                itemBuilder: (context, index) {
                  return NewAppointments_card(
                    am: glb.Models.appointments_lst[index],
                    filter: filter_value,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getCount() {
    for (int i = 0; i < glb.Models.appointments_lst.length; i++) {
      // if (DateTime.parse(glb.Models.appointments_lst[i].dt_time)
      //         .isBefore(DateTime.now()) ||
      //     DateTime.parse(glb.Models.appointments_lst[i].dt_time)
      //         .isAtSameMomentAs(DateTime.now())) {
      //   setState(() {
      //     completed_count = completed_count + 1;
      //     glb.Models.appointments_lst[i].status = '3';
      //   });
      // } else {
      //   if (glb.Models.appointments_lst[i].status == '0') {
      //     setState(() {
      //       ongoing_count = ongoing_count + 1;
      //     });
      //   } else if (glb.Models.appointments_lst[i].status == '1') {
      //     setState(() {
      //       completed_count = completed_count + 1;
      //     });
      //   } else if (glb.Models.appointments_lst[i].status == '2') {
      //     setState(() {
      //       cancled_count = cancled_count + 1;
      //     });
      //   }
      // }

      if (glb.Models.appointments_lst[i].status == '0') {
        setState(() {
          if (DateTime.parse(glb.Models.appointments_lst[i].dt_time)
                  .isBefore(DateTime.now()) ||
              DateTime.parse(glb.Models.appointments_lst[i].dt_time)
                      .isAtSameMomentAs(DateTime.now()) &&
                  glb.Models.appointments_lst[i].status == '0') {
            setState(() {
              completed_count = completed_count + 1;
              glb.Models.appointments_lst[i].status = '3';
            });
          } else {
            ongoing_count = ongoing_count + 1;
          }
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

      if (glb.Models.appointments_lst[i].type == '0') {
        InClinic_count = InClinic_count + 1;
      } else if (glb.Models.appointments_lst[i].type == '1') {
        video_count = video_count + 1;
      }
    }
  }
}
