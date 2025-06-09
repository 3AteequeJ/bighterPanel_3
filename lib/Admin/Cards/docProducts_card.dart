import 'package:bighter_panel/Admin/Models/docProducts_model.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class DocProducts_card extends StatefulWidget {
  const DocProducts_card({
    super.key,
    required this.dm,
  });
  final docProducts_model dm;
  @override
  State<DocProducts_card> createState() => _DocProducts_cardState();
}

class _DocProducts_cardState extends State<DocProducts_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        // height: 300,
        // width: 100,
        decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            border: Border.all()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              // width: 100,.
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: Image.network(
                widget.dm.img,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  // width: double.maxFinite,
                  // decoration: BoxDecoration(
                  //   border: Border(bottom: BorderSide()),

                  // ),
                  child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Txt(
                  maxLn: 1,
                  text: widget.dm.name,
                  fntWt: FontWeight.bold,
                  size: 18,
                ),
              )),
            ),
            Txt(
              text: "${getDocNM(widget.dm.doc_id)}",
              maxLn: 1,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colours.nonPhoto_blue.withOpacity(0.5),
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Txt(text: "₹ " + widget.dm.price,maxLn: 1,),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  getDocNM(String doc_id) {
    String a = "";
    for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
      if (doc_id == glb.Models.AllDocs_lst[i].ID) {
        a = glb.Models.AllDocs_lst[i].name;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }
}
