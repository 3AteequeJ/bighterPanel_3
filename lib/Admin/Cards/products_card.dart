import 'dart:convert';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Admin/Pharmacy/editProduct.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:bighter_panel/doctor/docHome_pg.dart' show DocHome_pg;
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:http/http.dart' as http;

class Products_card extends StatefulWidget {
  final myProducts_model pm;
  final String filter;

  const Products_card({
    Key? key,
    required this.pm,
    required this.filter,
  }) : super(key: key);

  @override
  State<Products_card> createState() => _Products_cardState();
}

class _Products_cardState extends State<Products_card> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                widget.pm.img,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                  text: widget.pm.name,
                  size: 14.sp,
                  fntWt: FontWeight.bold,
                  maxLn: 1,
                ),
                Txt(
                  text: "₹${widget.pm.price}",
                  size: 14.sp,
                  fontColour: Colours.green,
                  fntWt: FontWeight.w600,
                ),
                Txt(
                  text: widget.pm.desc.length > 50
                      ? widget.pm.desc.substring(0, 50) + "..."
                      : widget.pm.desc,
                  size: 12.sp,
                  fontColour: Colors.grey.shade600,
                  maxLn: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        glb.ConfirmationBox(
                            context, "you want to delete this Product?", () {
                          deleteProduct();
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue[800]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProduct(
                              product: widget.pm,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  deleteProduct() async {
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
            out_of_stock: bdy[i]['out_of_stock'].toString(),
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
            out_of_stock: bdy[i]['out_of_stock'].toString(),
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
