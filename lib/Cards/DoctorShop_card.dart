// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/models/CartProducts_model.dart';
import 'package:bighter_panel/models/DoctorShopping_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/DocShopProd.dart'
    as dp;
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class DoctorShop_card extends StatefulWidget {
  const DoctorShop_card({
    super.key,
    required this.dsm,
  });
  final DoctorShop_model dsm;
  @override
  State<DoctorShop_card> createState() => _DoctorShop_cardState();
}

class _DoctorShop_cardState extends State<DoctorShop_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(Sizer.Pad / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      widget.dsm.img1,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image);
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(text: widget.dsm.name),
                      Txt(
                        text: "₹ " + widget.dsm.price,
                        fntWt: FontWeight.bold,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  getCartProd(widget.dsm.id)
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[100]),
                          onPressed: () {},
                          child: Txt(text: "In Cart"))
                      : ElevatedButton(
                          onPressed: () {
                            glb.loading(context);
                            AddToCart_async();
                          },
                          child: Txt(text: "Add to cart"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getCartProd(String id) {
    bool a = false;
    for (int i = 0; i < glb.Models.CartProd_lst.length; i++) {
      if (id == glb.Models.CartProd_lst[i].prod_id) {
        a = true;
        break;
      }
    }
    return a;
  }

  AddToCart_async() async {
    print("adding to cart");
    Uri url = Uri.parse(glb.API.baseURL + "add_Doctorcart_product");
    print("url = $url");
    var bodyy = {};
    if (glb.usrTyp == '1') {
      bodyy = {
        'doc_id': "${glb.doctor.doc_id}",
        'branch_doc': '0',
        'product_id': widget.dsm.id,
      };
    } else if (glb.usrTyp == '2') {
      bodyy = {
        'doc_id': "${glb.clinicBranchDoc.doc_id}",
        'branch_doc': '1',
        'product_id': widget.dsm.id,
      };
    }
    print("body = $bodyy");
    try {
      var res = await http.post(
        url,
        body: bodyy,
      );

      print("sts: " + res.statusCode.toString());
      print(res.body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
        GetDocCart_async();
      }
    } catch (e) {
      print("exp>> $e");
    }
  }

  List<CartProducts_Model> cartm = [];
  GetDocCart_async() async {
    print("get cart");
    Uri url = Uri.parse(glb.API.baseURL + "get_Doccart_products");
    print("url = $url");
    var bodyy = {};
    if (glb.usrTyp == '1') {
      bodyy = {
        'doc_id': "${glb.doctor.doc_id}",
        'branch_doc': '0',
      };
    } else if (glb.usrTyp == '2') {
      bodyy = {
        'doc_id': "${glb.clinicBranchDoc.doc_id}",
        'branch_doc': '1',
      };
    }
    print("body = $bodyy");
    try {
      var res = await http.post(
        url,
        body: bodyy,
      );

      var bdy = json.decode(res.body);
      List b = json.decode(res.body);
      print("sts: " + res.statusCode.toString());
      print(res.body);

      for (int i = 0; i < b.length; i++) {
        cartm.add(
          CartProducts_Model(
            id: bdy[i]['cart_id'].toString(),
            name: bdy[i]['product_name'].toString(),
            price: bdy[i]['price'].toString(),
            img1: bdy[i]['image'].toString(),
            img2: bdy[i]['img2'].toString(),
            img3: bdy[i]['img3'].toString(),
            img4: bdy[i]['img4'].toString(),
            img5: bdy[i]['img5'].toString(),
            desc: bdy[i]['Description'].toString(),
            prod_id: bdy[i]['product_id'].toString(),
            quant: 1,
          ),
        );
      }

      setState(() {
        if (glb.usrTyp == '1') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DocHome_pg(
                pgNO: 5,
              ),
            ),
          );
        } else if (glb.usrTyp == '2') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => clinicHome_pg(
                        pgNO: 6,
                      )));
        }

        glb.Models.CartProd_lst = cartm;
      });
    } catch (e) {
      print("exp>> $e");
    }
  }

  // GetDocProducts_async() async {
  //   print("get admin prod ");
  //   String Doctor_id = '${glb.doctor.doc_id}';
  //   Uri url = Uri.parse(glb.API.baseURL + glb.API.get_doctor_products);
  //   if (glb.usrTyp == '2') {
  //     Doctor_id = glb.clinicBranchDoc.doc_id;
  //     url = Uri.parse(glb.API.baseURL + glb.API.get_BranchDocProducts);
  //   }

  //   print(url);
  //   try {
  //     var res = await http.post(url, body: {
  //       'doctor_id': Doctor_id,
  //     });
  //     print(res.statusCode);
  //     var bdy = jsonDecode(res.body);
  //     List b = jsonDecode(res.body);
  //     print(bdy);
  //     print(b.length);
  //     String a = "", desc = '', rcvImg = "";
  //     if (glb.usrTyp == "2") {
  //       a = "${glb.API.baseURL}images/branchDocPharmacy_images/";
  //       desc = "description";
  //       rcvImg = "img1";
  //       desc = "Description";
  //     } else {
  //       a = "${glb.API.baseURL}images/doctor_pharmacy/";
  //       desc = "Description";
  //     }
  //     setState(() {
  //       glb.Models.adminProducts_lst = pm;
  //     });
  //   } catch (e) {
  //     print("Exception => $e");
  //   }
  // }
}
