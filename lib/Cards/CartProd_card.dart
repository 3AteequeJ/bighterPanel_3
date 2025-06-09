// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/models/CartProducts_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CartProduct_card extends StatefulWidget {
  const CartProduct_card({
    super.key,
    required this.cpm,
  });
  final CartProducts_Model cpm;
  @override
  State<CartProduct_card> createState() => _CartProduct_cardState();
}

class _CartProduct_cardState extends State<CartProduct_card> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(),
          bottom: BorderSide(),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(Sizer.Pad / 2),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Remove_from_Cart_async(widget.cpm.id);
                },
                child: Icon(
                  Icons.close,
                  color: Colours.Red,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          widget.cpm.img1,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image);
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Txt(text: widget.cpm.name),
                          Txt(
                            text: "₹ " + widget.cpm.price,
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
                      Container(
                        height: 50,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(),
                            left: BorderSide(),
                            bottom: BorderSide(),
                          ),
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                            onTap: () {
                              decreaseQuantity(widget.cpm.id);
                            },
                            child: Icon(Icons.remove)),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(),
                            bottom: BorderSide(),
                          ),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: Txt(text: widget.cpm.quant.toString())),
                      ),
                      Container(
                        height: 50,
                        width: 30,
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(),
                              right: BorderSide(),
                              bottom: BorderSide(),
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: InkWell(
                            onTap: () {
                              increaseQuantity(widget.cpm.id);
                            },
                            child: Icon(Icons.add)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  increaseQuantity(String id) {
    for (int i = 0; i < glb.Models.CartProd_lst.length; i++) {
      if (glb.Models.CartProd_lst[i].id == id) {
        setState(() {
          if (glb.Models.CartProd_lst[i].quant < 50) {
            glb.Models.CartProd_lst[i].quant++;
          }
        });

        break;
      }
    }
  }

  decreaseQuantity(String id) {
    for (int i = 0; i < glb.Models.CartProd_lst.length; i++) {
      if (glb.Models.CartProd_lst[i].id == id) {
        setState(() {
          if (glb.Models.CartProd_lst[i].quant > 1) {
            glb.Models.CartProd_lst[i].quant--;
          }
        });

        break;
      }
    }
  }

  Remove_from_Cart_async(String cartID) async {
    print("adding to cart");
    Uri url = Uri.parse(glb.API.baseURL + "remove_Doccart_product");
    print("url = $url");
    var bodyy = {};

    try {
      var res = await http.post(
        url,
        body: {'cart_id': '$cartID'},
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
        'doc_id': "${glb.doctor.doc_id}",
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
            prod_id: bdy[i]['product_id'].toString(),
            quant: 1,
          ),
        );
      }
      if (glb.usrTyp == '1') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DocHome_pg(
                      pgNO: 5,
                    )));
      } else if (glb.usrTyp == '2') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DocHome_pg(
                      pgNO: 2,
                    )));
      }
      setState(() {
        glb.Models.CartProd_lst = cartm;
      });
    } catch (e) {
      print("exp>> $e");
    }
  }
}
