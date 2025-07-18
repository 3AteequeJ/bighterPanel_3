import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProduct extends StatefulWidget {
  final myProducts_model product;
  const EditProduct({required this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool isOutOfStock = false;

  final prodNM_cont = TextEditingController();
  final price_cont = TextEditingController();
  final desc_cont = TextEditingController();

  String img1 = "", img2 = "", img3 = "", img4 = "", img5 = "";

  @override
  void initState() {
    super.initState();
    isOutOfStock = widget.product.out_of_stock == '1';

    final p = widget.product;
    prodNM_cont.text = p.name;
    price_cont.text = p.price;
    desc_cont.text = p.desc;
    img1 = p.img;
    img2 = p.img2;
    img3 = p.img3;
    img4 = p.img4;
    img5 = p.img5;
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DocHome_pg(
                      pgNO: 5,
                    )));
        glb.SuccessToast(context, "Done");
        if (glb.usrTyp == '0') {
          GetAdminProducts_async();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => adminHome_pg(
                        pgNO: 5,
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => clinicHome_pg(
                        pgNO: 5,
                      )));
          GetDocProducts_async();
        }
      }
    } catch (e) {}
    Navigator.pop(context);
  }

  Future<void> toggleOutOfStockStatus({
    required String productId,
    required bool isOutOfStock,
  }) async {
    print("Toggeling");
    final url = Uri.parse('https://rts.bighter.com/toggle_outOfStock');

    try {
      final response = await http.post(
        url,
        body: {
          "usr_typ": glb.usrTyp == '0'
              ? "0"
              : glb.usrTyp == '1'
                  ? '1'
                  : '2',
          'product_id': productId.toString(),
          'out_of_stock': isOutOfStock ? '1' : '0',
        },
      );
      print("response = ${response.statusCode}");
      print("body = ${response.body}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isOutOfStock
                  ? 'Product marked as Out of Stock.'
                  : 'Product marked as In Stock.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Revert toggle if API fails
        setState(() {
          this.isOutOfStock = !isOutOfStock;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update stock status.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Revert toggle if exception occurs
      print("print = $e");
      setState(() {
        this.isOutOfStock = !isOutOfStock;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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

  Future<Uint8List> getImageBytes(String url) async {
    final res = await http.get(Uri.parse(url));
    return res.bodyBytes;
  }

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
        filename: "${widget.product.ID + img_no}.jpg",
        // filename: 'kittens.png',
      ),
    );

    if (glb.usrTyp == '0') {
      request.fields['admin_pharma_id'] = widget.product.ID;
      request.fields['flag'] = '0';
      request.fields['image_name'] = img_no;
    } else if (glb.usrTyp == '1') {
      request.fields['doc_pharma_id'] = widget.product.ID;
      request.fields['flag'] = '1';
      request.fields['image_name'] = img_no;
    } else if (glb.usrTyp == '2') {
      request.fields['branch_doc_id'] = widget.product.ID;
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

  Remove_single_img(String img_no) async {
    // String url = glb.API.baseURL+ "DelAdminProd";
    print(img_no);
    print("removing image");
    Uri url = Uri.parse("");
    if (glb.usrTyp == '0') {
      url = Uri.parse(glb.API.baseURL + glb.API.DelAdminSingleProdImg);
    } else if (glb.usrTyp == '1') {
      url = Uri.parse(glb.API.baseURL + glb.API.DelDocSingleProdImg);
    } else {
      url = Uri.parse(glb.API.baseURL + glb.API.DelBranchDocSingleProdImg);
    }
    print("connecting endpoint = ${url}");
    try {
      var res = await http.post(
        url,
        body: {
          'prod_id': "${widget.product.ID}",
          'img_no': img_no,
        },
      );
      print("Image number = $img_no");

      print("Del response == " + res.statusCode.toString());
      // print(res.body);
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

  Widget buildImageUpload(int index) {
    final label = 'img${index + 1}';
    final url = [img1, img2, img3, img4, img5][index];
    final hasImage = url.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () => selectImage(label),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: hasImage
                        ? Image.network(url, fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload, size: 30, color: Colors.grey),
                              SizedBox(height: 4),
                              Text("Upload", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                  ),
                ),
              ),

              // Delete Icon (top-left) if image exists
              if (hasImage)
                Positioned(
                  top: 4,
                  left: 4,
                  child: InkWell(
                    onTap: () {
                      glb.ConfirmationBox(
                        context,
                        "Do you want to delete this image?",
                        () {
                          Remove_single_img((glb.usrTyp == '1' && index == 0)
                              ? 'image'
                              : label);
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ),
                ),
            ],
          ),
          TextButton(
            onPressed: () => selectImage(label),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 20),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text("Replace", style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Product",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.h)),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 20.w,
                      child: SwitchListTile(
                        tileColor: Colors.white,
                        title: Text('Out of Stock',
                            style: TextStyle(fontSize: 15.sp)),
                        value: isOutOfStock,
                        onChanged: (bool value) async {
                          setState(() {
                            isOutOfStock = value;
                          });

                          await toggleOutOfStockStatus(
                            productId: widget.product.ID,
                            isOutOfStock: value,
                          );
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  _buildFormField("Product Name", prodNM_cont),
                  SizedBox(height: 2.h),
                  _buildFormField("Price", price_cont,
                      keyboardType: TextInputType.number),
                  SizedBox(height: 2.h),
                  _buildFormField("Description", desc_cont, maxLines: 4),
                  SizedBox(height: 3.h),
                  Text("Product Images",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 2.h,
                    children:
                        List.generate(5, (index) => buildImageUpload(index)),
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        updateProdDetails(
                          widget.product.ID,
                          prodNM_cont.text,
                          price_cont.text,
                          desc_cont.text,
                        );
                      },
                      label: Txt(text: "Update"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 1.5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            contentPadding:
                EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(1.5.h)),
          ),
        ),
      ],
    );
  }

  Widget buildFormField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
