import 'dart:convert';

import 'package:bighter_panel/Admin/Cards/AllAppointments_card.dart';
import 'package:bighter_panel/Cards/Appointments_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AppointmentAdmin_model.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class AllAppointments extends StatefulWidget {
  const AllAppointments({super.key});

  @override
  State<AllAppointments> createState() => _AllAppointmentsState();
}

List<String> filter = [
  'All',
  'In-Clinic',
  'Video',
  'Ongoing',
  'Completed',
  'Cancled',
];

List<String> DateFilter = ['Today', 'Select period'];

class _AllAppointmentsState extends State<AllAppointments> {
  String filter_value = filter.first;
  String dateFilter_value = DateFilter.first;

  String from_dt = glb.getDate_sys(DateTime.now().toString());
  String to_dt = glb.getDate_sys(DateTime.now().toString());
  List<DateTime?> _dialogCalendarPickerValue = [DateTime.now()];
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          children: [
            Txt(
              text: "All Appointments",
              size: 20,
              fntWt: FontWeight.bold,
            ),
            Container(
              // color: Colours.HunyadiYellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DropdownButton(
                        value: dateFilter_value,
                        items: DateFilter.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Txt(
                              text: value,
                              fontColour: Colours.txt_black,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            dateFilter_value = value!;
                          });
                        },
                      ),
                      Visibility(
                        visible: dateFilter_value == 'Select period',
                        child: currentWidth > 600
                            ? Row(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.grey),
                                          onPressed: () async {
                                            var frm_dt =
                                                await showCalendarDatePicker2Dialog(
                                              context: context,
                                              config:
                                                  CalendarDatePicker2WithActionButtonsConfig(),
                                              dialogSize: const Size(325, 400),
                                              value: _dialogCalendarPickerValue,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            );
                                            print(frm_dt);
                                            setState(() {
                                              from_dt = glb.getDate_sys(
                                                  frm_dt!.first.toString());
                                            });
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (BuildContext context) {
                                            //       return AlertDialog(
                                            //         content:

                                            //         DatePickerDialog(
                                            //           initialDate: DateTime.now(),
                                            //           initialEntryMode:
                                            //               DatePickerEntryMode.calendarOnly,
                                            //           firstDate: DateTime(1990),
                                            //           lastDate: DateTime(2050),

                                            //           onDatePickerModeChange: (value) {
                                            //             print(value);
                                            //           },
                                            //         ),
                                            //       );
                                            //     });
                                          },
                                          child: Txt(
                                              text: "From date: ${from_dt}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: Colors.grey),
                                            onPressed: () async {
                                              var t_dt =
                                                  await showCalendarDatePicker2Dialog(
                                                context: context,
                                                config:
                                                    CalendarDatePicker2WithActionButtonsConfig(),
                                                dialogSize:
                                                    const Size(325, 400),
                                                value:
                                                    _dialogCalendarPickerValue,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              );
                                              setState(() {
                                                to_dt = glb.getDate_sys(
                                                    t_dt!.first.toString());
                                              });
                                              print(to_dt);
                                              // showDialog(
                                              //     context: context,
                                              //     builder: (BuildContext context) {
                                              //       return AlertDialog(
                                              //         content:

                                              //         DatePickerDialog(
                                              //           initialDate: DateTime.now(),
                                              //           initialEntryMode:
                                              //               DatePickerEntryMode.calendarOnly,
                                              //           firstDate: DateTime(1990),
                                              //           lastDate: DateTime(2050),

                                              //           onDatePickerModeChange: (value) {
                                              //             print(value);
                                              //           },
                                              //         ),
                                              //       );
                                              //     });
                                            },
                                            child:
                                                Txt(text: "To date: ${to_dt}")),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Colors.grey),
                                          onPressed: () async {
                                            var frm_dt =
                                                await showCalendarDatePicker2Dialog(
                                              context: context,
                                              config:
                                                  CalendarDatePicker2WithActionButtonsConfig(),
                                              dialogSize: const Size(325, 400),
                                              value: _dialogCalendarPickerValue,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            );
                                            print(frm_dt);
                                            setState(() {
                                              from_dt = glb.getDate_sys(
                                                  frm_dt!.first.toString());
                                            });
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (BuildContext context) {
                                            //       return AlertDialog(
                                            //         content:

                                            //         DatePickerDialog(
                                            //           initialDate: DateTime.now(),
                                            //           initialEntryMode:
                                            //               DatePickerEntryMode.calendarOnly,
                                            //           firstDate: DateTime(1990),
                                            //           lastDate: DateTime(2050),

                                            //           onDatePickerModeChange: (value) {
                                            //             print(value);
                                            //           },
                                            //         ),
                                            //       );
                                            //     });
                                          },
                                          child: Txt(
                                              text: "From date: ${from_dt}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: Colors.grey),
                                            onPressed: () async {
                                              var t_dt =
                                                  await showCalendarDatePicker2Dialog(
                                                context: context,
                                                config:
                                                    CalendarDatePicker2WithActionButtonsConfig(),
                                                dialogSize:
                                                    const Size(325, 400),
                                                value:
                                                    _dialogCalendarPickerValue,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              );
                                              setState(() {
                                                to_dt = glb.getDate_sys(
                                                    t_dt!.first.toString());
                                              });
                                              print(to_dt);
                                              // showDialog(
                                              //     context: context,
                                              //     builder: (BuildContext context) {
                                              //       return AlertDialog(
                                              //         content:

                                              //         DatePickerDialog(
                                              //           initialDate: DateTime.now(),
                                              //           initialEntryMode:
                                              //               DatePickerEntryMode.calendarOnly,
                                              //           firstDate: DateTime(1990),
                                              //           lastDate: DateTime(2050),

                                              //           onDatePickerModeChange: (value) {
                                              //             print(value);
                                              //           },
                                              //         ),
                                              //       );
                                              //     });
                                            },
                                            child:
                                                Txt(text: "To date: ${to_dt}")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      DropdownButton(
                        value: filter_value,
                        items: filter
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Txt(
                              text: value,
                              fontColour: Colours.txt_black,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            filter_value = value!;
                          });
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            GetAllAppointments();
                          },
                          child: Txt(text: "Search"))
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colours.orange, width: 3),
                    ),
                  ),
                  child: Txt(text: "Video appointments"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colours.blue, width: 3),
                    ),
                  ),
                  child: Txt(text: "InClinic appointments"),
                )
              ],
            ),
            SizedBox(
              height: 60.h,
              child: glb.Models.appointments_admin_lst.length == 0
                  ? Center(
                      child: Txt(text: "No appointments"),
                    )
                  : ListView.builder(
                      itemCount: glb.Models.appointments_admin_lst.length,
                      itemBuilder: (context, index) {
                        return AdminAllAppointments_card(
                          am: glb.Models.appointments_admin_lst.reversed
                              .toList()[index],
                          filter: filter_value,
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }

  List<AppointAdmin_model> aam = [];
  GetAllAppointments() async {
    aam = [];
    // Uri url = Uri.parse(glb.API.baseURL + glb.API.get_all_appointments);
    Uri url = Uri.parse(glb.API.baseURL + "get_appointment_admin");
    print(url);
    var boody = {};
    if (dateFilter_value == 'Select period') {
      boody = {
        'day': '1',
        'from_dt': from_dt,
        'to_dt': to_dt,
      };
    } else {
      boody = {'day': '0'};
    }
    // print("boody = $boody");
    try {
      var res = await http.post(url, body: boody);
      print(res.body);
      // print("body hai >> ${res.body}");

      var bdy = jsonDecode(res.body);

      List list1 = bdy['one'];
      List list2 = bdy['two'];
      print("list1  = ${list1}");
      print("list2  = ${list2}");
      for (int i = 0; i < list1.length; i++) {
        aam.add(
          AppointAdmin_model(
            id: list1[i]['ID'].toString(),
            usr_id: list1[i]['user_id'].toString(),
            usr_nm: list1[i]['usr_nm'].toString(),
            usr_img: "${glb.API.baseURL}images/user_images/" +
                list1[i]['usr_img'].toString(),
            doc_id: list1[i]['doctor_id'].toString(),
            doc_nm: list1[i]['doc_nm'].toString(),
            doc_img: "${glb.API.baseURL}images/doctor_images/" +
                list1[i]['doc_img'].toString(),
            branch_doc: list1[i]['branch_doc'].toString(),
            typ: list1[i]['type'].toString(),
            branch_id: list1[i][''].toString(),
            clinic_id: list1[i]['clinic_id'].toString(),
            city: list1[i]['city'].toString(),
            state: list1[i]['state'].toString(),
            status: list1[i]['status'].toString(),
            address: list1[i]['address'].toString(),
            Date_time: list1[i]['timing'].toString(),
          ),
        );
      }

      for (int i = 0; i < list2.length; i++) {
        aam.add(AppointAdmin_model(
          id: list2[i]['ID'].toString(),
          usr_id: list2[i]['user_id'].toString(),
          usr_nm: list2[i]['usr_nm'].toString(),
          usr_img: "${glb.API.baseURL}images/user_images/" +
              list2[i]['usr_img'].toString(),
          doc_id: list2[i]['doctor_id'].toString(),
          doc_nm: list2[i]['doc_nm'].toString(),
          doc_img: "${glb.API.baseURL}images/doctor_images/" +
              list2[i]['doc_img'].toString(),
          branch_doc: list2[i]['branch_doc'].toString(),
          typ: list2[i]['type'].toString(),
          branch_id: list2[i][''].toString(),
          clinic_id: list2[i]['clinic_id'].toString(),
          city: list2[i]['city'].toString(),
          state: list2[i]['state'].toString(),
          status: list2[i]['status'].toString(),
          address: list2[i]['doc_address'].toString(),
          Date_time: list2[i]['timing'].toString(),
        ));
      }

      // for (int i = 0; i < b.length; i++) {
      //   aam.add(
      //     AppointAdmin_model(

      //     )
      //   );
      // }
      setState(() {
        glb.Models.appointments_admin_lst.clear();
        glb.Models.appointments_admin_lst = aam;
      });
    } catch (e) {}
  }
}
