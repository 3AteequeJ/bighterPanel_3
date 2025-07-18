// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/Cart_pg.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/models/CartProducts_model.dart';
import 'package:bighter_panel/models/DoctorShopping_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/DocShopProd.dart'
    as dp;
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class DoctorShop_card extends StatelessWidget {
  const DoctorShop_card({super.key, required this.dsm});
  final DoctorShop_model dsm;

  @override
  Widget build(BuildContext context) {
    final bool isInCart =
        glb.Models.CartProd_lst.any((item) => item.prod_id == dsm.id);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          AspectRatio(
            aspectRatio: 1.2,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                dsm.img1,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 60),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  dsm.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Price
                Text(
                  "₹ ${dsm.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  child: isInCart
                      ? OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Cart_scrn()));
                          },
                          icon: const Icon(Icons.check, size: 18),
                          label: const Text("In Cart"),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () async {
                            glb.loading(context);
                            await _addToCart(context);
                          },
                          child: Txt(
                            text: "Add to Cart",
                            fontColour: Colours.txt_white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addToCart(BuildContext context) async {
    final Uri url = Uri.parse("${glb.API.baseURL}add_Doctorcart_product");
    final body = {
      'doc_id':
          glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
      'branch_doc': glb.usrTyp == '1' ? '0' : '1',
      'product_id': dsm.id,
    };

    try {
      final res = await http.post(url, body: body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Added to cart");
        await _refreshCart(context);
      }
    } catch (e) {
      debugPrint("Add to cart error: $e");
    }
  }

  Future<void> _refreshCart(BuildContext context) async {
    final Uri url = Uri.parse("${glb.API.baseURL}get_Doccart_products");
    final body = {
      'doc_id':
          glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
      'branch_doc': glb.usrTyp == '1' ? '0' : '1',
    };

    try {
      final res = await http.post(url, body: body);
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        glb.Models.CartProd_lst = data.map((item) {
          return CartProducts_Model(
            id: item['cart_id'].toString(),
            name: item['product_name'].toString(),
            price: item['price'].toString(),
            img1: item['image'].toString(),
            img2: item['img2'].toString(),
            img3: item['img3'].toString(),
            img4: item['img4'].toString(),
            img5: item['img5'].toString(),
            desc: item['Description'].toString(),
            prod_id: item['product_id'].toString(),
            quant: 1,
          );
        }).toList();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => glb.usrTyp == '1'
                ? DocHome_pg(pgNO: 5)
                : clinicHome_pg(pgNO: 6),
          ),
        );
      }
    } catch (e) {
      debugPrint("Refresh cart error: $e");
    }
  }
}
