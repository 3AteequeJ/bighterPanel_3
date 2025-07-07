import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class Pricing_pg extends StatefulWidget {
  const Pricing_pg({super.key});

  @override
  State<Pricing_pg> createState() => _Pricing_pgState();
}

class _Pricing_pgState extends State<Pricing_pg> {
  final List<String> applyLst = ['Both', 'price only', 'comission only'];
  late String dropdownValue;

  final priceCont = TextEditingController();
  final comissionCont = TextEditingController();

  final wSlots = List.generate(3, (_) => TextEditingController());
  final mSlots = List.generate(3, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    priceCont.text = glb.pharmacyPricing.price;
    comissionCont.text = glb.pharmacyPricing.comission;
    wSlots[0].text = glb.ProfilePrioritization_pricing.s1_w;
    wSlots[1].text = glb.ProfilePrioritization_pricing.s2_w;
    wSlots[2].text = glb.ProfilePrioritization_pricing.s3_w;
    mSlots[0].text = glb.ProfilePrioritization_pricing.s1_m;
    mSlots[1].text = glb.ProfilePrioritization_pricing.s2_m;
    mSlots[2].text = glb.ProfilePrioritization_pricing.s3_m;

    dropdownValue = applyLst[int.tryParse(glb.pharmacyPricing.applicable) ?? 0];
  }

  Widget buildTextField(String label, TextEditingController controller,
      {String prefix = '', List<TextInputFormatter>? inputFormatters}) {
    return Container(
      height: Sizer.h_50,
      width: Sizer.w_50 * 6,
      child: Row(
        children: [
          Txt(text: "$label "),
          Expanded(
            child: TextField(
              controller: controller,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                prefixText: prefix,
                border: OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDropdown() {
    return Container(
      height: Sizer.h_50,
      width: Sizer.w_50 * 6,
      child: Row(
        children: [
          Txt(text: "Apply "),
          DropdownButton<String>(
            value: dropdownValue,
            items: applyLst.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Txt(text: value, fontColour: Colours.txt_black),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildSlotInputs(
      String label, List<TextEditingController> controllers) {
    return Column(
      children: [
        Txt(text: label, fntWt: FontWeight.bold),
        for (int i = 0; i < controllers.length; i++)
          Padding(
            padding: EdgeInsets.only(top: Sizer.h_10),
            child: Row(
              children: [
                Txt(text: "Slot ${i + 1}"),
                SizedBox(width: Sizer.w_20),
                SizedBox(
                  width: Sizer.w_50 * 2,
                  child: TextField(
                    controller: controllers[i],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixText: "₹",
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSectionCard(
          title: "Pharmacy pricing",
          children: [
            Wrap(
              spacing: Sizer.w_20,
              children: [
                buildTextField("Price/month", priceCont, prefix: "₹"),
                buildTextField("Commission", comissionCont,
                    prefix: "%",
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                buildDropdown(),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _handlePharmacyUpdate,
                child: Txt(text: "Update"),
              ),
            ),
          ],
        ),
        SizedBox(height: Sizer.h_50),
        _buildSectionCard(
          title: "Profile prioritization pricing",
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSlotInputs("Week", wSlots),
                buildSlotInputs("Month", mSlots),
              ],
            ),
            SizedBox(height: Sizer.h_10 * 2),
            ElevatedButton(
              onPressed: _handleProfilePrioritizationUpdate,
              child: Txt(text: "Update"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Material(
      elevation: 5,
      color: Colors.transparent,
      child: Container(
        width: 70.w,
        color: Colors.white,
        padding: EdgeInsets.all(Sizer.Pad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt(text: title, fntWt: FontWeight.bold),
            Divider(color: Colours.divider_grey),
            ...children,
          ],
        ),
      ),
    );
  }

  void _handlePharmacyUpdate() async {
    final applicable = {
      'Both': '0',
      'price only': '1',
      'comission only': '2',
    }[dropdownValue]!;

    await _updatePharmPrice(
        priceCont.text.trim(), comissionCont.text.trim(), applicable);
  }

  void _handleProfilePrioritizationUpdate() async {
    await _updateProfilePrioritizationPrice(
      wSlots[0].text.trim(),
      wSlots[1].text.trim(),
      wSlots[2].text.trim(),
      mSlots[0].text.trim(),
      mSlots[1].text.trim(),
      mSlots[2].text.trim(),
    );
  }

  Future<void> _updatePharmPrice(
      String price, String commission, String applicable) async {
    try {
      final url = Uri.parse("${glb.API.baseURL}${glb.API.updatePharmPrice}");
      final res = await http.post(url, body: {
        'price': price,
        'commission': commission,
        'applicable': applicable,
      });

      final bdy = jsonDecode(res.body);
      if (bdy.toString() == '1') {
        glb.SuccessToast(context, "Pharmacy price updated");
        setState(() {
          glb.pharmacyPricing.price = price;
          glb.pharmacyPricing.comission = commission;
          glb.pharmacyPricing.applicable = applicable;
        });
      }
    } catch (e) {
      debugPrint("Error updating pharmacy price: $e");
    }
  }

  Future<void> _updateProfilePrioritizationPrice(
      String p1, String p2, String p3, String p4, String p5, String p6) async {
    try {
      final url = Uri.parse(
          "${glb.API.baseURL}${glb.API.updateProfileProritizationPrice}");
      final res = await http.post(url, body: {
        '1s_w': p1,
        '2s_w': p2,
        '3s_w': p3,
        '1s_m': p4,
        '2s_m': p5,
        '3s_m': p6,
      });

      final bdy = jsonDecode(res.body);
      if (bdy.toString() == '1') {
        glb.SuccessToast(context, "Profile prioritization price updated");
        setState(() {
          glb.ProfilePrioritization_pricing.s1_w = p1;
          glb.ProfilePrioritization_pricing.s2_w = p2;
          glb.ProfilePrioritization_pricing.s3_w = p3;
          glb.ProfilePrioritization_pricing.s1_m = p4;
          glb.ProfilePrioritization_pricing.s2_m = p5;
          glb.ProfilePrioritization_pricing.s3_m = p6;
        });
      }
    } catch (e) {
      debugPrint("Error updating profile prioritization price: $e");
    }
  }
}
