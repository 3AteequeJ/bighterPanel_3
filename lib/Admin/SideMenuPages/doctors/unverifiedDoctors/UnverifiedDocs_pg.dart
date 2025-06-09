import 'package:bighter_panel/Cards/UnverifiedDoc_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class UnverifiedDoctors_pg extends StatefulWidget {
  const UnverifiedDoctors_pg({super.key});

  @override
  State<UnverifiedDoctors_pg> createState() => _UnverifiedDoctors_pgState();
}

class _UnverifiedDoctors_pgState extends State<UnverifiedDoctors_pg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Txt(
            text: "Unverified doctors",
            size: 18,
            fontColour: Colours.RussianViolet,
          ),
          Expanded(child: ListView.builder(
            
            itemCount: glb.Models.AllDocs_lst.length,
            itemBuilder: (context,index){
            return UnverifiedDoc_card(ad: glb.Models.AllDocs_lst.reversed.toList()[index], idx: index,);
          }))
        ],
      ),
    );
  }
}
