import 'dart:convert';
import 'dart:html';

import 'dart:typed_data';

import 'package:bighter_panel/Admin/Cards/products_card.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class pharmacy extends StatefulWidget {
  const pharmacy({super.key});

  @override
  State<pharmacy> createState() => _pharmacyState();
}

class _pharmacyState extends State<pharmacy> {
  TextEditingController nm_cont = TextEditingController();
  TextEditingController p_cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // TODO: title
          Txt(
            text: "Users Pharmacy",
            size: 18,
            fntWt: FontWeight.bold,
          ),
// TODO: body
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(

                        // color: Colours.HunyadiYellow,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // TODO: image conatiner
                          Container(
                            height: 180,
                            width: 140,
                            child: Column(
                              children: [
                                Container(
                                    height: 130,
                                    width: 140,
                                    color: Colours.RosePink.withOpacity(.3),
                                    child: Image.network(
                                      img,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                          child: Icon(Iconsax.image5),
                                        );
                                      },
                                    )),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      selectImage();
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
                          // TOdo: product details
                          Container(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Txt(text: "Enter product name: "),
                                    SizedBox(
                                      width: Sizer.w_50 * 6,
                                      child: TextField(
                                        controller: nm_cont,
                                        decoration: InputDecoration(
                                          hoverColor: Colours.HunyadiYellow,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Sizer.radius_10 / 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Txt(text: "Enter product price: "),
                                    SizedBox(
                                      width: Sizer.w_50 * 6,
                                      child: TextField(
                                        controller: p_cont,
                                        decoration: InputDecoration(
                                          prefixText: "₹",
                                          hoverColor: Colours.HunyadiYellow,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Sizer.radius_10 / 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          //todo: button
                          ElevatedButton(
                              onPressed: () {
                                var n = nm_cont.text.trim();
                                var p = p_cont.text.trim();
                                add_product(img, n, p);
                                // GetDocProducts_async();
                              },
                              child: Txt(text: "Upload"))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Sizer.h_50,
                  ),
                  Txt(
                    text: "My products",
                    size: 18,
                    fntWt: FontWeight.bold,
                  ),
                  Divider(
                    color: Colours.divider_grey,
                  ),
                  SizedBox(
                    height: 40.h,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            // childAspectRatio: 3,
                            crossAxisCount: 6),
                        itemCount: glb.Models.adminProducts_lst.length,
                        itemBuilder: (context, index) {
                          return Products_card(
                              filter: "All",
                              pm: glb.Models.adminProducts_lst[index]);
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String img = "";
  void selectImage() {
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
            setState(() {
              img = imageUrl;
              // tempurl = imageUrl;
            });
            print(imageUrl);
          }
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  Future<void> add_product(
    String img,
    String name,
    String price,
  ) async {
    print("sending doc img");

    final url = glb.API.baseURL + glb.API.add_doctor_products;

    final file = img;
    final response = await http.get(Uri.parse(file));
    final Uint8List imageData = response.bodyBytes;

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageData,
        filename: "${name}.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.fields['product_name'] = name;
    request.fields['price'] = price;
    request.fields['doctor_id'] = glb.doctor.doc_id;

    print("sending img 2");
    try {
      print("try");
      final res = await request.send();
      print("res = ${res.statusCode}");

      print(res.headersSplitValues);

      if (res.statusCode == 200) {
        setState(() {
          glb.SuccessToast(context, "Product added successfully");
          nm_cont.clear();
          p_cont.clear();
          img = "";
          // GetAdminProducts_async();
          GetDocProducts_async();
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

  List<myProducts_model> pm = [];
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
              img2: '',
              img3: '',
              img4: '',
              img5: '',
              desc: '',
              typ: bdy[i]['type'].toString()),
        );
      }
      setState(() {
        glb.Models.adminProducts_lst = pm;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}
