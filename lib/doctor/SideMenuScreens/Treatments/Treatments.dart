// Refactored Treatments_scrn
// Cleaner layout, modularized logic, improved responsiveness

import 'dart:convert';
import 'package:bighter_panel/Cards/Treatments_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/Treatments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';

class Treatments_scrn extends StatefulWidget {
  const Treatments_scrn({super.key});

  @override
  State<Treatments_scrn> createState() => _Treatments_scrnState();
}

class _Treatments_scrnState extends State<Treatments_scrn> {
  final TextEditingController treatmentCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController pricePerCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController hhCtrl = TextEditingController();
  final TextEditingController mmCtrl = TextEditingController();

  final List<String> unitOptions = [
    'per session',
    'whole procedure',
    'Enter manually'
  ];
  String selectedUnit = 'per session';
  bool showCustomUnit = false;

  List<Treatments_model> treatmentList = [];

  @override
  void initState() {
    super.initState();
    fetchTreatments();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
              text: "ADD Treatments",
              fntWt: FontWeight.bold,
              fontColour: Colours.RussianViolet,
              size: 18),
          _buildFormCard(),
          SizedBox(height: Sizer.h_10 * 2),
          Txt(text: "My treatments", fntWt: FontWeight.bold, size: 16),
          Expanded(child: _buildTreatmentsList()),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(Sizer.Pad),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Wrap(
            spacing: Sizer.w_20,
            runSpacing: Sizer.h_10,
            children: [
              _buildTextField(
                  controller: treatmentCtrl, label: "Treatment", width: 350),
              _buildPriceRow(),
              _buildDurationFields(),
            ],
          ),
          SizedBox(height: Sizer.h_10 * 2),
          Wrap(
            spacing: Sizer.w_20,
            runSpacing: Sizer.h_10,
            children: [
              _buildTextField(
                  controller: descCtrl, label: "Description", width: 500),
              ElevatedButton(
                onPressed: _submitTreatment,
                child: Txt(text: "Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      double? width}) {
    return SizedBox(
      width: width ?? 300,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizer.radius_10 / 5)),
        ),
      ),
    );
  }

  Widget _buildPriceRow() {
    return SizedBox(
      width: 450,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: priceCtrl,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: "Price",
                prefixText: "₹ ",
                suffixText: "/",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizer.radius_10 / 5)),
              ),
            ),
          ),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: selectedUnit,
            items: unitOptions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedUnit = value!;
                showCustomUnit = selectedUnit == 'Enter manually';
              });
            },
          ),
          if (showCustomUnit)
            SizedBox(
              width: 150,
              child: TextField(
                controller: pricePerCtrl,
                decoration: InputDecoration(
                  labelText: "per",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizer.radius_10 / 5)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDurationFields() {
    return Row(
      children: [
        Txt(text: "Duration", fntWt: FontWeight.bold),
        SizedBox(width: 10),
        _buildTextField(controller: hhCtrl, label: "hh", width: 60),
        SizedBox(width: 10),
        Txt(text: ":"),
        SizedBox(width: 10),
        _buildTextField(controller: mmCtrl, label: "mm", width: 60),
      ],
    );
  }

  Widget _buildTreatmentsList() {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    if (glb.Models.Treatments_lst.isEmpty)
      return Center(child: Txt(text: "No treatments available."));

    return isWideScreen
        ? GridView.builder(
            itemCount: glb.Models.Treatments_lst.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3),
            itemBuilder: (context, index) => Treatments_card(
              tm: glb.Models.Treatments_lst[index],
              onUpdate: fetchTreatments,
            ),
          )
        : ListView.builder(
            itemCount: glb.Models.Treatments_lst.length,
            itemBuilder: (context, index) => Treatments_card(
              tm: glb.Models.Treatments_lst[index],
              onUpdate: fetchTreatments,
            ),
          );
  }

  Future<void> fetchTreatments() async {
    final uri = Uri.parse(glb.API.baseURL + glb.API.getDocTreatments);
    final isBranchDoc = glb.usrTyp != '1';
    final docID = isBranchDoc ? glb.clinicBranchDoc.doc_id : glb.doctor.doc_id;

    try {
      final response = await http.post(
        uri,
        headers: {'accept': 'application/json'},
        body: {
          '_token': '{{ csrf_token() }}',
          'doc_id': docID,
          'branch_doc': isBranchDoc ? '1' : '0'
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          treatmentList = data
              .map((e) => Treatments_model(
                    ID: e['ID'].toString(),
                    doc_id: e['doc_id'].toString(),
                    treatment: e['treatment'].toString(),
                    price: e['price'].toString(),
                    rating: e['rating'].toString(),
                    desc: e['Description'].toString(),
                    duration: e['duration'].toString(),
                  ))
              .toList();
          glb.Models.Treatments_lst = treatmentList;
        });
      }
    } catch (e) {
      print("Error fetching treatments: $e");
    }
  }

  Future<void> _submitTreatment() async {
    if (treatmentCtrl.text.isEmpty || priceCtrl.text.isEmpty) {
      glb.errorToast(context, "Enter all the details.");
      return;
    }

    final treatment = treatmentCtrl.text.trim();
    final price = priceCtrl.text.trim();
    final priceUnit = showCustomUnit ? pricePerCtrl.text.trim() : selectedUnit;
    final finalPrice = "$price /$priceUnit";
    final duration = "${hhCtrl.text.trim()} hour:${mmCtrl.text.trim()} minutes";
    final desc = descCtrl.text.trim();

    final uri = Uri.parse(glb.API.baseURL + glb.API.addDocTreatments);
    final isBranchDoc = glb.usrTyp != '1';
    final docID = isBranchDoc ? glb.clinicBranchDoc.doc_id : glb.doctor.doc_id;

    glb.loading(context);

    try {
      final res = await http.post(
        uri,
        headers: {'accept': 'application/json'},
        body: {
          '_token': '{{ csrf_token() }}',
          'doc_id': docID,
          'treatment': treatment,
          'price': finalPrice,
          'duration': duration,
          'desc': desc,
          'branch_doc': isBranchDoc ? '1' : '0',
        },
      );

      Navigator.pop(context);

      if (res.statusCode == 200) {
        fetchTreatments();
        glb.SuccessToast(context, "Done");
        treatmentCtrl.clear();
        priceCtrl.clear();
        pricePerCtrl.clear();
        hhCtrl.clear();
        mmCtrl.clear();
        descCtrl.clear();
      } else {
        glb.errorToast(context, "Something went wrong");
      }
    } catch (e) {
      Navigator.pop(context);
      print("Submit error: $e");
    }
  }
}
