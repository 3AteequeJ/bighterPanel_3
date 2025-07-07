import 'package:bighter_panel/Cards/AllClinics_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:go_router/go_router.dart';

class AllClinics extends StatefulWidget {
  const AllClinics({super.key});

  @override
  State<AllClinics> createState() => _AllClinicsState();
}

class _AllClinicsState extends State<AllClinics> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredClinics = [];

  @override
  void initState() {
    super.initState();
    _filteredClinics = glb.Models.AllClinics_lst;
  }

  void _filterClinics(String query) {
    final filtered = glb.Models.AllClinics_lst.where((clinic) {
      final name = clinic.name.toLowerCase();
      final address = clinic.address.toLowerCase();
      final searchLower = query.toLowerCase();
      return name.contains(searchLower) || address.contains(searchLower);
    }).toList();

    setState(() {
      _filteredClinics = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Txt(
          text: "All Clinics",
          size: 18,
          fntWt: FontWeight.bold,
          fontColour: Colours.RussianViolet,
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _searchController,
                onChanged: _filterClinics,
                decoration: InputDecoration(
                  hintText: "Search by name or address",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RG.AddClinic_rt);
                  },
                  child: Txt(text: "Add Clinic"),
                ),
              ),
              SizedBox(height: 1.5.h),
              Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  border: Border(
                    top: BorderSide(color: Colours.blue, width: 3),
                  ),
                ),
                child: Scrollbar(
                  thickness: 5,
                  thumbVisibility: true,
                  controller: ScrollController(),
                  child: ListView.builder(
                    itemCount: _filteredClinics.length,
                    itemBuilder: (context, index) {
                      return AllClinicsCard(clinic: _filteredClinics[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
