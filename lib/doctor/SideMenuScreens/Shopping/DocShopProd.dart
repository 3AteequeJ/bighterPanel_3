import 'dart:convert';

import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Cards/DoctorShop_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/Cart_pg.dart';
import 'package:bighter_panel/models/DoctorShopping_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorShopProd extends StatefulWidget {
  const DoctorShopProd({super.key});

  @override
  State<DoctorShopProd> createState() => _DoctorShopProdState();
}

class _DoctorShopProdState extends State<DoctorShopProd> {
  List<DoctorShop_model> allProducts = glb.Models.DoctorShop_lst;
  List<DoctorShop_model> filteredProducts = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Call async loader
    searchController.addListener(_onSearchChanged);
  }

  void _loadProducts() async {
    await GetAdminProducts_async(); // Fetch from API or backend
    setState(() {
      allProducts = glb.Models.DoctorShop_lst;
      filteredProducts = allProducts;
    });
  }

  List<DoctorShop_model> dsm = [];
  GetAdminProducts_async() async {
    dsm = [];

    print("get admin prod ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.GetAdminProducts);
    print(url);
    try {
      var res = await http.get(url);
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      for (int i = 0; i < b.length; i++) {
        if (bdy[i]['type'].toString() == '1') {
          dsm.add(
            DoctorShop_model(
              id: bdy[i]['id'].toString(),
              name: bdy[i]['product_name'].toString(),
              price: bdy[i]['price'].toString(),
              img1: "${glb.API.baseURL}images/admin_pharmacy/" +
                  bdy[i]['image'].toString(),
              img2: "${glb.API.baseURL}images/admin_pharmacy/" +
                  bdy[i]['img2'].toString(),
              img3: "${glb.API.baseURL}images/admin_pharmacy/" +
                  bdy[i]['img3'].toString(),
              img4: "${glb.API.baseURL}images/admin_pharmacy/" +
                  bdy[i]['img4'].toString(),
              img5: "${glb.API.baseURL}images/admin_pharmacy/" +
                  bdy[i]['img5'].toString(),
              desc: bdy[i]['Description'].toString(),
            ),
          );
        }
      }
      setState(() {
        glb.Models.DoctorShop_lst = dsm;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((item) {
        return item.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Column(
        children: [
          // 🔍 Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Search products...',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 2.h),

          // 🛍 Product Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text("No products found"))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (Device.screenType == ScreenType.tablet) ? 4 : 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return DoctorShop_card(dsm: filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
