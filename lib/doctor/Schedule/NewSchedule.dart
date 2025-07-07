import 'dart:convert';

import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/models/BookedAppointments_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class NewSchedule extends StatefulWidget {
  const NewSchedule({super.key});

  @override
  State<NewSchedule> createState() => _NewScheduleState();
}

// Global time maps
Map<String, DateTime> timeMap = generateTimeMap(8, 12);
Map<String, DateTime> afternoonTimeMap = generateTimeMap(12, 17);
Map<String, DateTime> eveningTimeMap = generateTimeMap(12, 23);

Map<String, DateTime> myMorningMap = {};
Map<String, DateTime> myAfternoonMap = {};
Map<String, DateTime> myEveningMap = {};

class _NewScheduleState extends State<NewSchedule> {
  late String fromValue;
  late String toValue;

  String fromTime = "";
  String toTime = "";

  late DateTime selectedDate;
  bool isLoading = false;
  List<BookedAppointments_model> bookedAppointments = [];

  late List<String> availableFromHours;
  late List<String> availableToHours;
  late List<DateTime> availableDates;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    final today = DateTime.now();
    selectedDate = today;
    availableDates =
        List.generate(16, (index) => today.add(Duration(days: index)));

    // Initialize time values
    fromValue = timeMap.keys.first;
    toValue = eveningTimeMap.keys.first;

    // Get available hours from global data
    final availableFrom = glb.usrTyp == '1'
        ? glb.doctor.available_from.split(":")
        : glb.clinicBranchDoc.available_from.split(":");
    final availableTo = glb.usrTyp == '1'
        ? glb.doctor.available_to.split(":")
        : glb.clinicBranchDoc.available_to.split(":");

    availableFromHours = availableFrom;
    availableToHours = availableTo;

    _setInitialTimeValues();
    _generateMyTimingsMap();
    _loadBookedAppointments();
  }

  void _setInitialTimeValues() {
    try {
      final fromTimeStr = glb.getDateTIme(
          "2024-04-30 ${glb.usrTyp == '1' ? glb.doctor.available_from : glb.clinicBranchDoc.available_from}");
      final toTimeStr = glb.getDateTIme(
          "2024-04-30 ${glb.usrTyp == '1' ? glb.doctor.available_to : glb.clinicBranchDoc.available_to}");

      // Find matching time values
      final fromIndex =
          timeMap.keys.toList().indexWhere((key) => key == fromTimeStr);
      final toIndex =
          eveningTimeMap.keys.toList().indexWhere((key) => key == toTimeStr);

      if (fromIndex != -1) fromValue = timeMap.keys.elementAt(fromIndex);
      if (toIndex != -1) toValue = eveningTimeMap.keys.elementAt(toIndex);
    } catch (e) {
      print("Error setting initial time values: $e");
    }
  }

  void _generateMyTimingsMap() {
    final startHour = int.tryParse(availableFromHours.first) ?? 8;
    final startMinute = int.tryParse(
            availableFromHours.length > 1 ? availableFromHours[1] : "0") ??
        0;
    final endHour = int.tryParse(availableToHours.first) ?? 17;
    final endMinute =
        int.tryParse(availableToHours.length > 1 ? availableToHours[1] : "0") ??
            0;

    generateTimeMap1(startHour, startMinute, endHour, endMinute);
  }

  Future<void> _loadBookedAppointments() async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(glb.API.baseURL + "get_video_slot"),
        body: {
          'doctor_id': glb.usrTyp == '1'
              ? glb.doctor.doc_id
              : glb.clinicBranchDoc.doc_id,
          'date': DateFormat('yyyy-MM-dd').format(selectedDate),
          'branch_doc': glb.usrTyp == '1' ? '0' : '1',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          bookedAppointments = data
              .map((item) => BookedAppointments_model(
                    ID: item['id'].toString(),
                    time: item['slot_time'].toString(),
                  ))
              .toList();
          glb.Models.BookedAppointments_lst = bookedAppointments;
        });
      }
    } catch (e) {
      print("Error loading appointments: $e");
      glb.errorToast(context, "Failed to load appointments");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading...", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 3.h),
                _buildClinicTimingCard(),
                SizedBox(height: 3.h),
                _buildScheduleCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Schedule Management",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Manage your availability and time slots",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicTimingCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: Colours.HunyadiYellow, size: 24),
                SizedBox(width: 2.w),
                Text(
                  "Clinic Timing",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            _buildResponsiveTimeSelectors(),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updateAvailableTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.HunyadiYellow,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  "Update Timing",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveTimeSelectors() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Desktop/Tablet layout
          return Row(
            children: [
              Expanded(
                  child: _buildTimeSelector(
                      "From", fromValue, timeMap, _onFromTimeChanged)),
              SizedBox(width: 4.w),
              Expanded(
                  child: _buildTimeSelector(
                      "To", toValue, eveningTimeMap, _onToTimeChanged)),
            ],
          );
        } else {
          // Mobile layout
          return Column(
            children: [
              _buildTimeSelector(
                  "From", fromValue, timeMap, _onFromTimeChanged),
              SizedBox(height: 2.h),
              _buildTimeSelector(
                  "To", toValue, eveningTimeMap, _onToTimeChanged),
            ],
          );
        }
      },
    );
  }

  Widget _buildTimeSelector(String label, String value,
      Map<String, DateTime> timeMap, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 20),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              onChanged: onChanged,
              items: timeMap.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        height: 140.h,
        child: Column(
          children: [
            _buildScheduleHeader(),
            _buildDateSelector(),
            Expanded(child: _buildTimeSlots()),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Colours.HunyadiYellow, size: 20),
          SizedBox(width: 2.w),
          Text(
            "My Schedule",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colours.HunyadiYellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                DateFormat('MMM d, yyyy').format(selectedDate),
                style: TextStyle(
                  color: Colours.HunyadiYellow,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      height: 10.h,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        itemCount: availableDates.length,
        itemBuilder: (context, index) {
          final date = availableDates[index];
          final isSelected = selectedDate.day == date.day &&
              selectedDate.month == date.month &&
              selectedDate.year == date.year;
          final isToday = date.day == DateTime.now().day &&
              date.month == DateTime.now().month &&
              date.year == DateTime.now().year;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              _loadBookedAppointments();
            },
            child: Container(
              // height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: isSelected ? Colours.HunyadiYellow : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isToday ? Colours.HunyadiYellow : Colors.grey.shade300,
                  width: isToday ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    DateFormat('dd').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlots() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (myMorningMap.isNotEmpty) ...[
            _buildTimeSlotSection("Morning", myMorningMap, Icons.wb_sunny),
            SizedBox(height: 3.h),
          ],
          if (myAfternoonMap.isNotEmpty) ...[
            _buildTimeSlotSection(
                "Afternoon", myAfternoonMap, Icons.wb_sunny_outlined),
            SizedBox(height: 3.h),
          ],
          if (myEveningMap.isNotEmpty) ...[
            _buildTimeSlotSection("Evening", myEveningMap, Icons.nights_stay),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeSlotSection(
      String title, Map<String, DateTime> timeMap, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 2.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 5 : 3;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 2.5,
                crossAxisSpacing: 2.w,
                mainAxisSpacing: 1.h,
              ),
              itemCount: timeMap.length,
              itemBuilder: (context, index) => _buildTimeSlot(timeMap, index),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeSlot(Map<String, DateTime> timeMap, int index) {
    final timeKey = timeMap.keys.elementAt(index);
    final isBooked = _isTimeSlotBooked(timeKey);

    return InkWell(
      onTap: () => _handleTimeSlotTap(timeMap, index),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: isBooked
              ? Colors.grey[200]
              : Colours.HunyadiYellow.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isBooked
                ? Colors.grey[400]!
                : Colours.HunyadiYellow.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            timeKey,
            style: TextStyle(
              color: isBooked ? Colors.grey[600] : Colours.HunyadiYellow,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Event handlers
  void _onFromTimeChanged(String? value) {
    if (value != null) {
      setState(() {
        fromValue = value;
        fromTime = glb.getDateTIme_sys(timeMap[value].toString());
      });
    }
  }

  void _onToTimeChanged(String? value) {
    if (value != null) {
      setState(() {
        toValue = value;
        toTime = glb.getDateTIme_sys(eveningTimeMap[value].toString());
      });
    }
  }

  void _updateAvailableTime() {
    final from = fromTime;
    final to = toTime;
    print("Updating time from $from to $to");
    _updateAvailableTimeAPI(from, to);
  }

  void _handleTimeSlotTap(Map<String, DateTime> timeMap, int index) {
    final timeKey = timeMap.keys.elementAt(index);
    final timeValue = timeMap.values.elementAt(index);
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(timeValue);

    if (_isTimeSlotBooked(timeKey)) {
      final appointmentId = _getAppointmentId(formattedTime);
      if (appointmentId.isNotEmpty) {
        glb.ConfirmationBox(context, "Do you want to unblock this slot?", () {
          _unBookSlot(appointmentId, timeKey);
        });
      } else {
        glb.errorToast(context, "Could not find appointment ID");
      }
    } else {
      glb.ConfirmationBox(context, "Do you want to block this slot?", () {
        final date = DateFormat('yyyy-MM-dd').format(selectedDate);
        final time = glb.getDateTIme_sys(timeValue.toString()).trim();
        _bookSlot(date, time, timeKey);
      });
    }
  }

  bool _isTimeSlotBooked(String timeKey) {
    return bookedAppointments.any((appointment) {
      return glb.getDateTIme(appointment.time) == timeKey;
    });
  }

  String _getAppointmentId(String timeStr) {
    final timePart = timeStr.split(' ')[1];

    for (var appointment in bookedAppointments) {
      final appointmentTimePart = appointment.time.split(' ')[1];
      if (appointmentTimePart == timePart) {
        return appointment.ID;
      }
    }
    return "";
  }

  // API methods
  Future<void> _updateAvailableTimeAPI(String from, String to) async {
    try {
      final url = Uri.parse(glb.API.baseURL + glb.API.updateAvailability);
      final response = await http.post(url, body: {
        'doc_id':
            glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
        'branch_doc': glb.usrTyp == '1' ? '0' : '1',
        'available_from': from,
        'available_to': to,
      });

      if (response.statusCode == 200) {
        glb.SuccessToast(context, "Timing updated successfully");

        if (glb.usrTyp == '1') {
          await _loginAsync();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DocHome_pg(pgNO: 2)));
        } else {
          await _clinicLoginAsync();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => clinicHome_pg(pgNO: 5)));
        }
      }
    } catch (e) {
      print("Exception updating available time: $e");
      glb.errorToast(context, "Failed to update timing");
    }
  }

  Future<void> _bookSlot(String date, String time, String timeKey) async {
    try {
      final url = Uri.parse(glb.API.baseURL + "book_video_slot");
      final response = await http.post(url, body: {
        'doctor_id':
            glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
        'branch_doc': glb.usrTyp == '1' ? '0' : '1',
        'date': date,
        'slot_time': "$date $time:00"
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Navigator.pop(context);
        glb.SuccessToast(context, "Slot blocked successfully");

        setState(() {
          bookedAppointments.add(BookedAppointments_model(
              ID: responseData[0]['id'].toString(), time: "$date $time:00"));
        });
      }
    } catch (e) {
      print("Exception booking slot: $e");
      glb.errorToast(context, "Failed to book slot");
    }
  }

  Future<void> _unBookSlot(String id, String timeKey) async {
    try {
      final url = Uri.parse(glb.API.baseURL + "del_video_slot");
      final response = await http.post(url, body: {'ID': id});

      if (response.statusCode == 200) {
        Navigator.pop(context);
        glb.SuccessToast(context, "Slot unblocked successfully");

        setState(() {
          bookedAppointments.removeWhere((appointment) => appointment.ID == id);
        });
      }
    } catch (e) {
      print("Exception unbooking slot: $e");
      glb.errorToast(context, "Failed to unblock slot");
    }
  }

  Future<void> _loginAsync() async {
    try {
      final url = Uri.parse(glb.API.baseURL + glb.API.Dlogin);
      final response = await http.post(
        url,
        headers: {'accept': 'application/json'},
        body: {
          '_token': '{{ csrf_token() }}',
          'data': glb.doctor.mobile_no,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.isEmpty) {
          glb.errorToast(context, "Account not found");
          return;
        }

        final userData = responseData[0];
        if (userData['verified'].toString() == '0') {
          glb.ConfirmationBox(context, "You are not yet verified", () {
            Navigator.pop(context);
          });
          return;
        }

        // Update doctor data
        setState(() {
          glb.doctor.doc_id = userData['ID'].toString();
          glb.doctor.name = userData['Name'].toString();
          glb.doctor.mobile_no = userData['mobile_no'].toString();
          glb.doctor.email = userData['email_id'].toString();
          glb.doctor.pswd = userData['pswd'].toString();
          glb.doctor.speciality = userData['Speciality'].toString();
          glb.doctor.Degree = userData['Degree'].toString();
          glb.doctor.available_from = userData['available_from'].toString();
          glb.doctor.available_to = userData['available_to'].toString();
          // Add other fields as needed
        });
      }
    } catch (e) {
      print("Exception in login: $e");
    }
  }

  Future<void> _clinicLoginAsync() async {
    try {
      final url = Uri.parse(glb.API.baseURL + "getCliniLogin");
      final response = await http.post(url, body: {
        'user_name': glb.clinicBranchDoc.usr_nm,
      });

      if (response.body.isEmpty || response.body == "none") {
        glb.errorToast(context, "User not found");
        return;
      }

      final responseData = jsonDecode(response.body);
      final userData = responseData[0];

      if (glb.clinicBranchDoc.pswd == userData['password'].toString()) {
        glb.clinicRole = userData['role'].toString();

        // Update clinic data based on role
        if (userData['role'].toString() == '2') {
          setState(() {
            glb.clinicBranchDoc.available_from =
                userData['available_from'].toString();
            glb.clinicBranchDoc.available_to =
                userData['available_to'].toString();
            // Add other fields as needed
          });
        }
      } else {
        glb.errorToast(context, "Wrong password");
      }
    } catch (e) {
      print("Exception in clinic login: $e");
    }
  }
}

// Utility functions
List<String> generateTimeList(int startHour, int endHour) {
  List<String> timeList = [];
  DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, startHour, 0);
  DateTime endTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, endHour, 0);

  while (startTime.isBefore(endTime)) {
    timeList.add(DateFormat('h:mm a').format(startTime));
    startTime = startTime.add(const Duration(minutes: 30));
  }

  return timeList;
}

Map<String, DateTime> generateTimeMap(int startHour, int endHour) {
  Map<String, DateTime> timeMap = {};
  DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, startHour, 0);
  DateTime endTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, endHour, 0);

  while (startTime.isBefore(endTime)) {
    timeMap[DateFormat('h:mm a').format(startTime)] = startTime;
    startTime = startTime.add(const Duration(minutes: 30));
  }

  return timeMap;
}

Map<String, DateTime> generateTimeMap1(
    int startHour, int startMinute, int endHour, int endMinute) {
  Map<String, DateTime> timeMap = {};
  myMorningMap.clear();
  myAfternoonMap.clear();
  myEveningMap.clear();

  DateTime startTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, startHour, startMinute);
  DateTime endTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, endHour, endMinute);

  while (startTime.isBefore(endTime.add(const Duration(minutes: 30)))) {
    final timeKey = DateFormat('h:mm a').format(startTime);
    timeMap[timeKey] = startTime;

    if (startTime.hour < 12) {
      myMorningMap[timeKey] = startTime;
    } else if (startTime.hour >= 12 && startTime.hour < 17) {
      myAfternoonMap[timeKey] = startTime;
    } else if (startTime.hour >= 17) {
      myEveningMap[timeKey] = startTime;
    }

    startTime = startTime.add(const Duration(minutes: 30));
  }

  return timeMap;
}
