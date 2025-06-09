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

class DoctorShopProd extends StatefulWidget {
  const DoctorShopProd({super.key});

  @override
  State<DoctorShopProd> createState() => _DoctorShopProdState();
}

class _DoctorShopProdState extends State<DoctorShopProd> {
  @override
  void initState() {
    // TODO: implement initState
    GetAdminProducts_async();
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Txt(
            text: "Products",
            size: 18,
            fntWt: FontWeight.bold,
            fontColour: Colours.RussianViolet,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colours.Red,
              //   ),
              //   onPressed: () {},
              //   child: Txt(text: "Orders"),
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.orange,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart_scrn(),
                    ),
                  );
                },
                child: Txt(text: "Cart"),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: currentWidth <= 600
                ? ListView.builder(
                    itemCount: dsm.length,
                    itemBuilder: (context, index) {
                      return DoctorShop_card(dsm: dsm[index]);
                    },
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 5),
                    itemCount: dsm.length,
                    itemBuilder: (context, index) {
                      return DoctorShop_card(dsm: dsm[index]);
                    },
                  ),
          )
        ],
      ),
    );
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
}
