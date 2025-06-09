import 'dart:convert';

import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/models/BookedAppointments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class NewSchedule extends StatefulWidget {
  const NewSchedule({super.key});

  @override
  State<NewSchedule> createState() => _NewScheduleState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
List<String> timeList = generateTimeList(8, 12);
Map<String, DateTime> timeMap = generateTimeMap(8, 12);
Map<String, DateTime> afternoon_timeMap = generateTimeMap(12, 17);
Map<String, DateTime> evening_timeMap = generateTimeMap(12, 23);

Map<String, DateTime> myMorningMap = {};
Map<String, DateTime> myAfternoonMap = {};
Map<String, DateTime> myEveningMap = {};

class _NewScheduleState extends State<NewSchedule> {
  String FromValue = timeMap.keys.first;
  String ToValue = evening_timeMap.keys.first;

  final TextEditingController colorController = TextEditingController();
  String fromTime = "", toTime = "";
  // IconLabel? selectedIcon;

  List<String> myList = [];
  Map<String, DateTime> myMap = {};
  bool mor_bool = false;
  bool aft_bool = false;
  bool eve_bool = false;

  var a1 = glb.usrTyp == '1'
      ? glb.doctor.available_from.split(":")
      : glb.clinicBranchDoc.available_from.split(":");
  var a2 = glb.usrTyp == '1'
      ? glb.doctor.available_to.split(":")
      : glb.clinicBranchDoc.available_to.split(":");
  List<DateTime> availableDates = [];
  late DateTime selectedDate;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      final today = DateTime.now();
      selectedDate = today;
      for (int i = 0; i <= 15; i++) {
        availableDates.add(today.add(Duration(days: i)));
      }

      print(timeMap);
      var list = timeMap.entries.toList();
      int idx = list.indexWhere((element) =>
          element.key ==
          glb.getDateTIme(
              "2024-04-30 ${glb.usrTyp == '1' ? glb.doctor.available_from : glb.clinicBranchDoc.available_from}"));
      FromValue = timeMap.keys.elementAt(idx);
      var list2 = evening_timeMap.entries.toList();
      int idx2 = list2.indexWhere((element) =>
          element.key ==
          glb.getDateTIme(
              "2024-04-30 ${glb.usrTyp == '1' ? glb.doctor.available_to : glb.clinicBranchDoc.available_to}"));
      ToValue = evening_timeMap.keys.elementAt(idx2);

      Map<String, DateTime> myTimingsMap = generateTimeMap1(
        int.parse(a1.first),
        int.parse(a1[1]),
        int.parse(a2.first),
        int.parse(
          a2[1],
        ),
      );
      // var list2 = evening_timeMap.entries.toList();
      // int idx2 = list.indexWhere((element) =>
      //     element.key ==
      //     glb.getDateTIme("2024-04-30 ${glb.doctor.available_to}"));
      // ToValue = evening_timeMap.keys.elementAt(idx2);
      // print(glb.getDateTIme("2024-04-30 ${glb.doctor.available_from}"));
      // print(glb.getDateTIme("2024-04-30 ${glb.doctor.available_to}"));
      // var b = glb.getDateTIme("2024-04-30 ${glb.doctor.available_to}");
      // ToValue = evening_timeMap[b].toString();

      // FromValue = glb.getDateTIme("2024-04-30 ${glb.doctor.available_from}");
      // ToValue = glb.getDateTIme("2024-04-30 ${glb.doctor.available_to}");
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          child: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          Txt(
                            text: "Clinic timing",
                            size: 18,
                            fntWt: FontWeight.bold,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Txt(text: "From"),
                              DropdownButton<String>(
                                value: FromValue,

                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    // print(value);
                                    // print(timeMap[value]);
                                    // print(glb.getDateTIme_sys(
                                    // timeMap[value].toString()));
                                    fromTime = glb.getDateTIme_sys(
                                        timeMap[value].toString());
                                    FromValue = value!;
                                    var list = timeMap.entries.toList();
                                    String b = glb.usrTyp == '1'
                                        ? glb
                                            .getDateTIme(
                                                "2024-04-30 ${glb.doctor.available_from}")
                                            .toString()
                                        : glb
                                            .getDateTIme(
                                                "2024-04-30 ${glb.clinicBranchDoc.available_from}")
                                            .toString();
                                    // int idx = list.indexWhere((element) =>
                                    //     element.key ==
                                    //     glb
                                    //         .getDateTIme(
                                    //             "2024-04-30 ${glb.doctor.available_from}")
                                    //         .toString());
                                    // 09:00 AM
                                    // 09:00 AM
                                    int idx = list.indexWhere((element) =>
                                        element.key.trim() == b.trim());
                                    // print("b = $b");
                                    // print(b.trim() == "9:00 AM");
                                    // print(glb
                                    //     .getDateTIme(
                                    //         "2024-04-30 ${glb.doctor.available_from}")
                                    //     .toString());
                                    // print("idx == $idx");
                                    // FromValue = timeMap.keys.elementAt(idx);
                                  });
                                },
                                items: timeMap.keys
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 400,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt(text: "TO"),
                                DropdownButton<String>(
                                  value: ToValue,

                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  // underline: Container(
                                  //   height: 2,
                                  //   color: Colors.deepPurpleAccent,
                                  // ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      ToValue = value!;
                                      // print(glb.getDateTIme(
                                      //     evening_timeMap[value].toString()));
                                      // print(glb.getDateTIme(
                                      //     "2024-04-30 ${glb.doctor.available_to}"));
                                      toTime = glb.getDateTIme_sys(
                                          evening_timeMap[value].toString());
                                      var a = glb.getDateTIme(
                                          evening_timeMap[value].toString());
                                      var b = glb.usrTyp == '1'
                                          ? glb.getDateTIme(
                                              "2024-04-30 ${glb.doctor.available_to}")
                                          : glb.getDateTIme(
                                              "2024-04-30 ${glb.clinicBranchDoc.available_to}");
                                      print(a == b);
                                    });
                                  },
                                  items: evening_timeMap.keys
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // fromTime =
                        //     glb.getDateTIme_sys(timeMap[FromValue].toString());
                        // toTime =
                        //     glb.getDateTIme_sys(timeMap[ToValue].toString());
                        String f = fromTime;
                        String t = toTime;
                        print("from = $f");
                        print("to = $t");
                        UpdateAvailableTime(f, t);
                        // print(
                        //     glb.getDateTIme(glb.doctor.available_from));
                        // print(glb.getDateTIme(glb.doctor.available_to));
                      },
                      child: Txt(text: "Set"),
                    )
                  ],
                ),
              ),
            ),
            Txt(text: "My timings"),
            Divider(
              color: Colours.divider_grey,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: availableDates.length,
                        itemBuilder: (context, index) {
                          final date = availableDates[index];
                          final isSelected = selectedDate == date;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = date;
                                print(selectedDate);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colours.HunyadiYellow
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('E dd').format(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // ? morning
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Txt(text: "Morning")),
                    Flexible(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: currentWidth > 600 ? 5 : 3,
                                  childAspectRatio: currentWidth > 600 ? 5 : 3),
                          itemCount: myMorningMap.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  var t = myMorningMap.values
                                      .elementAt(index)
                                      .toString()
                                      .split(".");

                                  print(getID(t[0]));

                                  if (searchTime(
                                          myMorningMap.keys.elementAt(index)) ==
                                      1) {
                                    glb.ConfirmationBox(context,
                                        "You want to unblock this slot?", () {
                                      UnBookslot(getID(t[0]));
                                    });
                                  } else {
                                    glb.ConfirmationBox(context,
                                        "You want to block this slot ?", () {
                                      var a = selectedDate.toString().isNotEmpty
                                          ? "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"
                                          : glb.getDate_sys(
                                              DateTime.now().toString());
                                      var b = glb.getDateTIme_sys(myMorningMap
                                          .values
                                          .elementAt(index)
                                          .toString());
                                      b = b.toString().trim();
                                      print("$a");
                                      print("$a $b:00");
                                      Bookslot(a, b);
                                    });
                                  }

                                  // print("time map = $myTimingsMap");
                                  // print(myTimingsMap[index]);
                                  // setState(() {
                                  //   if (myMap.containsKey(
                                  //       myTimingsMap.keys.elementAt(index))) {
                                  //   } else {
                                  //     myMap[myTimingsMap.keys.elementAt(index)] =
                                  //         myTimingsMap.values.elementAt(index);
                                  //     List<MapEntry<String, DateTime>> sortedEntries =
                                  //         myMap.entries.toList()
                                  //           ..sort(
                                  //               (a, b) => a.value.compareTo(b.value));
                                  //     Map<String, DateTime> sortedMap =
                                  //         Map.fromEntries(sortedEntries);
                                  //     myMap = sortedMap;
                                  //     // myList.add(timeList[index]);
                                  //   }
                                  // });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          // myMap.keys
                                          //         .contains(myTimingsMap.keys.elementAt(index))
                                          searchTime(myMorningMap.keys
                                                      .elementAt(index)) ==
                                                  1
                                              ? Colors.grey
                                              : Colours.HunyadiYellow
                                                  .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  constraints: BoxConstraints(maxWidth: 100),
                                  width: 100,
                                  child: Center(
                                    child: Txt(
                                      text: myMorningMap.keys
                                          .elementAt(index)
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    // ? afternoon
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Txt(text: "Afternoon")),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: currentWidth > 600 ? 5 : 3,
                                  childAspectRatio: currentWidth > 600 ? 5 : 3),
                          itemCount: myAfternoonMap.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  var t = myAfternoonMap.values
                                      .elementAt(index)
                                      .toString()
                                      .split(".");

                                  print(getID(t[0]));

                                  if (searchTime(myAfternoonMap.keys
                                          .elementAt(index)) ==
                                      1) {
                                    glb.ConfirmationBox(context,
                                        "You want to unblock this slot?", () {
                                      UnBookslot(getID(t[0]));
                                    });
                                  } else {
                                    glb.ConfirmationBox(context,
                                        "You want to block this slot ?", () {
                                      var a = selectedDate.toString().isNotEmpty
                                          ? "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"
                                          : glb.getDate_sys(
                                              DateTime.now().toString());
                                      var b = glb.getDateTIme_sys(myAfternoonMap
                                          .values
                                          .elementAt(index)
                                          .toString());
                                      b = b.toString().trim();
                                      print("$a");
                                      print("$a $b:00");
                                      Bookslot(a, b);
                                    });
                                  }

                                  // print("time map = $myTimingsMap");
                                  // print(myTimingsMap[index]);
                                  // setState(() {
                                  //   if (myMap.containsKey(
                                  //       myTimingsMap.keys.elementAt(index))) {
                                  //   } else {
                                  //     myMap[myTimingsMap.keys.elementAt(index)] =
                                  //         myTimingsMap.values.elementAt(index);
                                  //     List<MapEntry<String, DateTime>> sortedEntries =
                                  //         myMap.entries.toList()
                                  //           ..sort(
                                  //               (a, b) => a.value.compareTo(b.value));
                                  //     Map<String, DateTime> sortedMap =
                                  //         Map.fromEntries(sortedEntries);
                                  //     myMap = sortedMap;
                                  //     // myList.add(timeList[index]);
                                  //   }
                                  // });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          // myMap.keys
                                          //         .contains(myTimingsMap.keys.elementAt(index))
                                          searchTime(myAfternoonMap.keys
                                                      .elementAt(index)) ==
                                                  1
                                              ? Colors.grey
                                              : Colours.HunyadiYellow
                                                  .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  constraints: BoxConstraints(maxWidth: 100),
                                  width: 100,
                                  child: Center(
                                    child: Txt(
                                      text: myAfternoonMap.keys
                                          .elementAt(index)
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    //  ? evening
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Txt(text: "Evening")),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: currentWidth > 600 ? 5 : 3,
                                  childAspectRatio: currentWidth > 600 ? 5 : 3),
                          itemCount: myEveningMap.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  var t = myEveningMap.values
                                      .elementAt(index)
                                      .toString()
                                      .split(".");

                                  print(getID(t[0]));

                                  if (searchTime(
                                          myEveningMap.keys.elementAt(index)) ==
                                      1) {
                                    glb.ConfirmationBox(context,
                                        "You want to unblock this slot?", () {
                                      UnBookslot(getID(t[0]));
                                    });
                                  } else {
                                    glb.ConfirmationBox(context,
                                        "You want to block this slot ?", () {
                                      var a = selectedDate.toString().isNotEmpty
                                          ? "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"
                                          : selectedDate.toString().isNotEmpty
                                              ? "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"
                                              : glb.getDate_sys(
                                                  DateTime.now().toString());
                                      var b = glb.getDateTIme_sys(myEveningMap
                                          .values
                                          .elementAt(index)
                                          .toString());
                                      b = b.toString().trim();
                                      print("a == $a");
                                      print("b == $b");
                                      print("$a $b:00");
                                      Bookslot(a, b);
                                    });
                                  }

                                  // print("time map = $myTimingsMap");
                                  // print(myTimingsMap[index]);
                                  // setState(() {
                                  //   if (myMap.containsKey(
                                  //       myTimingsMap.keys.elementAt(index))) {
                                  //   } else {
                                  //     myMap[myTimingsMap.keys.elementAt(index)] =
                                  //         myTimingsMap.values.elementAt(index);
                                  //     List<MapEntry<String, DateTime>> sortedEntries =
                                  //         myMap.entries.toList()
                                  //           ..sort(
                                  //               (a, b) => a.value.compareTo(b.value));
                                  //     Map<String, DateTime> sortedMap =
                                  //         Map.fromEntries(sortedEntries);
                                  //     myMap = sortedMap;
                                  //     // myList.add(timeList[index]);
                                  //   }
                                  // });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          // myMap.keys
                                          //         .contains(myTimingsMap.keys.elementAt(index))
                                          searchTime(myEveningMap.keys
                                                      .elementAt(index)) ==
                                                  1
                                              ? Colors.grey
                                              : Colours.HunyadiYellow
                                                  .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  constraints: BoxConstraints(maxWidth: 100),
                                  width: 100,
                                  child: Center(
                                    child: Txt(
                                      text: myEveningMap.keys
                                          .elementAt(index)
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              // child: GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 5, childAspectRatio: 5),
              //     itemCount: myTimingsMap.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: InkWell(
              //           onTap: () {
              //             var t = myTimingsMap.values
              //                 .elementAt(index)
              //                 .toString()
              //                 .split(".");

              //             print(getID(t[0]));

              //             if (searchTime(myTimingsMap.keys.elementAt(index)) ==
              //                 1) {
              //               glb.ConfirmationBox(
              //                   context, "You want to unblock this slot?", () {
              //                 UnBookslot(getID(t[0]));
              //               });
              //             } else {
              //               glb.ConfirmationBox(
              //                   context, "You want to block this slot ?", () {
              //                 var a =
              //                     glb.getDate_sys(DateTime.now().toString());
              //                 var b = glb.getDateTIme_sys(myTimingsMap.values
              //                     .elementAt(index)
              //                     .toString());
              //                 b = b.toString().trim();
              //                 print("$a");
              //                 print("$a $b:00");
              //                 Bookslot(a, b);
              //               });
              //             }

              //             // print("time map = $myTimingsMap");
              //             // print(myTimingsMap[index]);
              //             // setState(() {
              //             //   if (myMap.containsKey(
              //             //       myTimingsMap.keys.elementAt(index))) {
              //             //   } else {
              //             //     myMap[myTimingsMap.keys.elementAt(index)] =
              //             //         myTimingsMap.values.elementAt(index);
              //             //     List<MapEntry<String, DateTime>> sortedEntries =
              //             //         myMap.entries.toList()
              //             //           ..sort(
              //             //               (a, b) => a.value.compareTo(b.value));
              //             //     Map<String, DateTime> sortedMap =
              //             //         Map.fromEntries(sortedEntries);
              //             //     myMap = sortedMap;
              //             //     // myList.add(timeList[index]);
              //             //   }
              //             // });
              //           },
              //           child: Container(
              //             decoration: BoxDecoration(
              //                 color:
              //                     // myMap.keys
              //                     //         .contains(myTimingsMap.keys.elementAt(index))
              //                     searchTime(myTimingsMap.keys
              //                                 .elementAt(index)) ==
              //                             1
              //                         ? Colors.grey
              //                         : Colours.HunyadiYellow.withOpacity(.5),
              //                 borderRadius: BorderRadius.circular(10)),
              //             constraints: BoxConstraints(maxWidth: 100),
              //             width: 100,
              //             child: Center(
              //               child: Txt(
              //                 text:
              //                     myTimingsMap.keys.elementAt(index).toString(),
              //               ),
              //             ),
              //           ),
              //         ),
              //       );
              //     }),
            ),
          ],
        ),
      )),
    );
  }

  UpdateAvailableTime(String from, String to) async {
    print("get book ");
    // Uri url = Uri.parse(glb.API.baseURL + "book_video_slot");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.updateAvailability);
    print(url);
    try {
      var res = await http.post(url, body: {
        'doc_id':
            '${glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id}',
        'branch_doc': '${glb.usrTyp == '1' ? '0' : '1'}',
        'available_from': "$from",
        'available_to': "$to",
        // "slot_time": "2024-04-29 09:30:00"
      });
      print(res.statusCode);
      // print("bodyy?? ${res.body}");
      // var bdy = jsonDecode(res.body);
      // List b = jsonDecode(res.body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");

        setState(() async {
          if (glb.usrTyp == '1') {
            await login_async();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocHome_pg(
                          pgNO: 2,
                        )));
            // setState(() {
            //   print(
            //       "previous: ${glb.doctor.available_from} - ${glb.doctor.available_to}");
            //   glb.doctor.available_from = from + ":00";
            //   glb.doctor.available_to = to + ":00";
            //   print("after: $from - $to");
            // });
          } else {
            await clinicLogin_async();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => clinicHome_pg(
                          pgNO: 5,
                        )));
            // setState(() {
            //   print(
            //       "previous: ${glb.clinicBranchDoc.available_from} - ${glb.clinicBranchDoc.available_to}");
            //   glb.clinicBranchDoc.available_from = from + ":00";
            //   glb.clinicBranchDoc.available_to = to + ":00";
            //   print("after: $from - $to");
            // });
          }
        });
      }
      // print(bdy);
      // print(b.length);
    } catch (e) {
      print("Exception => $e");
    }
  }

  Bookslot(String dt, String tm) async {
    print("get book ");
    Uri url = Uri.parse(glb.API.baseURL + "book_video_slot");
    // Uri url = Uri.parse(glb.API.baseURL + "get_video_slot");
    print(url);
    print("dt = $dt");
    print("tm = $tm");
    try {
      var res = await http.post(url, body: {
        'doctor_id':
            '${glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id}',
        'branch_doc': '${glb.usrTyp == '1' ? '0' : '1'}',
        'date': "$dt",
        "slot_time": "$dt " + "$tm:00"
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        glb.SuccessToast(context, "Done");
        getBookedVideoAppointments();
      }
      print(bdy);
      print(b.length);
    } catch (e) {
      print("Exception => $e");
    }
  }

  UnBookslot(
    String id,
  ) async {
    print("get book ");
    Uri url = Uri.parse(glb.API.baseURL + "del_video_slot");
    // Uri url = Uri.parse(glb.API.baseURL + "get_video_slot");
    print(url);
    try {
      var res = await http.post(url, body: {
        'ID': '$id',
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        glb.SuccessToast(context, "Done");
        getBookedVideoAppointments();
      }
      print(bdy);
      print(b.length);
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<BookedAppointments_model> bam = [];
  getBookedVideoAppointments() async {
    bam = [];
    print("get book ");
    // Uri url = Uri.parse(glb.API.baseURL + "book_video_slot");
    Uri url = Uri.parse(glb.API.baseURL + "get_video_slot");
    print(url);
    try {
      var res = await http.post(url, body: {
        'doctor_id':
            '${glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id}',
        'date': "${glb.getDate_sys(DateTime.now().toString())}",
        'branch_doc': '${glb.usrTyp == '1' ? '0' : '1'}',
        // "slot_time": "2024-04-29 09:30:00"
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      for (int i = 0; i < b.length; i++) {
        bam.add(BookedAppointments_model(
            ID: bdy[i]['id'].toString(), time: bdy[i]['slot_time'].toString()));
      }
      setState(() {
        glb.Models.BookedAppointments_lst = bam;
      });
      print(bdy);
      print(b.length);
    } catch (e) {
      print("Exception => $e");
    }
  }

  login_async() async {
    print("Login async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.login);
    if (glb.usrTyp == '2') {
      url = Uri.parse(glb.API.baseURL + glb.API.Clogin);
    } else if (glb.usrTyp == '1') {
      url = Uri.parse(glb.API.baseURL + glb.API.Dlogin);
    }
    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          // 'data': '123456789',
          'data': '${glb.doctor.mobile_no}',
        },
      );
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      print(bdy);
      if (bdy.length == 0) {
        glb.errorToast(context, "Account not found\nRegister to get started");
        Navigator.pop(context);
      }
      if (glb.usrTyp == '2') {
        setState(() {
          glb.clinic.clinic_id = bdy[0]['ID'].toString();
          glb.clinic.clinic_name = bdy[0]['clinic_name'].toString();
          glb.clinic.contact_no = bdy[0]['mobile_no'].toString();
          glb.clinic.pswd = bdy[0]['pswd'].toString();
          glb.clinic.email_id = bdy[0]['email_id'].toString();
          glb.clinic.address = bdy[0]['address'].toString();
          glb.clinic.img1 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img1'].toString();
          glb.clinic.img2 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img2'].toString();
          glb.clinic.img3 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img3'].toString();
          glb.clinic.img4 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img4'].toString();
          glb.clinic.img5 = "${glb.API.baseURL}images/clinic_images/" +
              bdy[0]['img5'].toString();
        });
        if (glb.doctor.pswd == glb.clinic.pswd) {
        } else {
          glb.errorToast(context, "Wrong password");
          Navigator.pop(context);
        }
      } else if (glb.usrTyp == '1') {
        print("Verified hai kya? ${bdy[0]['verified'].toString()}");
        if (bdy[0]['verified'].toString() == '0') {
          Navigator.pop(context);
          glb.ConfirmationBox(context, "You are not yet verified", () {
            Navigator.pop(context);
          });
        } else {
          setState(
            () {
              glb.doctor.doc_id = bdy[0]['ID'].toString();
              glb.doctor.name = bdy[0]['Name'].toString();
              glb.doctor.mobile_no = bdy[0]['mobile_no'].toString();
              glb.doctor.email = bdy[0]['email_id'].toString();
              glb.doctor.pswd = bdy[0]['pswd'].toString();
              glb.doctor.speciality = bdy[0]['Speciality'].toString();
              glb.doctor.Degree = bdy[0]['Degree'].toString();
              glb.doctor.clinic_id = bdy[0]['clinic_id'].toString();
              glb.doctor.available = bdy[0]['available'].toString();
              glb.doctor.rating = bdy[0]['Rating'].toString();
              glb.doctor.img = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['doctor_img'].toString();
              glb.doctor.img1 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img1'].toString();
              glb.doctor.img2 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img2'].toString();
              glb.doctor.img3 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img3'].toString();
              glb.doctor.img4 = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['img4'].toString();
              glb.doctor.IDProof = "${glb.API.baseURL}images/doctor_images/" +
                  bdy[0]['ID_proof'].toString();
              glb.doctor.degree_certificate =
                  "${glb.API.baseURL}images/doctor_images/" +
                      bdy[0]['degree_certificate'].toString();
              glb.doctor.medical_council_certificate =
                  "${glb.API.baseURL}images/doctor_images/" +
                      bdy[0]['medical_council_certificate'].toString();
              glb.doctor.available_from = bdy[0]['available_from'].toString();
              glb.doctor.available_to = bdy[0]['available_to'].toString();
              glb.doctor.address = bdy[0]['address'].toString();
            },
          );
        }
      }
    } catch (e) {
      print("Exception => $e");
    }
  }

  clinicLogin_async() async {
    print("clinic login async");
    Uri url = Uri.parse(glb.API.baseURL + "getCliniLogin");
    try {
      var res = await http.post(
        url,
        body: {
          'user_name': glb.clinicBranchDoc.usr_nm,
        },
      );

      // print("stat = ${res.statusCode}");
      // print("body = ${res.body}");
      print("?? ${res.body}");
      if (res.body.isEmpty || res.body.toString() == "none") {
        Navigator.pop(context);
        glb.errorToast(context, "User not found");
      } else {
        var bdy = jsonDecode(res.body);
        var body = bdy[0];
        if (glb.clinicBranchDoc.pswd == body['password'].toString()) {
          glb.clinicRole = bdy[0]['role'].toString();
          if (bdy[0]['role'].toString() == '0') {
            glb.clinic.clinic_id = body['ID'].toString();
            glb.clinic.usr_nm = body['user_name'].toString();
            glb.clinic.clinic_name = body['clinic_name'].toString();
            glb.clinic.contact_no = body['mobile_no'].toString();
            glb.clinic.pswd = body['password'].toString();
            glb.clinic.email_id = body['email_id'].toString();
            glb.clinic.address = body['address'].toString();
            glb.clinic.img1 = "${glb.API.baseURL}images/clinic_images/" +
                body['img1'].toString();
            glb.clinic.img2 = "${glb.API.baseURL}images/clinic_images/" +
                body['img2'].toString();
            glb.clinic.img3 = "${glb.API.baseURL}images/clinic_images/" +
                body['img3'].toString();
            glb.clinic.img4 = "${glb.API.baseURL}images/clinic_images/" +
                body['img4'].toString();
            glb.clinic.img5 = "${glb.API.baseURL}images/clinic_images/" +
                body['img5'].toString();
          } else if (bdy[0]['role'].toString() == '1') {
            glb.clinicBranch.branch_id = body['branch_id'].toString();
            glb.clinicBranch.usr_nm = body['user_name'].toString();
            glb.clinicBranch.pswd = body['password'].toString();
            glb.clinicBranch.credentials_id = body['credentials_id'].toString();
            glb.clinicBranch.clinic_name = body['name'].toString();
            glb.clinicBranch.contact_no = body['mob_no'].toString();
            glb.clinicBranch.email_id = body['email_id'].toString();
            glb.clinicBranch.clinicAddress = body['address'].toString();

            glb.clinicBranch.img1 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img1'].toString();
            glb.clinicBranch.img2 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img2'].toString();
            glb.clinicBranch.img3 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img3'].toString();
            glb.clinicBranch.img4 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img4'].toString();
            glb.clinicBranch.img5 = "${glb.API.baseURL}images/branch_images/" +
                bdy[0]['img5'].toString();

            print("Here");
          } else if (bdy[0]['role'].toString() == '2') {
            setState(() {
              glb.clinicBranchDoc.doc_id = body['id'].toString();
              glb.clinicBranchDoc.usr_nm = body['user_name'].toString();
              glb.clinicBranchDoc.pswd = body['password'].toString();
              glb.clinicBranchDoc.credentials_id =
                  body['credentials_id'].toString();
              glb.clinicBranchDoc.branch_id = body['branch_id'].toString();
              glb.clinicBranchDoc.name = body['name'].toString();
              glb.clinicBranchDoc.mobile_no = body['mob_no'].toString();
              glb.clinicBranchDoc.email = body['email'].toString();
              glb.clinicBranchDoc.Degree = body['degree'].toString();
              glb.clinicBranchDoc.speciality = body['speciality'].toString();
              glb.clinicBranchDoc.img1 =
                  "${glb.API.baseURL}images/branchDoc_images/" +
                      bdy[0]['img1'].toString();
              glb.clinicBranchDoc.img2 =
                  "${glb.API.baseURL}images/branchDoc_images/" +
                      bdy[0]['img2'].toString();
              glb.clinicBranchDoc.img3 =
                  "${glb.API.baseURL}images/branchDoc_images/" +
                      bdy[0]['img3'].toString();
              glb.clinicBranchDoc.img4 =
                  "${glb.API.baseURL}images/branchDoc_images/" +
                      bdy[0]['img4'].toString();
              glb.clinicBranchDoc.img5 =
                  "${glb.API.baseURL}images/branchDoc_images/" +
                      bdy[0]['img5'].toString();
              glb.clinicBranchDoc.address = bdy[0]['branch_address'].toString();
              glb.clinicBranchDoc.available_from =
                  bdy[0]['available_from'].toString();
              glb.clinicBranchDoc.available_to =
                  bdy[0]['available_to'].toString();
            });
          }
        } else {
          glb.errorToast(context, "Wrong password");
        }
      }
    } catch (e) {}
  }
}

searchTime(String key) {
  var r = 0;

  for (int i = 0; i < glb.Models.BookedAppointments_lst.length; i++) {
    var a = glb.getDateTIme(glb.Models.BookedAppointments_lst[i].time);

    if (a == key) {
      print("kwy " + key);
      print("a = $a");
      r = 1;
      break;
    }
  }
  return r;
}

getID(String key) {
  print("getting id");
  var a = "";
  print(key);
  for (int i = 0; i < glb.Models.BookedAppointments_lst.length; i++) {
    print(glb.Models.BookedAppointments_lst[i].time);
    if (key == glb.Models.BookedAppointments_lst[i].time) {
      print("here");
      a = glb.Models.BookedAppointments_lst[i].ID;
      print(a);
      break;
    }
  }
  return a;
}

List<String> generateTimeList(int st, int et) {
  List<String> timeList = [];
  DateTime startTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, st, 0);
  DateTime endTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, et, 0);

  while (startTime.isBefore(endTime)) {
    timeList.add(DateFormat('h:mm a').format(startTime));
    startTime = startTime.add(Duration(minutes: 30));
  }

  return timeList;
}

Map<String, DateTime> generateTimeMap(int st, int et) {
  Map<String, DateTime> timeList = {};
  DateTime startTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, st, 0);
  DateTime endTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, et, 0);

  while (startTime.isBefore(endTime)) {
    timeList[DateFormat('h:mm a').format(startTime)] = startTime;

    startTime = startTime.add(Duration(minutes: 30));
  }

  return timeList;
}

Map<String, DateTime> generateTimeMap1(
  int st,
  int sm,
  int et,
  int em,
) {
  Map<String, DateTime> timeList = {};
  DateTime startTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, st, sm);
  DateTime endTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, et, em);

  while (startTime.isBefore(endTime.add(Duration(minutes: 30)))) {
    timeList[DateFormat('h:mm a').format(startTime)] = startTime;
    if (startTime.hour < 12) {
      myMorningMap[DateFormat('h:mm a').format(startTime)] = startTime;
    } else if (startTime.hour >= 12 && startTime.hour < 17) {
      myAfternoonMap[DateFormat('h:mm a').format(startTime)] = startTime;
    } else if (startTime.hour >= 17) {
      myEveningMap[DateFormat('h:mm a').format(startTime)] = startTime;
    }
    startTime = startTime.add(Duration(minutes: 30));
  }

  return timeList;
}
