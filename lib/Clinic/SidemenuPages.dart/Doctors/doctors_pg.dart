import 'dart:convert';

import 'package:bighter_panel/Cards/BranchDoctors_card.dart';
import 'package:bighter_panel/Cards/allDocs_card.dart';
import 'package:bighter_panel/Clinic/SidemenuPages.dart/Doctors/addBranchDoc.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class allDoctors_pg extends StatefulWidget {
  const allDoctors_pg({super.key});

  @override
  State<allDoctors_pg> createState() => _allDoctors_pgState();
}

class _allDoctors_pgState extends State<allDoctors_pg> {
  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(7.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Txt(
                text: "All Doctors",
                fntWt: FontWeight.bold,
                size: 14,
                fontColour: Colours.RussianViolet,
              ),
              SizedBox(
                height: 1.37.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colours.RosePink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.55.w),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, RG.AddDoc_rt);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddBranchDoc_pg()));
                    },
                    child: Row(
                      children: [
                        Txt(
                          text: "Add new doctor",
                          fontColour: Colours.txt_white,
                        ),
                        Icon(
                          Iconsax.add,
                          color: Colours.icn_white,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 1.37.h,
              ),
              Container(
                height: 70.h,
                // width: 90.w,
                color: const Color.fromRGBO(255, 248, 225, 1),
                child: Scrollbar(
                  thickness: 20,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: _firstController,
                  child: ListView.builder(
                      itemCount: glb.Models.BranchDoc_lst.length,
                      controller: _firstController,
                      itemBuilder: (context, index) {
                        return BranchDoctors_card(
                            AD: glb.Models.BranchDoc_lst[index]);
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
