import 'package:bighter_panel/Cards/UnverifiedDoc_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class UnverifiedDoctors_pg extends StatefulWidget {
  const UnverifiedDoctors_pg({super.key});

  @override
  State<UnverifiedDoctors_pg> createState() => _UnverifiedDoctors_pgState();
}

class _UnverifiedDoctors_pgState extends State<UnverifiedDoctors_pg> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<AllDoc_model> filteredUnverifiedDocs = [];

  @override
  void initState() {
    super.initState();
    _filterDocs('');
  }

  void _filterDocs(String query) {
    final allUnverified =
        glb.Models.AllDocs_lst.where((doc) => doc.verified == '0').toList();
    query = query.toLowerCase();

    setState(() {
      filteredUnverifiedDocs = allUnverified.where((doc) {
        return doc.name.toLowerCase().contains(query) ||
            doc.Degree.toLowerCase().contains(query) ||
            doc.speciality.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            text: "Unverified Doctors",
            size: 18,
            fntWt: FontWeight.bold,
            fontColour: Colours.RussianViolet,
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: _searchController,
            onChanged: _filterDocs,
            decoration: InputDecoration(
              hintText: "Search by name, degree, or speciality",
              prefixIcon: Icon(Icons.search),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colours.RussianViolet),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 248, 225, 1),
                border:
                    Border(top: BorderSide(color: Colours.orange, width: 3)),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 10,
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: filteredUnverifiedDocs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 800 ? 2 : 4,
                    mainAxisSpacing: 2.h,
                    crossAxisSpacing: 2.w,
                    childAspectRatio: 1.8,
                  ),
                  itemBuilder: (context, index) {
                    return UnverifiedDoc_card(
                      doctor: filteredUnverifiedDocs[index],
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
