// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:iconsax/iconsax.dart';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/Treatments_model.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Treatments/EditTreatment.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class Treatments_card extends StatefulWidget {
  final Treatments_model tm;
  final Future<void> Function() onUpdate;
  const Treatments_card({required this.tm, required this.onUpdate, super.key});

  @override
  State<Treatments_card> createState() => _Treatments_cardState();
}

class _Treatments_cardState extends State<Treatments_card> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTreatment(
              Treatment_id: '${widget.tm.ID}',
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.tm.treatment ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () async {
                      await deleteTreatment(widget.tm.ID);
                      await widget.onUpdate();
                    },
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text("₹${widget.tm.price}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text("Duration: ${widget.tm.duration}",
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.tm.desc ?? '',
                maxLines: 3,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteTreatment(String id) async {
    print("get treatments async ${glb.doctor.doc_id}");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.del_docTrtmnts);

    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: {
          '_token': '{{ csrf_token() }}',
          // 'doc_id': '${glb.doctor.doc_id}',
          'ID': '$id',
        },
      );
      print(res.statusCode);
      print("body = " + res.body);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        glb.SuccessToast(context, "Done");
        // widget.update();
      }
      print(bdy);
    } catch (e) {
      print("Exception => $e");
    }
  }
}
