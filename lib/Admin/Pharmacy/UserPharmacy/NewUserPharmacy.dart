import 'dart:convert';
import 'dart:html';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Admin/Cards/products_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class newUserPharmacy extends StatefulWidget {
  const newUserPharmacy({super.key});

  @override
  State<newUserPharmacy> createState() => _newUserPharmacyState();
}

enum SingingCharacter { User, Doctor }

List<String> list = ['All', 'User', 'Doctor'];

class _newUserPharmacyState extends State<newUserPharmacy> {
  SingingCharacter? _character = SingingCharacter.User;

  String dropDown_value = list.first;

  TextEditingController prodNM_cont = TextEditingController();
  TextEditingController price_cont = TextEditingController();
  TextEditingController desc_cont = TextEditingController();
  bool add_prod = false;

  @override
  void initState() {
    // TODO: implement initState
    GetAdminProducts_async();
    seperatrList(glb.Models.adminProducts_lst);
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
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 200,
                                      child: ListTile(
                                        title: const Text('User'),
                                        leading: Radio<SingingCharacter>(
                                          value: SingingCharacter.User,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter? value) {
                                            setState(() {
                                              _character = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: ListTile(
                                        title: const Text('Doctor'),
                                        leading: Radio<SingingCharacter>(
                                          value: SingingCharacter.Doctor,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter? value) {
                                            setState(() {
                                              _character = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      var typ = "";
                                      if (_character == SingingCharacter.User) {
                                        setState(() {
                                          typ = "0";
                                        });
                                      } else {
                                        setState(() {
                                          typ = "1";
                                        });
                                      }
                                      print("typ == $typ");
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
                                          typ,
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
                            padding: EdgeInsets.all(Sizer.Pad),
                            child: currentWidth > 600
                                ? GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 1,
                                            crossAxisCount: 2),
                                    itemCount:
                                        glb.Models.adminProducts_lst.length,
                                    itemBuilder: (context, index) {
                                      return Products_card(
                                        filter: "All",
                                        pm: glb.Models.adminProducts_lst[index],
                                      );
                                    })
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                    return Products_card(
                                      filter: "All",
                                      pm: glb.Models.adminProducts_lst[index],
                                    );
                                  }),
                          ),
                        ),
                )
              ],
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
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    title: const Text('User'),
                                    leading: Radio<SingingCharacter>(
                                      value: SingingCharacter.User,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ListTile(
                                    title: const Text('Doctor'),
                                    leading: Radio<SingingCharacter>(
                                      value: SingingCharacter.Doctor,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
                                              Colours.RosePink.withOpacity(.3),
                                          child: Image.network(
                                            "${img1}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                            color: Colours.RosePink.withOpacity(
                                                .7),
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
                                  height: 180,
                                  width: 140,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 130,
                                          width: 140,
                                          color:
                                              Colours.RosePink.withOpacity(.3),
                                          child: Image.network(
                                            "${img2}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                            color: Colours.RosePink.withOpacity(
                                                .7),
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
                                  height: 180,
                                  width: 140,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 130,
                                          width: 140,
                                          color:
                                              Colours.RosePink.withOpacity(.3),
                                          child: Image.network(
                                            "${img3}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                            color: Colours.RosePink.withOpacity(
                                                .7),
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
                                  height: 180,
                                  width: 140,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 130,
                                          width: 140,
                                          color:
                                              Colours.RosePink.withOpacity(.3),
                                          child: Image.network(
                                            "${img4}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                            color: Colours.RosePink.withOpacity(
                                                .7),
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
                                  height: 180,
                                  width: 140,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 130,
                                          width: 140,
                                          color:
                                              Colours.RosePink.withOpacity(.3),
                                          child: Image.network(
                                            "${img5}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                            color: Colours.RosePink.withOpacity(
                                                .7),
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
                            ElevatedButton(
                                onPressed: () {
                                  var nm = prodNM_cont.text.trim();
                                  var p = price_cont.text.trim();
                                  var des = desc_cont.text.trim();
                                  var typ = "";
                                  if (_character == SingingCharacter.User) {
                                    setState(() {
                                      typ = "0";
                                    });
                                  } else {
                                    setState(() {
                                      typ = "1";
                                    });
                                  }
                                  print("typ == $typ");
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
                                      typ,
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
                          DropdownButton(
                            value: dropDown_value,
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Txt(
                                  text: value,
                                  fontColour: Colours.txt_black,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropDown_value = value!;
                              });
                            },
                          ),
                          Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: .8,
                                          crossAxisCount: 3),
                                  itemCount: dropDown_value == "All"
                                      ? glb.Models.adminProducts_lst.length
                                      : dropDown_value == 'User'
                                          ? admin_user_prod_list.length
                                          : admin_doc_prod_list.length,
                                  itemBuilder: (context, index) {
                                    return dropDown_value == "All"
                                        ? Products_card(
                                            pm: glb.Models
                                                .adminProducts_lst[index],
                                            filter: dropDown_value,
                                          )
                                        : dropDown_value == 'User'
                                            ? Products_card(
                                                pm: admin_user_prod_list[index],
                                                filter: dropDown_value,
                                              )
                                            : Products_card(
                                                pm: admin_doc_prod_list[index],
                                                filter: dropDown_value,
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

  List<myProducts_model> admin_user_prod_list = [];
  List<myProducts_model> admin_doc_prod_list = [];

  seperatrList(List<myProducts_model> lst) {
    for (int i = 0; i < lst.length; i++) {
      if (lst[i].typ == '0') {
        admin_user_prod_list.add(lst[i]);
      } else {
        admin_doc_prod_list.add(lst[i]);
      }
    }
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
    String typ,
    String desc,
  ) async {
    print("sending doc img");
    print("img 1 = $img");
    print("img 2 = $img2");
    print("img 3 = $img3");
    print("img 4 = $img4");
    print("img 5 = $img5");

    final url = glb.API.baseURL + glb.API.add_admin_products;

    final file = img;
    final response = await http.get(Uri.parse(file));
    final Uint8List imageData = response.bodyBytes;

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
        filename: "${name}_2.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'img3',
        imageData3,
        filename: "${name}_3.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'img4',
        imageData4,
        filename: "${name}_4.jpg",
        // filename: 'kittens.png',
      ),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'img5',
        imageData5,
        filename: "${name}_5.jpg",
        // filename: 'kittens.png',
      ),
    );
    request.fields['product_name'] = name;
    request.fields['price'] = price;
    request.fields['type'] = typ;
    request.fields['description'] = desc;

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
          GetAdminProducts_async();
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
      print("nulled img");
      print(bdy[0]["img2"].toString());
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
