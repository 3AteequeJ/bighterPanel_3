import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final List<String> timeList = generateTimeList(8, 12);

  final Map<String, DateTime> timeMap = generateTimeMap(8, 12);
  final Map<String, DateTime> afternoon_timeMap = generateTimeMap(12, 17);
  final Map<String, DateTime> evening_timeMap = generateTimeMap(17, 22);
  List<String> myList = [];
  Map<String, DateTime> myMap = {};
  bool mor_bool = false;
  bool aft_bool = false;
  bool eve_bool = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(12.0.sp),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              mor_bool = !mor_bool;
                              aft_bool = false;
                              eve_bool = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: mor_bool
                                  ? Colours.nonPhoto_blue.withOpacity(.5)
                                  : Colors.grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colours.nonPhoto_blue),
                            ),
                            child: Center(child: Txt(text: "Morning")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              print(afternoon_timeMap);
                              mor_bool = false;
                              aft_bool = !aft_bool;
                              eve_bool = false;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: aft_bool
                                  ? Colours.HunyadiYellow.withOpacity(.5)
                                  : Colors.grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colours.HunyadiYellow),
                            ),
                            child: Center(child: Txt(text: "Afternoon")),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              mor_bool = false;
                              aft_bool = false;
                              eve_bool = !eve_bool;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: eve_bool
                                  ? Colours.purple.withOpacity(.5)
                                  : Colors.grey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colours.purple),
                            ),
                            child: Center(child: Txt(text: "Evening")),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colours.divider_grey,
                  ),
                  Visibility(
                    visible: mor_bool,
                    child: Expanded(
                      // height: 100,
                      // width: 100.w,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, childAspectRatio: 5),
                          itemCount: timeMap.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  print("time map = $timeMap");
                                  print(timeMap[index]);
                                  setState(() {
                                    if (myMap.containsKey(
                                        timeMap.keys.elementAt(index))) {
                                    } else {
                                      myMap[timeMap.keys.elementAt(index)] =
                                          timeMap.values.elementAt(index);
                                      List<MapEntry<String, DateTime>>
                                          sortedEntries = myMap.entries.toList()
                                            ..sort((a, b) =>
                                                a.value.compareTo(b.value));
                                      Map<String, DateTime> sortedMap =
                                          Map.fromEntries(sortedEntries);
                                      myMap = sortedMap;
                                      // myList.add(timeList[index]);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: myMap.keys.contains(
                                              timeMap.keys.elementAt(index))
                                          ? Colours.nonPhoto_blue
                                          : Colours.nonPhoto_blue
                                              .withOpacity(.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  constraints: BoxConstraints(maxWidth: 100),
                                  width: 100,
                                  child: Center(
                                    child: Txt(
                                      text: timeMap.keys
                                          .elementAt(index)
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Visibility(
                    visible: aft_bool,
                    child: Expanded(
                      // height: 100,
                      // width: 100.w,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, childAspectRatio: 5),
                          itemCount: afternoon_timeMap.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  print("time map = $afternoon_timeMap");
                                  print(afternoon_timeMap[index]);
                                  setState(() {
                                    if (myMap.containsKey(afternoon_timeMap.keys
                                        .elementAt(index))) {
                                    } else {
                                      myMap[afternoon_timeMap.keys
                                              .elementAt(index)] =
                                          afternoon_timeMap.values
                                              .elementAt(index);
                                      List<MapEntry<String, DateTime>>
                                          sortedEntries = myMap.entries.toList()
                                            ..sort((a, b) =>
                                                a.value.compareTo(b.value));
                                      Map<String, DateTime> sortedMap =
                                          Map.fromEntries(sortedEntries);
                                      myMap = sortedMap;
                                      // myList.add(timeList[index]);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: myMap.keys.contains(
                                              afternoon_timeMap.keys
                                                  .elementAt(index))
                                          ? Colors.amber
                                          : Colours.HunyadiYellow.withOpacity(
                                              .5),
                                      borderRadius: BorderRadius.circular(10)),
                                  constraints: BoxConstraints(maxWidth: 100),
                                  width: 100,
                                  child: Center(
                                    child: Txt(
                                      text: afternoon_timeMap.keys
                                          .elementAt(index)
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Visibility(
                    visible: eve_bool,
                    child: Expanded(
                      // height: 100,
                      // width: 100.w,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, childAspectRatio: 5),
                          itemCount: evening_timeMap.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  print("time map = $evening_timeMap");
                                  print(evening_timeMap[index]);
                                  setState(() {
                                    if (myMap.containsKey(evening_timeMap.keys
                                        .elementAt(index))) {
                                    } else {
                                      myMap[evening_timeMap.keys
                                              .elementAt(index)] =
                                          evening_timeMap.values
                                              .elementAt(index);
                                      List<MapEntry<String, DateTime>>
                                          sortedEntries = myMap.entries.toList()
                                            ..sort((a, b) =>
                                                a.value.compareTo(b.value));
                                      Map<String, DateTime> sortedMap =
                                          Map.fromEntries(sortedEntries);
                                      myMap = sortedMap;
                                      // myList.add(timeList[index]);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: myMap.keys.contains(evening_timeMap
                                              .keys
                                              .elementAt(index))
                                          ? Colours.purple
                                          : Colours.purple.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  constraints: BoxConstraints(maxWidth: 100),
                                  width: 100,
                                  child: Center(
                                    child: Txt(
                                      text: evening_timeMap.keys
                                          .elementAt(index)
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
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
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: 5),
                itemCount: myMap.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // print(timeList[index]);
                        // myList.add(timeList[index]);
                        setState(() {
                          print(timeMap.length);
                          myMap.remove(myMap.keys.elementAt(index));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10)),
                        constraints: BoxConstraints(maxWidth: 100),
                        width: 100,
                        child: Center(
                          child: Txt(text: myMap.keys.elementAt(index)),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
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
