import 'dart:convert';
import 'dart:html';
import 'package:bighter_panel/Admin/Cards/docProducts_card.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Admin/Cards/products_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class newPharmacy extends StatefulWidget {
  const newPharmacy({super.key});

  @override
  State<newPharmacy> createState() => _newPharmacyState();
}

List<String> list = ['All', 'User', 'Doctor'];

class _newPharmacyState extends State<newPharmacy> {
  TextEditingController prodNM_cont = TextEditingController();
  TextEditingController price_cont = TextEditingController();
  TextEditingController desc_cont = TextEditingController();
  bool add_prod = false;
  String dropDown_value = list.first;
  @override
  void initState() {
    // TODO: implement initState
    GetDocProducts_async();
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return currentWidth <= 600
        ? Container(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          add_prod = true;
                        });
                      },
                      child: Container(
                        width: 50.w,
                        color:
                            add_prod ? Colours.orange : Colours.scaffold_white,
                        child: Center(child: Txt(text: "Add product")),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          add_prod = false;
                        });
                      },
                      child: Container(
                        width: 50.w,
                        color:
                            add_prod ? Colours.scaffold_white : Colours.orange,
                        child: Center(child: Txt(text: "My products")),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: add_prod
                      ? Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: currentWidth <= 600
                                      ? 100.w
                                      : Sizer.w_50 * 6,
                                  child: TextField(
                                    controller: prodNM_cont,
                                    decoration: InputDecoration(
                                      hoverColor: Colours.HunyadiYellow,
                                      labelText: "Product name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Sizer.radius_10 / 5),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: currentWidth <= 600
                                      ? 100.w
                                      : Sizer.w_50 * 6,
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
                                        borderRadius: BorderRadius.circular(
                                            Sizer.radius_10 / 5),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Sizer.h_10 * 2,
                                ),
                                SizedBox(
                                  width: currentWidth <= 600
                                      ? 100.w
                                      : Sizer.w_50 * 14,
                                  height: 100,
                                  child: TextField(
                                    controller: desc_cont,
                                    decoration: InputDecoration(
                                      hoverColor: Colours.HunyadiYellow,
                                      labelText: "Description",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Sizer.radius_10 / 5),
                                      ),
                                    ),
                                  ),
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     SizedBox(
                                //       width: 200,
                                //       child: ListTile(
                                //         title: const Text('User'),
                                //         leading: Radio<SingingCharacter>(
                                //           value: SingingCharacter.User,
                                //           groupValue: _character,
                                //           onChanged: (SingingCharacter? value) {
                                //             setState(() {
                                //               _character = value;
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 200,
                                //       child: ListTile(
                                //         title: const Text('Doctor'),
                                //         leading: Radio<SingingCharacter>(
                                //           value: SingingCharacter.Doctor,
                                //           groupValue: _character,
                                //           onChanged: (SingingCharacter? value) {
                                //             setState(() {
                                //               _character = value;
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Wrap(
                                  spacing: 30,
                                  runSpacing: 10,
                                  children: [
                                    Container(
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img1}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img1");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Icons.upload_file),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img2}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img2");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Icons.upload_file),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img3}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img3");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Icons.upload_file),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img4}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img4");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Icons.upload_file),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img5}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img5");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Icons.upload_file),
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
                                ElevatedButton(
                                    onPressed: () {
                                      var nm = prodNM_cont.text.trim();
                                      var p = price_cont.text.trim();
                                      var des = desc_cont.text.trim();

                                      print(nm);
                                      print(p);
                                      print(des);
                                      print(img1);
                                      print(img2);
                                      print(img3);
                                      print(img4);
                                      print(img5);
                                      if (nm.isEmpty ||
                                              p.isEmpty ||
                                              des.isEmpty ||
                                              img1.isEmpty
                                          // ||
                                          // img2.isEmpty ||
                                          // img3.isEmpty ||
                                          // img4.isEmpty ||
                                          // img5.isEmpty
                                          ) {
                                        glb.errorToast(
                                            context, "Enter all the details");
                                      } else {
                                        glb.loading(context);
                                        print("Enter");
                                        // var nm = prodNM_cont.text.trim();
                                        // var p = price_cont.text.trim();
                                        // var des = desc_cont.text.trim();

                                        add_product(
                                          img1,
                                          img2,
                                          img3,
                                          img4,
                                          img5,
                                          nm,
                                          p,
                                          des,
                                        );
                                      }
                                    },
                                    child: Txt(text: "ADD"))
                              ],
                            ),
                          ),
                        )
                      : Container(
                          // color: Colors.blue,

                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: ListView.builder(
                                itemCount: glb.Models.adminProducts_lst.length,
                                itemBuilder: (context, index) {
                                  return Products_card(
                                      filter: dropDown_value,
                                      pm: glb.Models.adminProducts_lst[index]);
                                }),
                          ),
                        ),
                )
              ],
            ),
          )
        : !glb.pharmacy_user
            ? Center(
                child: Material(
                  elevation: 5,
                  color: Colors.transparent,
                  child: Container(
                    height: Sizer.h_50 * 4,
                    width: 50.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Sizer.radius_10 / 5)),
                    child: Padding(
                      padding: EdgeInsets.all(Sizer.Pad),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                              text:
                                  "Streamline your pharmacy management, and gain the ability to add and edit product prices as desired with this plan!, for the following price"),
                          Txt(
                            text:
                                "₹ ${glb.pharmacyPricing.price}/month and ${glb.pharmacyPricing.comission}% of sale",
                            fntWt: FontWeight.bold,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[900]),
                              onPressed: () {
                                razor_pay();
                              },
                              child: Txt(
                                text: "pay",
                                fontColour: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // todo: Add product column
                      Container(
                        decoration:
                            BoxDecoration(border: Border(right: BorderSide())),
                        // color: Colors.amber,
                        width: Sizer.w_full / 2.1,
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Txt(text: "ADD product"),
                                Divider(
                                  color: Colours.divider_grey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Sizer.w_50 * 6,
                                      child: TextField(
                                        controller: prodNM_cont,
                                        decoration: InputDecoration(
                                          hoverColor: Colours.HunyadiYellow,
                                          labelText: "Product name",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Sizer.radius_10 / 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Sizer.w_50 * 6,
                                      child: TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10)
                                        ],
                                        controller: price_cont,
                                        decoration: InputDecoration(
                                          hoverColor: Colours.HunyadiYellow,
                                          labelText: "Product price",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                Sizer.radius_10 / 5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Sizer.h_10 * 2,
                                ),
                                SizedBox(
                                  width: Sizer.w_50 * 14,
                                  height: 100,
                                  child: TextField(
                                    controller: desc_cont,
                                    decoration: InputDecoration(
                                      hoverColor: Colours.HunyadiYellow,
                                      labelText: "Description",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Sizer.radius_10 / 5),
                                      ),
                                    ),
                                  ),
                                ),
                                Wrap(
                                  spacing: 30,
                                  runSpacing: 10,
                                  children: [
                                    Container(
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img1}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img1");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Iconsax
                                                        .document_upload5),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img2}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img2");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Iconsax
                                                        .document_upload5),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img3}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img3");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Iconsax
                                                        .document_upload5),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img4}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img4");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Iconsax
                                                        .document_upload5),
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
                                      height: 180,
                                      width: 140,
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 130,
                                              width: 140,
                                              color:
                                                  Colours.RosePink.withOpacity(
                                                      .3),
                                              child: Image.network(
                                                "${img5}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(Icons.image),
                                                  );
                                                },
                                              )),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                selectImage("img5");
                                              },
                                              child: Container(
                                                color: Colours.RosePink
                                                    .withOpacity(.7),
                                                child: Row(
                                                  children: [
                                                    Txt(text: "Select image"),
                                                    Icon(Iconsax
                                                        .document_upload5),
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
                                ElevatedButton(
                                    onPressed: () {
                                      var nm = prodNM_cont.text.trim();
                                      var p = price_cont.text.trim();
                                      var des = desc_cont.text.trim();

                                      print(nm);
                                      print(p);
                                      print(des);
                                      print(img1);
                                      print(img2);
                                      print(img3);
                                      print(img4);
                                      print(img5);
                                      if (nm.isEmpty ||
                                              p.isEmpty ||
                                              des.isEmpty ||
                                              img1.isEmpty
                                          // ||
                                          // img2.isEmpty ||
                                          // img3.isEmpty ||
                                          // img4.isEmpty ||
                                          // img5.isEmpty
                                          ) {
                                        glb.errorToast(
                                            context, "Enter all the details");
                                      } else {
                                        glb.loading(context);
                                        print("Enter");
                                        // var nm = prodNM_cont.text.trim();
                                        // var p = price_cont.text.trim();
                                        // var des = desc_cont.text.trim();

                                        add_product(
                                          img1,
                                          img2,
                                          img3,
                                          img4,
                                          img5,
                                          nm,
                                          p,
                                          des,
                                        );
                                      }
                                    },
                                    child: Txt(text: "ADD"))
                              ],
                            ),
                          ),
                        ),
                      ),

                      // todo: My products column
                      Container(
                        // color: Colors.blue,
                        width: Sizer.w_full / 2.1,
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Column(
                            children: [
                              Txt(text: "My Products"),
                              Divider(
                                color: Colours.divider_grey,
                              ),
                              Expanded(
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemCount:
                                          glb.Models.adminProducts_lst.length,
                                      itemBuilder: (context, index) {
                                        return Products_card(
                                          pm: glb
                                              .Models.adminProducts_lst[index],
                                          filter: "All",
                                        );
                                      })),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
  }

  String img1 = "", img2 = "", img3 = "", img4 = "", img5 = "";

  void selectImage(String typ) {
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
              if (typ == 'img1') {
                img1 = imageUrl;
              } else if (typ == 'img2') {
                img2 = imageUrl;
              } else if (typ == 'img3') {
                img3 = imageUrl;
              } else if (typ == 'img4') {
                img4 = imageUrl;
              } else if (typ == "img5") {
                img5 = imageUrl;
              }
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
    String img2,
    String img3,
    String img4,
    String img5,
    String name,
    String price,
    String desc,
  ) async {
    print("sending doc img");

    final url = glb.API.baseURL + glb.API.add_doctor_products;

    final file = img;
    final response = await http.get(Uri.parse(file));
    final Uint8List imageData = response.bodyBytes;

    print("\n\n\nimg ????= $img");
    // print(imageData);

    final file2 = img2;
    final response2 = await http.get(Uri.parse(file2));
    final Uint8List imageData2 = response2.bodyBytes;

    final file3 = img3;
    final response3 = await http.get(Uri.parse(file3));
    final Uint8List imageData3 = response3.bodyBytes;

    final file4 = img4;
    final response4 = await http.get(Uri.parse(file4));
    final Uint8List imageData4 = response4.bodyBytes;

    final file5 = img5;
    final response5 = await http.get(Uri.parse(file5));
    final Uint8List imageData5 = response5.bodyBytes;

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageData,
        filename: "${name}.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'img2',
        imageData2,
        filename: "${name}2.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'img3',
        imageData3,
        filename: "${name}3.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'img4',
        imageData4,
        filename: "${name}4.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'img5',
        imageData5,
        filename: "${name}5.jpg",
        // filename: 'kittens.png',
      ),
    );
    request.fields['product_name'] = name;
    request.fields['price'] = price;
    request.fields['doctor_id'] = glb.doctor.doc_id;
    request.fields['description'] = desc;

    print("sending img 2");
    try {
      print("try");
      final res = await request.send();
      print("res = ${res.statusCode}");

      print(res.headersSplitValues);

      if (res.statusCode == 200) {
        setState(() {
          glb.SuccessToast(context, "Product added successfully");
          prodNM_cont.clear();
          price_cont.clear();
          desc_cont.clear();
          img = "";
          GetDocProducts_async();
          Navigator.pop(context);
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
              img2: "${glb.API.baseURL}images/doctor_pharmacy/" +
                  bdy[i]['img2'].toString(),
              img3: "${glb.API.baseURL}images/doctor_pharmacy/" +
                  bdy[i]['img3'].toString(),
              img4: "${glb.API.baseURL}images/doctor_pharmacy/" +
                  bdy[i]['img4'].toString(),
              img5: "${glb.API.baseURL}images/doctor_pharmacy/" +
                  bdy[i]['img5'].toString(),
              desc: bdy[i]['Description'].toString(),
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

  razor_pay() {
    Razorpay razorpay = Razorpay();

    var options = {
      // rzp_live_BbZVdPkRGox44t
      'key': 'rzp_test_JUWKRLHkq2fyIe',
      'amount': glb.pharmacyPricing.price + "00",
      'name': 'Bighter',
      'description': 'Medicine',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,

      'prefill': {'contact': '7618735999', 'email': 'ateeque.mj@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.code.toString()}");
  }

  String Payment_ID = "";
  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.paymentId.toString());
    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
    setState(() {
      Payment_ID = response.paymentId.toString();
    });

    addPharmUser_async();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  addPharmUser_async() async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.addPharmUser);

    print(
      glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
    );
    print(
      glb.usrTyp == '1'
          ? glb.doctor.speciality
          : glb.clinicBranchDoc.speciality,
    );
    print(
      glb.usrTyp == '1' ? glb.doctor.city_id : glb.clinicBranchDoc.branch_id,
    );

    try {
      var res = await http.post(url, body: {
        'doc_id':
            glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
        'branch_doc': glb.usrTyp == '1' ? "0" : "1",
        'payment_id': Payment_ID,
      });
      print("add fd stat code: ${res.statusCode}");
      print(res.body);

      if (res.body == "User already present") {
        glb.errorToast(context, "Something went wrong");
      } else {
        if (res.statusCode == 200) {
          glb.SuccessToast(context, "Successful");
          setState(() {
            glb.pharmacy_user = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocHome_pg(
                          pgNO: 4,
                        )));
          });
        }
      }
    } catch (e) {}
  }
}
