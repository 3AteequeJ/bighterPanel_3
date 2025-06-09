import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Admin/Pharmacy/editProduct.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Admin/Pharmacy/UserPharmacy/NewUserPharmacy.dart'
    as nup;

class Products_card extends StatefulWidget {
  const Products_card({
    super.key,
    required this.pm,
    required this.filter,
  });
  final myProducts_model pm;
  final filter;
  @override
  State<Products_card> createState() => _Products_cardState();
}

class _Products_cardState extends State<Products_card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Container(
        height: 300,
        // width: 100,
    
        decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            border: Border.all()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: InkWell(
            //       onTap: () {
            //         glb.loading(context);
            //         del_admin_prod_async();
            //       },
            //       child: CircleAvatar(
            //         backgroundColor: Colours.Red,
            //         radius: Sizer.h_10 * 2,
            //         child: Center(child: Icon(Icons.remove)),
            //       )),
            // ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(backgroundColor: Colours.Red),
            //     onPressed: () {
            //       glb.loading(context);
            //       del_admin_prod_async();
            //     },
            //     child: Icon(Icons.remove)),
            Container(
              height: 100,
              // width: 100,.
              width: double.maxFinite,
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: Image.network(
                widget.pm.img + "?cache_bust=${Random().nextInt(10000)}",
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
                  text: widget.pm.name,
                  fntWt: FontWeight.bold,
                  size: 16,
                ),
              )),
            ),
            Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colours.nonPhoto_blue.withOpacity(0.5),
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     glb.ConfirmationBox(context,
                      //         "Are you sure you want to delete this product?",
                      //         () {
                      //       del_admin_prod_async();
                      //     });
                      //   },
                      //   child: Container(
                      //       color: Colours.Red,
                      //       child: Padding(
                      //         padding: EdgeInsets.all(8.0.sp),
                      //         child: Icon(Iconsax.trash),
                      //       )),
                      // ),
                      Txt(text: "₹ " + widget.pm.price),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colours.Red,
                                  shape: CircleBorder()),
                              onPressed: () {
                                glb.ConfirmationBox(context,
                                    "You want to delete this product? ", () {
                                  glb.loading(context);
                                  del_admin_prod_async();
                                });
                              },
                              child: Icon(
                                Icons.remove,
                                color: const Color.fromRGBO(255, 255, 240, 1),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProduct(Product_id: widget.pm.ID),
                                  ),
                                );
                              },
                              child: Txt(text: "Edit")),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  del_admin_prod_async() async {
    // String url = glb.API.baseURL+ "DelAdminProd";
    Uri url = Uri.parse(glb.API.baseURL + "DelAdminProd");
    if (glb.usrTyp == '0') {
      setState(() {
        url = Uri.parse(glb.API.baseURL + "DelAdminProd");
      });
    } else {
      setState(() {
        url = Uri.parse(glb.API.baseURL + "DelDocProd");
      });
    }
    print(url);
    try {
      var res = await http.post(
        url,
        body: {
          'ID': "${widget.pm.ID}",
        },
      );

      print(res.body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);
        if (glb.usrTyp == '0') {
          GetAdminProducts_async();
        } else {
          GetDocProducts_async();
        }
      }
    } catch (e) {}
  }

  List<myProducts_model> pm = [];
  GetAdminProducts_async() async {
    pm = [];

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
        pm.add(
          myProducts_model(
            typ: bdy[i]['type'].toString(),
            ID: bdy[i]['id'].toString(),
            name: bdy[i]['product_name'].toString(),
            price: bdy[i]['price'].toString(),
            img: "${glb.API.baseURL}images/admin_pharmacy/" +
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
      setState(() {
        glb.Models.adminProducts_lst = pm;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => adminHome_pg(
                      pgNO: 4,
                    )));
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  GetDocProducts_async() async {
    pm = [];

    print("get admin prod ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.get_doctor_products);
    print(url);
    try {
      var res = await http.post(url, body: {
        'doctor_id': '${glb.doctor.doc_id}',
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      for (int i = 0; i < b.length; i++) {
        pm.add(
          myProducts_model(
            ID: bdy[i]['id'].toString(),
            name: bdy[i]['product_name'].toString(),
            price: bdy[i]['price'].toString(),
            img: "${glb.API.baseURL}images/doctor_pharmacy/" +
                bdy[i]['image'].toString(),
            typ: bdy[i]['type'].toString(),
            img2: '',
            img3: '',
            img4: '',
            img5: '',
            desc: '',
          ),
        );
      }
      setState(() {
        glb.Models.adminProducts_lst = pm;
        print("changing pg");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DocHome_pg(
                      pgNO: 5,
                    )));
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}
