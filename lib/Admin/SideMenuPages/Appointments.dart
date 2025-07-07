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

class _AllAppointmentsState extends State<AllAppointments> {
  final List<String> filterOptions = [
    'All',
    'In-Clinic',
    'Video',
    'Ongoing',
    'Completed',
    'Cancled',
  ];
  final List<String> dateOptions = ['Today', 'Select period'];

  String selectedFilter = 'All';
  String selectedDateOption = 'Today';

  String fromDate = glb.getDate_sys(DateTime.now().toString());
  String toDate = glb.getDate_sys(DateTime.now().toString());
  List<DateTime?> _datePickerValue = [DateTime.now()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAllAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            text: "All Appointments",
            size: 20,
            fntWt: FontWeight.bold,
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateFilterSection(isWideScreen),
              _buildTypeFilterSection(),
            ],
          ),
          SizedBox(height: 2.h),
          _buildCategoryTabs(),
          SizedBox(height: 2.h),
          Expanded(
            child: glb.Models.appointments_admin_lst.isEmpty
                ? Center(child: Txt(text: "No appointments"))
                : ListView.builder(
                    itemCount: glb.Models.appointments_admin_lst.length,
                    itemBuilder: (context, index) {
                      return AdminAllAppointments_card(
                        am: glb.Models.appointments_admin_lst.reversed
                            .toList()[index],
                        filter: selectedFilter,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required List<String> items,
    required String selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: selectedValue,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Txt(text: value, fontColour: Colours.txt_black),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      onPressed: onPressed,
      child: Txt(text: label),
    );
  }

  Widget _buildDateFilterSection(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdown(
          items: dateOptions,
          selectedValue: selectedDateOption,
          onChanged: (val) => setState(() => selectedDateOption = val!),
        ),
        if (selectedDateOption == 'Select period')
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: isWide
                ? Row(
                    children: [
                      _fromDateBtn(),
                      SizedBox(width: 2.w),
                      _toDateBtn()
                    ],
                  )
                : Column(
                    children: [
                      _fromDateBtn(),
                      SizedBox(height: 1.h),
                      _toDateBtn()
                    ],
                  ),
          ),
      ],
    );
  }

  Widget _fromDateBtn() => _buildDateButton(
        "From date: $fromDate",
        () async {
          var picked = await showCalendarDatePicker2Dialog(
            context: context,
            config: CalendarDatePicker2WithActionButtonsConfig(),
            dialogSize: const Size(325, 400),
            value: _datePickerValue,
            borderRadius: BorderRadius.circular(15),
          );
          if (picked != null) {
            setState(() => fromDate = glb.getDate_sys(picked.first.toString()));
          }
        },
      );

  Widget _toDateBtn() => _buildDateButton(
        "To date: $toDate",
        () async {
          var picked = await showCalendarDatePicker2Dialog(
            context: context,
            config: CalendarDatePicker2WithActionButtonsConfig(),
            dialogSize: const Size(325, 400),
            value: _datePickerValue,
            borderRadius: BorderRadius.circular(15),
          );
          if (picked != null) {
            setState(() => toDate = glb.getDate_sys(picked.first.toString()));
          }
        },
      );

  Widget _buildTypeFilterSection() {
    return Column(
      children: [
        _buildDropdown(
          items: filterOptions,
          selectedValue: selectedFilter,
          onChanged: (val) => setState(() => selectedFilter = val!),
        ),
        SizedBox(height: 1.h),
        ElevatedButton(
          onPressed: GetAllAppointments,
          child: Txt(text: "Search"),
        ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      children: [
        _buildTab("Video appointments", Colours.orange),
        SizedBox(width: 3.w),
        _buildTab("InClinic appointments", Colours.blue),
      ],
    );
  }

  Widget _buildTab(String title, Color color) {
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: color, width: 3)),
      ),
      child: Txt(text: title),
    );
  }

  List<AppointAdmin_model> aam = [];
  GetAllAppointments() async {
    aam = [];
    // Uri url = Uri.parse(glb.API.baseURL + glb.API.get_all_appointments);
    Uri url = Uri.parse(glb.API.baseURL + "get_appointment_admin");
    print(url);
    var boody = {};
    if (selectedDateOption == 'Select period') {
      boody = {
        'day': '1',
        'from_dt': fromDate,
        'to_dt': toDate,
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
            Date_time: list1[i]['date'].toString() +
                " " +
                list1[i]['timing'].toString(),
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
          Date_time:
              list2[i]['date'].toString() + " " + list2[i]['timing'].toString(),
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
