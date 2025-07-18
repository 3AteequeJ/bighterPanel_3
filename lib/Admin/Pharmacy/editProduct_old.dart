import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/models/myFeaturedProducts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({
    super.key,
    required this.Product_id,
  });
  final String Product_id;
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController prodNM_cont = TextEditingController();
  TextEditingController price_cont = TextEditingController();
  TextEditingController desc_cont = TextEditingController();
  String img1 = "", img2 = "", img3 = "", img4 = "", img5 = "";
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      prodNM_cont.text = getProdNM(widget.Product_id);
      price_cont.text = getProdPrice(widget.Product_id);
      desc_cont.text = getProddesc(widget.Product_id);
      img1 = getProdimg1(widget.Product_id);
      img2 = getProdimg2(widget.Product_id);
      img3 = getProdimg3(widget.Product_id);
      img4 = getProdimg4(widget.Product_id);
      img5 = getProdimg5(widget.Product_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Txt(
          text: "Edit product",
          fontColour: Colours.txt_white,
        ),
      ),
      body: Container(
        width: 90.w,
        child: Padding(
          padding: EdgeInsets.all(18.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // todo: name, price and desc
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Sizer.w_50 * 6,
                    child: TextField(
                      controller: prodNM_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Product name",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Sizer.w_50 * 6,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      controller: price_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Product price",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Sizer.w_50 * 14,
                    child: TextField(
                      controller: desc_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Description",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizer.h_10 * 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: searchFP(widget.Product_id) == 0
                      ? Colours.orange
                      : searchFP(widget.Product_id) == 1
                          ? Colours.green
                          : Colours.HunyadiYellow,
                ),
                onPressed: () {
                  // getMy_featured_product();
                  if (glb.usrTyp == '0') {
                    add_featured_product(widget.Product_id, '1');
                  } else {
                    add_featured_product(widget.Product_id, '0');
                  }
                },
                child: Txt(
                    text: searchFP(widget.Product_id) == 0
                        ? "Feature this Product"
                        : searchFP(widget.Product_id) == 1
                            ? "This product is featured"
                            : "Waiting for admin to accept"),
              ),
              SizedBox(
                height: Sizer.h_10 * 2,
              ),
              Txt(
                text: "Images",
                fontColour: Colours.txt_grey,
              ),

              Divider(
                color: Colours.divider_grey,
              ),

              Wrap(
                spacing: 30,
                runSpacing: 10,
                children: [
                  Container(
                    height: 250,
                    width: 150,
                    child: Column(
                      children: [
                        Container(
                            height: 180,
                            width: 150,
                            color: Colours.RosePink.withOpacity(.3),
                            child: Image.network(
                              "${img1}?cache_bust=${Random().nextInt(10000)}",
                              // "",
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Iconsax.image5),
                                );
                              },
                            )),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              glb.loading(context);
                              if (glb.usrTyp == '2') {
                                selectImage("img1");
                              } else {
                                selectImage("image");
                              }
                            },
                            child: Container(
                              color: Colours.RosePink.withOpacity(.7),
                              child: Row(
                                children: [
                                  Txt(text: "Select image"),
                                  Icon(Iconsax.document_upload5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ? image 2
                  Container(
                    height: 250,
                    width: 150,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              glb.ConfirmationBox(
                                  context, "You want to remove this image?",
                                  () {
                                Remove_single_img('img2');
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colours.Red,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                        Container(
                            height: 180,
                            width: 150,
                            color: Colours.RosePink.withOpacity(.3),
                            child: Image.network(
                              "${img2}?cache_bust=${Random().nextInt(10000)}",
                              // "",
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Iconsax.image5),
                                );
                              },
                            )),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              glb.loading(context);
                              selectImage("img2");
                            },
                            child: Container(
                              color: Colours.RosePink.withOpacity(.7),
                              child: Row(
                                children: [
                                  Txt(text: "Select image"),
                                  Icon(Iconsax.document_upload5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ? image 3
                  Container(
                    height: 250,
                    width: 150,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              glb.ConfirmationBox(
                                  context, "You want to remove this image?",
                                  () {
                                Remove_single_img('img3');
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colours.Red,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                        Container(
                            height: 180,
                            width: 150,
                            color: Colours.RosePink.withOpacity(.3),
                            child: Image.network(
                              "${img3}?cache_bust=${Random().nextInt(10000)}",
                              // "",
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Iconsax.image5),
                                );
                              },
                            )),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              glb.loading(context);
                              selectImage("img3");
                            },
                            child: Container(
                              color: Colours.RosePink.withOpacity(.7),
                              child: Row(
                                children: [
                                  Txt(text: "Select image"),
                                  Icon(Iconsax.document_upload5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ? img 4
                  Container(
                    height: 250,
                    width: 150,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              glb.ConfirmationBox(
                                  context, "You want to remove this image?",
                                  () {
                                Remove_single_img('img4');
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colours.Red,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                        Container(
                            height: 180,
                            width: 150,
                            color: Colours.RosePink.withOpacity(.3),
                            child: Image.network(
                              "${img4}?cache_bust=${Random().nextInt(10000)}",
                              // "",
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Iconsax.image5),
                                );
                              },
                            )),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              glb.loading(context);
                              selectImage('img4');
                              // selectImage("img4");
                            },
                            child: Container(
                              color: Colours.RosePink.withOpacity(.7),
                              child: Row(
                                children: [
                                  Txt(text: "Select image"),
                                  Icon(Iconsax.document_upload5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ? img 5
                  Container(
                    height: 250,
                    width: 150,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              glb.ConfirmationBox(
                                  context, "You want to remove this image?",
                                  () {
                                Remove_single_img('img5');
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colours.Red,
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                        Container(
                            height: 180,
                            width: 150,
                            color: Colours.RosePink.withOpacity(.3),
                            child: Image.network(
                              "${img5}?cache_bust=${Random().nextInt(10000)}",
                              // "",
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Iconsax.image5),
                                );
                              },
                            )),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              selectImage('img5');
                            },
                            child: Container(
                              color: Colours.RosePink.withOpacity(.7),
                              child: Row(
                                children: [
                                  Txt(text: "Select image"),
                                  Icon(Iconsax.document_upload5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizer.h_10 * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colours.Red),
                    onPressed: () {
                      glb.ConfirmationBox(context,
                          "Are you sure you want to delete this product?", () {
                        del_admin_prod_async();
                      });
                    },
                    child: Txt(text: "Delete"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      glb.loading(context);
                      updateProdDetails(
                          widget.Product_id,
                          prodNM_cont.text.trim(),
                          price_cont.text.trim(),
                          desc_cont.text.trim());
                    },
                    child: Txt(text: "Update"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  updateProdDetails(
    String prod_id,
    String prod_nm,
    String prod_price,
    String prod_desc,
  ) async {
    Uri url = Uri.parse(glb.API.baseURL + "update_product_details");
    var boody = {};
    if (glb.usrTyp == '0') {
      boody = {
        'usr_typ': '0',
        'product_id': '${prod_id}',
        'product_name': '${prod_nm}',
        'price': '${prod_price}',
        'Description': '${prod_desc}',
      };
    } else if (glb.usrTyp == '1') {
      boody = {
        'usr_typ': '1',
        'product_id': '${prod_id}',
        'product_name': '${prod_nm}',
        'price': '${prod_price}',
        'Description': '${prod_desc}',
      };
    } else if (glb.usrTyp == '2') {
      boody = {
        'usr_typ': '2',
        'product_id': '${prod_id}',
        'product_name': '${prod_nm}',
        'price': '${prod_price}',
        'description': '${prod_desc}',
      };
    }
    try {
      var res = await http.post(url, body: boody);
      print("body = ${res.body}");
      if (res.body.toString() == '1') {
        glb.SuccessToast(context, "Done");
        if (glb.usrTyp == '0') {
          GetAdminProducts_async();
        } else {
          GetDocProducts_async();
        }
      }
    } catch (e) {}
    Navigator.pop(context);
  }

  del_admin_prod_async() async {
    // String url = glb.API.baseURL+ "DelAdminProd";
    Uri url = Uri.parse(glb.API.baseURL + "DelAdminProd");
    if (glb.usrTyp == '0') {
      url = Uri.parse(glb.API.baseURL + "DelAdminProd");
    } else {
      url = Uri.parse(glb.API.baseURL + "DelDocProd");
    }

    try {
      var res = await http.post(
        url,
        body: {
          'ID': "${widget.Product_id}",
        },
      );

      print("Del response == " + res.body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);
        await GetAdminProducts_async();
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  Remove_single_img(String img_no) async {
    // String url = glb.API.baseURL+ "DelAdminProd";
    Uri url = Uri.parse("");
    if (glb.usrTyp == '0') {
      url = Uri.parse(glb.API.baseURL + glb.API.DelAdminSingleProdImg);
    } else if (glb.usrTyp == '1') {
      url = Uri.parse(glb.API.baseURL + glb.API.DelDocSingleProdImg);
    }

    try {
      var res = await http.post(
        url,
        body: {
          'prod_id': "${widget.Product_id}",
          'img_no': img_no,
        },
      );

      print("Del response == " + res.statusCode.toString());
      print(res.body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);
        if (img_no == 'img2') {
          setState(() {
            img2 = "";
          });
        } else if (img_no == 'img3') {
          setState(() {
            img3 = "";
          });
        } else if (img_no == 'img4') {
          setState(() {
            img4 = "";
          });
        } else if (img_no == 'img5') {
          setState(() {
            img5 = "";
          });
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
            typ: bdy[i]['type'].toString(),
            out_of_stock: bdy[i]['out_of_stock'].toString(),
          ),
        );
      }
      setState(() {
        glb.Models.adminProducts_lst = pm;
      });
    } catch (e) {
      print("Exception => $e");
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => adminHome_pg(
          pgNO: 4,
        ),
      ),
    );
  }

  GetDocProducts_async() async {
    pm = [];

    print("get admin prod ");
    String Doctor_id = '${glb.doctor.doc_id}';
    Uri url = Uri.parse(glb.API.baseURL + glb.API.get_doctor_products);
    if (glb.usrTyp == '2') {
      Doctor_id = glb.clinicBranchDoc.doc_id;
      url = Uri.parse(glb.API.baseURL + glb.API.get_BranchDocProducts);
    }

    print(url);
    try {
      var res = await http.post(url, body: {
        'doctor_id': Doctor_id,
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      String a = "", desc = '', rcvImg = "";
      if (glb.usrTyp == "2") {
        a = "${glb.API.baseURL}images/branchDocPharmacy_images/";
        desc = "description";
        rcvImg = "img1";
        desc = "Description";
      } else {
        a = "${glb.API.baseURL}images/doctor_pharmacy/";
        desc = "Description";
      }
      for (int i = 0; i < b.length; i++) {
        pm.add(
          myProducts_model(
            ID: bdy[i]['id'].toString(),
            name: bdy[i]['product_name'].toString(),
            price: bdy[i]['price'].toString(),
            img: a + bdy[i][rcvImg].toString(),
            img2: a + bdy[i]['img2'].toString(),
            img3: a + bdy[i]['img3'].toString(),
            img4: a + bdy[i]['img4'].toString(),
            img5: a + bdy[i]['img5'].toString(),
            desc: bdy[i][desc].toString(),
            typ: bdy[i]['type'].toString(),
            out_of_stock: bdy[i]['out_of_stock'].toString(),
          ),
        );
      }
      setState(() {
        glb.Models.adminProducts_lst = pm;
      });
    } catch (e) {
      print("Exception => $e");
    }
    if (glb.usrTyp == '1') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DocHome_pg(
            pgNO: 4,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => clinicHome_pg(
            pgNO: 3,
          ),
        ),
      );
    }
  }

  add_featured_product(String prodID, String adminProd) async {
    print("get admin prod ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.add_featured_product);
    print(url);
// INSERT INTO `admin_pharmacy` (`id`, `product_name`, `price`, `Description`, `image`, `type`, `img2`, `img3`, `img4`, `img5`) VALUES ('17', 'ere', '43', 'ffd', 'fdfd', '0', '', '', '', '');

    try {
      var res = await http.post(url, body: {
        // 'doc_id': '${glb.doctor.doc_id}',
        'doc_id': '0',
        'product_id': '$prodID',
        'admin_product': '$adminProd',
      });
      print(res.body);
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
      }
    } catch (e) {
      print("Exception => $e");
    }
  }

  searchFP(String ProdID) {
    int a = 0;
    String adminProd = "";
    if (glb.usrTyp == '0') {
      adminProd = '1';
    } else {
      adminProd = '0';
    }
    for (int i = 0; i < glb.Models.myFeaturedProducts_lst.length; i++) {
      if (glb.Models.myFeaturedProducts_lst[i].prodID == ProdID &&
          glb.Models.myFeaturedProducts_lst[i].admin_product == adminProd) {
        if (glb.Models.myFeaturedProducts_lst[i].sts == '1') {
          a = 1;
        } else {
          a = 2;
        }
        break;
      }
    }
    return a;
  }

  getProdNM(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].name;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getProdPrice(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].price;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getProddesc(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].desc;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getProdimg1(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].img;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getProdimg2(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].img2;
        print("gett img 2 == $a");
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getProdimg3(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].img3;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getProdimg4(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].img4;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getProdimg5(String id) {
    String a = "";
    for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
      if (id == glb.Models.adminProducts_lst[i].ID) {
        a = glb.Models.adminProducts_lst[i].img5;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  // getProddesc(String id) {
  //   String a = "";
  //   for (int i = 0; i < glb.Models.adminProducts_lst.length; i++) {
  //     if (id == glb.Models.adminProducts_lst[i].ID) {
  //       a = glb.Models.adminProducts_lst[i].desc;
  //       break;
  //     } else {
  //       a = "";
  //     }
  //   }
  //   return a;
  // }

  void selectImage(String img_no) {
    final input = FileUploadInputElement()..accept = 'image/*';

    input.click();

    input.onChange.listen((event) {
      final files = input.files;
      if (files!.length == 1) {
        final file = files[0];
        final reader = FileReader();

        reader.onLoad.listen((e) {
          final result = reader.result;
          if (result is Uint8List) {
            final blob = Blob([result]);
            final imageUrl = Url.createObjectUrlFromBlob(blob);
            // Use the imageUrl to display the image in an Image widget
            // or any other way you prefer.
            String img = '';
            setState(() {
              img = imageUrl;
            });
            print(imageUrl);
            replace_product(img, img_no);
          }
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  Future<void> replace_product(String img, String img_no) async {
    final url = glb.API.baseURL + "update-pharmacy-images";

    final file = img;
    final response = await http.get(Uri.parse(file));
    final Uint8List imageData = response.bodyBytes;

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageData,
        filename: "${widget.Product_id + img_no}.jpg",
        // filename: 'kittens.png',
      ),
    );

    if (glb.usrTyp == '0') {
      request.fields['admin_pharma_id'] = widget.Product_id;
      request.fields['flag'] = '0';
      request.fields['image_name'] = img_no;
    } else if (glb.usrTyp == '1') {
      request.fields['doc_pharma_id'] = widget.Product_id;
      request.fields['flag'] = '1';
      request.fields['image_name'] = img_no;
    } else if (glb.usrTyp == '2') {
      request.fields['branch_doc_id'] = widget.Product_id;
      request.fields['flag'] = '2';
      request.fields['image_name'] = img_no;
    }

    print("sending img 2");
    try {
      print("try");
      final res = await request.send();
      print("res = ${res.statusCode}");

      print(res.headersSplitValues);

      if (res.statusCode == 200) {
        setState(() {
          Navigator.pop(context);
          glb.SuccessToast(context, "Product added successfully");
          prodNM_cont.clear();
          price_cont.clear();
          desc_cont.clear();
          img = "";
          if (glb.usrTyp == '0') {
            GetAdminProducts_async();
          } else if (glb.usrTyp == '1') {
            GetDocProducts_async();
          } else if (glb.usrTyp == '2') {
            GetDocProducts_async();
          }
        });
      } else {
        setState(() {});
      }
    } catch (e) {
      print("catch");
      print(e);
      setState(() {});
    }
  }
}
