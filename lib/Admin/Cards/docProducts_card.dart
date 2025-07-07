import 'package:bighter_panel/Admin/Models/docProducts_model.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class DocProductsCard extends StatelessWidget {
  final docProducts_model product;
  const DocProductsCard({super.key, required this.product});

  String getDoctorName(String docId) {
    return glb.Models.AllDocs_lst
        .firstWhere(
          (doc) => doc.ID == docId,
          orElse: () => AllDoc_model(
            ID: '',
            name: '',
            img: '',
            branch_doc: '',
            mobno: '',
            mail: '',
            pswd: '',
            speciality: '',
            Degree: '',
            clinicID: '',
            available: '',
            rating: '',
            verified: '',
            idImg: '',
            CertImg: '',
            CouncilCertImg: '',
            img2: '',
            img3: '',
            img4: '',
            img5: '',
          ),
        )
        .name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colours.divider_grey.withOpacity(0.5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.img,
                // height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.sp, vertical: 4.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                  text: product.name,
                  fntWt: FontWeight.bold,
                  size: 17,
                  maxLn: 1,
                ),
                SizedBox(height: 4),
                Txt(
                  text: 'By ${getDoctorName(product.doc_id)}',
                  size: 14,
                  maxLn: 1,
                  fontColour: Colors.grey.shade600,
                ),
                SizedBox(height: 8),
                Txt(
                  text: "₹ ${product.price}",
                  fntWt: FontWeight.w600,
                  size: 16,
                  fontColour: Colours.RussianViolet,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colours.Red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Add to cart action
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_forever_outlined,
                              size: 16,
                              color: Colours.txt_white,
                            ),
                            Txt(
                              text: "Delete",
                              size: 14,
                              fontColour: Colours.txt_white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
