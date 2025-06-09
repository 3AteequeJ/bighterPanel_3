import 'dart:convert';

import 'package:bighter_panel/Cards/Branches_card.dart';
import 'package:bighter_panel/Clinic/SidemenuPages.dart/Branches.dart/addBranches.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/branches_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:bighter_panel/Utils/global.dart' as glb;

import 'package:http/http.dart' as http;

class AllBranches_pg extends StatefulWidget {
  const AllBranches_pg({super.key});

  @override
  State<AllBranches_pg> createState() => _AllBranches_pgState();
}

List<String> list = [
  'All',
];

class _AllBranches_pgState extends State<AllBranches_pg> {
  String dropDown_value = list.first;

  @override
  void initState() {
    // TODO: implement initState
    getLoc_filter();
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Padding(
        padding: EdgeInsets.all(Sizer.Pad),
        child: Column(
          children: [
            Txt(
              text: "All Branches",
              fontColour: Colours.RussianViolet,
              size: 20,
              fntWt: FontWeight.bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  value: dropDown_value,
                  items: list.map<DropdownMenuItem<String>>((String value) {
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
                      dropDown_value = value!;
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(200, 60)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBranches_pg(),
                      ),
                    );
                  },
                  child: Row(
                    children: [Txt(text: "Add"), Icon(Icons.add)],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Sizer.h_10,
            ),
            Expanded(
              child: glb.Models.Branches_lst.isEmpty
                  ? Center(
                      child: Txt(text: "No data found\nAdd a new branch"),
                    )
                  : currentWidth <= 600
                      ? ListView.builder(
                          itemCount: glb.Models.Branches_lst.length,
                          itemBuilder: (context, index) {
                            return Offstage(
                              offstage: dropDown_value == 'All'
                                  ? false
                                  : glb.Models.Branches_lst[index].city !=
                                      dropDown_value,
                              child: Branches_card(
                                  bm: glb.Models.Branches_lst[index]),
                            );
                          })
                      : GridView.builder(
                          itemCount: glb.Models.Branches_lst.length,
                          itemBuilder: (context, index) {
                            return Offstage(
                              offstage: dropDown_value == 'All'
                                  ? false
                                  : glb.Models.Branches_lst[index].city !=
                                      dropDown_value,
                              child: Branches_card(
                                  bm: glb.Models.Branches_lst[index]),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5, crossAxisCount: 2),
                        ),
            )
          ],
        ),
      ),
    );
  }

  getLoc_filter() {
    list.clear();
    list.add('All');
    for (int i = 0; i < glb.Models.Branches_lst.length; i++) {
      list.add(glb.Models.Branches_lst[i].city);
    }
  }
}
