import 'dart:convert';

import 'package:bighter_panel/Cards/CartProd_card.dart';
import 'package:bighter_panel/Cards/DoctorShop_card.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/address.dart';
import 'package:bighter_panel/models/CartProducts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Utils/global.dart' as glb;

class Cart_scrn extends StatefulWidget {
  const Cart_scrn({super.key});

  @override
  State<Cart_scrn> createState() => _Cart_scrnState();
}

class _Cart_scrnState extends State<Cart_scrn> {
  @override
  void initState() {
    // TODO: implement initState
    GetDocCart_async();
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Txt(text: "My Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: currentWidth <= 600
                ? ListView.builder(
                    itemCount: glb.Models.CartProd_lst.length,
                    itemBuilder: (context, index) {
                      return CartProduct_card(
                        cpm: glb.Models.CartProd_lst[index],
                      );
                    })
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 5),
                    itemCount: glb.Models.CartProd_lst.length,
                    itemBuilder: (context, index) {
                      return CartProduct_card(
                        cpm: glb.Models.CartProd_lst[index],
                      );
                    }),
          ),
          Visibility(
            visible: glb.Models.CartProd_lst.length > 0,
            child: ElevatedButton(
              onPressed: () {
                addInvoice();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Address_Scrn()));
              },
              child: Txt(text: "Proceed"),
            ),
          )
        ],
      ),
    );
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
      var res = await http.post(url, body: bodyy);

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

      setState(() {
        glb.Models.CartProd_lst = cartm;
      });
    } catch (e) {
      print("exp>> $e");
    }
  }

  addInvoice() {
    List<DataRow> dr = [];
    int a = 0;
    for (int i = 0; i < glb.Models.CartProd_lst.length; i++) {
      dr.add(
        DataRow(
          cells: [
            DataCell(
              Txt(text: "${i + 1}"),
            ),
            DataCell(
              Txt(text: "${glb.Models.CartProd_lst[i].name}"),
            ),
            DataCell(
              Txt(text: "${glb.Models.CartProd_lst[i].quant}"),
            ),
            DataCell(
              Txt(
                  text: "${int.parse(
                        glb.Models.CartProd_lst[i].quant.toString(),
                      ) * int.parse(glb.Models.CartProd_lst[i].price)}"),
            ),
          ],
        ),
      );

      a = a +
          (int.parse(glb.Models.CartProd_lst[i].quant.toString()) *
              int.parse(glb.Models.CartProd_lst[i].price));
    }
    setState(() {
      glb.Invoice = dr;
      glb.invoiceTotal = a.toString();
    });
  }
}
