import 'package:bighter_panel/Cards/allDocs_card.dart';
import 'package:bighter_panel/Cards/allDocs_card_new.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:go_router/go_router.dart';

class allDocs_pg extends StatefulWidget {
  const allDocs_pg({super.key});

  @override
  State<allDocs_pg> createState() => _allDocs_pgState();
}

class _allDocs_pgState extends State<allDocs_pg> {
  final ScrollController _firstController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<AllDoc_model> filteredDocs = [];

  @override
  void initState() {
    super.initState();
    filteredDocs = glb.Models.AllDocs_lst;
  }

  void _filterDocs(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredDocs = glb.Models.AllDocs_lst.where((doc) {
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
            text: "All Doctors",
            size: 18,
            fntWt: FontWeight.bold,
            fontColour: Colours.RussianViolet,
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: TextField(
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
              ),
              SizedBox(width: 2.w),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, RG.AddDoc_rt);
                },
                icon: Icon(Icons.add),
                label: Txt(text: "Add doctor"),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 248, 225, 1),
                border: Border(top: BorderSide(color: Colours.blue, width: 3)),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Scrollbar(
                thickness: 10,
                thumbVisibility: true,
                trackVisibility: true,
                controller: _firstController,
                child: GridView.builder(
                  controller: _firstController,
                  itemCount: filteredDocs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 800 ? 2 : 4,
                    mainAxisSpacing: 2.h,
                    crossAxisSpacing: 2.w,
                    childAspectRatio: 1.8,
                  ),
                  itemBuilder: (context, index) {
                    return AllDocs_card_new(AD: filteredDocs[index]);
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
