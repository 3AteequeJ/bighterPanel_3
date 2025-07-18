// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:bighter_panel/Cards/NewAppointments_card.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import '../../../Utilities/colours.dart';

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
  String searchQuery = '';
  int InClinic_count = 0,
      video_count = 0,
      ongoing_count = 0,
      completed_count = 0,
      cancled_count = 0;

  List<Appointments_model> filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    getCount();
    filteredAppointments = List.from(glb.Models.appointments_lst);
  }

  void filterAppointments() {
    final query = searchQuery.toLowerCase();

    final filtered = glb.Models.appointments_lst.where((appointment) {
      final nameMatch =
          appointment.userNM?.toLowerCase().contains(query) ?? false;
      final dateMatch = appointment.dt_time.toLowerCase().contains(query);

      final matchesFilter = filter_value == 'All' ||
          (filter_value == 'In-Clinic' && appointment.type == '0') ||
          (filter_value == 'Video' && appointment.type == '1') ||
          (filter_value == 'Ongoing' && appointment.status == '0') ||
          (filter_value == 'Completed' && appointment.status == '1') ||
          (filter_value == 'Cancled' && appointment.status == '2');

      return (nameMatch || dateMatch) && matchesFilter;
    }).toList();

    setState(() {
      filteredAppointments = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizer.Pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            text: "Appointments",
            size: 20,
            fntWt: FontWeight.bold,
          ),
          SizedBox(height: Sizer.h_10 / 2),

          // 🔷 Statistics Panel
          Card(
            color: Colours.RosePink.withOpacity(0.1),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(Sizer.Pad),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildStatCard("In-Clinic", InClinic_count),
                  _buildStatCard("Video", video_count),
                  _buildStatCard("Ongoing", ongoing_count),
                  _buildStatCard("Completed", completed_count),
                  _buildStatCard("Canceled", cancled_count),
                ],
              ),
            ),
          ),

          SizedBox(height: Sizer.h_10 / 2),

          // 🔽 Dropdown + Search Field
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colours.RosePink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: filter_value,
                      dropdownColor: Colours.RosePink,
                      borderRadius: BorderRadius.circular(10),
                      icon:
                          Icon(Icons.arrow_drop_down, color: Colours.txt_white),
                      style: TextStyle(color: Colours.txt_white),
                      items: filter.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Txt(
                            text: value,
                            fontColour: Colours.txt_white,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        filter_value = value!;
                        filterAppointments();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by name or date",
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      filterAppointments();
                    });
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: Sizer.h_10 / 2),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabLabel("In-Clinic", Colours.green),
              _buildTabLabel("Video", Colours.orange),
            ],
          ),

          SizedBox(height: Sizer.h_10 / 2),

          // 📋 Appointment Cards
          Expanded(
            child: ListView.builder(
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                return NewAppointments_card(
                  filter: filter_value,
                  appointment: filteredAppointments[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colours.RosePink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Txt(
        text: "$label: $count",
        fontColour: Colours.txt_white,
      ),
    );
  }

  Widget _buildTabLabel(String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: color, width: 3)),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Txt(text: text),
    );
  }

  void getCount() {
    int inClinic = 0, video = 0, ongoing = 0, completed = 0, canceled = 0;

    for (var appt in glb.Models.appointments_lst) {
      print("date before parsing = ${appt.dt_time}");
      final dateTime = DateTime.parse(appt.dt_time);

      print("date after parsing = ${dateTime}");
      final isPast = dateTime.isBefore(DateTime.now()) ||
          dateTime.isAtSameMomentAs(DateTime.now());

      if (appt.status == '0' && isPast) {
        appt.status = '3';
        completed++;
      } else if (appt.status == '0') {
        ongoing++;
      } else if (appt.status == '1') {
        completed++;
      } else if (appt.status == '2') {
        canceled++;
      }

      if (appt.type == '0') inClinic++;
      if (appt.type == '1') video++;
    }

    setState(() {
      InClinic_count = inClinic;
      video_count = video;
      ongoing_count = ongoing;
      completed_count = completed;
      cancled_count = canceled;
    });
  }
}
