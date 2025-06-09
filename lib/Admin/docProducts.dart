import 'package:bighter_panel/Admin/Cards/docProducts_card.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class docProducts_scrn extends StatefulWidget {
  const docProducts_scrn({super.key});

  @override
  State<docProducts_scrn> createState() => _docProducts_scrnState();
}

class _docProducts_scrnState extends State<docProducts_scrn> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: currentWidth > 600
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // childAspectRatio: 1,
                  crossAxisCount: currentWidth <= 600 ? 2 : 6),
              itemCount: glb.Models.docProducts_lst.length,
              itemBuilder: (context, index) {
                return DocProducts_card(dm: glb.Models.docProducts_lst[index]);
              })
          : ListView.builder(itemBuilder: (context, index) {
              return DocProducts_card(dm: glb.Models.docProducts_lst[index]);
            }),
    );
  }
}
