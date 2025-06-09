import 'package:bighter_panel/Cards/allDocs_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Txt(
            text: "All  Doctors",
            size: 18,
            fntWt: FontWeight.bold,
            fontColour: Colours.RussianViolet,
          ),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RG.AddDoc_rt);
                      },
                      child: Txt(text: "Add doctor"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.37.h,
                ),
                Container(
                  height: 70.h,
                  // width: 90.w,

                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 248, 225, 1),
                      border: Border(
                          top: BorderSide(color: Colours.blue, width: 3))),
                  child: Scrollbar(
                    thickness: 20,
                    thumbVisibility: true,
                    trackVisibility: true,
                    controller: _firstController,
                    child: GridView.builder(
                      itemCount: glb.Models.AllDocs_lst.length,
                      controller: _firstController,
                      itemBuilder: (context, index) {
                        return AllDocs_card(
                          AD: glb.Models.AllDocs_lst[index],
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
