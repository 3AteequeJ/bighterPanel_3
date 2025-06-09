// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/commonScreens/addDoc.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/myScaffold/myScaffold.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllClinics_model.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

import '../models/branches_model.dart';
import '../models/cities_model.dart';
import '../models/states_model.dart';

class AddClinic extends StatefulWidget {
  const AddClinic({super.key});

  @override
  State<AddClinic> createState() => _AddClinicState();
}

class _AddClinicState extends State<AddClinic> {
  // TextEditingController nm_cont = TextEditingController();
  // TextEditingController add_cont = TextEditingController();
  // TextEditingController mobno_cont = TextEditingController();
  // TextEditingController mail_cont = TextEditingController();
  // TextEditingController pswd_cont = TextEditingController();

  // TextEditingController country = TextEditingController();
  // TextEditingController state = TextEditingController();
  // TextEditingController city = TextEditingController();
  // String countryValue = "";
  // String stateValue = "";
  // String cityValue = "";
  // String address = "";

  //
  String state_dropdownValue = "Select state";
  String city_dropdownValue = "Select city";
  TextEditingController usrNM_cont = TextEditingController();
  TextEditingController pswd_cont = TextEditingController();
  TextEditingController name_cont = TextEditingController();
  TextEditingController mobNo_cont = TextEditingController();
  TextEditingController mail_cont = TextEditingController();
  TextEditingController address_cont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    GetAllStates_async();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    double currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colours.RosePink,
        title: Txt(
          text: "Add Clinic",
          fontColour: Colours.txt_white,
          fntWt: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizer.Pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                runAlignment: WrapAlignment.start,
                spacing: currentWidth <= 600 ? Sizer.w_10 : Sizer.w_50,
                runSpacing: currentWidth <= 600 ? Sizer.h_10 : Sizer.h_50,
                children: [
                  // todo: user name tf
                  SizedBox(
                    width: currentWidth <= 600 ? Sizer.w_full : Sizer.w_50 * 6,
                    height: 50,
                    child: TextField(
                      controller: usrNM_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "User name",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),

                  // todo: pswd tf
                  SizedBox(
                    width: currentWidth <= 600 ? Sizer.w_full : Sizer.w_50 * 6,
                    height: 50,
                    child: TextField(
                      controller: pswd_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Password",
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
                height: currentWidth <= 600 ? Sizer.h_10 : Sizer.h_50,
              ),
              Wrap(
                spacing: currentWidth <= 600 ? Sizer.w_10 : Sizer.w_50,
                runSpacing: currentWidth <= 600 ? Sizer.h_10 : Sizer.h_50,
                children: [
                  // todo: State dropdown
                  SizedBox(
                    height: 100,
                    width: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                    child: DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(),
                      ),
                      items: sm.map((state) => state.nm).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelText: "Select a state",
                        hintText: "Search for a state",
                      )),
                      onChanged: (String? newValue) {
                        setState(() {
                          state_dropdownValue = newValue!;
                          print(state_dropdownValue);
                          var selectedState =
                              sm.firstWhere((state) => state.nm == newValue);
                          String id = selectedState!.id;
                          print('Selected State ID: ${selectedState!.id}');
                          GetAllCities_async(id);
                        });
                      },
                      selectedItem: state_dropdownValue,
                    ),
                  ),

                  // todo: City dropdown
                  SizedBox(
                    height: 100,
                    width: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                    child: DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(),
                      ),
                      items: cm.map((city) => city.nm).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelText: "Select a city",
                        hintText: "Search for a city",
                      )),
                      onChanged: (String? newValue) {
                        setState(() {
                          city_dropdownValue = newValue!;
                          print(state_dropdownValue);
                          var selectedCity =
                              cm.firstWhere((city) => city.nm == newValue);
                          print('Selected city ID: ${selectedCity!.id}');
                        });
                      },
                      selectedItem: city_dropdownValue,
                    ),
                  ),
                  // todo name tf
                  SizedBox(
                    width: currentWidth <= 600 ? Sizer.w_full : Sizer.w_50 * 6,
                    height: 50,
                    child: TextField(
                      controller: name_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  // todo: mob no tf
                  SizedBox(
                    width: currentWidth <= 600 ? Sizer.w_full : Sizer.w_50 * 6,
                    height: 50,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      controller: mobNo_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Mobile number",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  // todo: mail tf
                  SizedBox(
                    width: currentWidth <= 600 ? Sizer.w_full : Sizer.w_50 * 6,
                    height: 50,
                    child: TextField(
                      controller: mail_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Mail",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),

                  // todo: address tf
                  SizedBox(
                    width: currentWidth <= 600 ? Sizer.w_full : Sizer.w_50 * 6,
                    child: TextFormField(
                      controller: address_cont,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Sizer.h_50),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      if (city_dropdownValue.isEmpty ||
                          usrNM_cont.text.isEmpty ||
                          pswd_cont.text.isEmpty) {
                        glb.errorToast(context,
                            "User name,password and city are required");
                      } else {
                        var selectedCity = cm.firstWhere(
                            (city) => city.nm == city_dropdownValue);
                        var cityID = selectedCity.id;

                        var usrnm = usrNM_cont.text.trim();
                        var pswd = pswd_cont.text.trim();
                        var name = name_cont.text.trim();
                        var mobno = mobNo_cont.text.trim();

                        var mail = mail_cont.text.trim();
                        var addrs = address_cont.text.trim();
                        glb.loading(context);
                        AddBranch_async(
                            usrnm, pswd, cityID, name, mobno, mail, addrs);
                      }
                    },
                    child: Txt(text: "ADD")),
              )
            ],
          ),
        ),
      ),

      // Padding(
      //   padding: EdgeInsets.all(8.sp),
      //   child: Container(
      //       height: 100.h,
      //       width: 100.w,
      //       child: Column(
      //         children: [
      //           ///Adding CSC Picker Widget in app
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Wrap(
      //                 spacing: 1.37.h,
      //                 runSpacing: 0.651.w,
      //                 children: [
      //                   Container(
      //                     height: (6.853 * 3).h,
      //                     child: Stack(
      //                       alignment: Alignment.bottomRight,
      //                       children: [
      //                         CircleAvatar(
      //                           radius: (2.77 * 2).w,
      //                           backgroundColor: Colours.HunyadiYellow,
      //                           child: Image.asset("assets/images/clinic.png"),
      //                         ),
      //                         CircleAvatar(
      //                           // radius: 0.55.w,
      //                           backgroundColor: Colors.grey[300],
      //                           child: Icon(Iconsax.camera),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                   Column(
      //                     children: [
      //                       Wrap(
      //                         spacing: 1.37.h,
      //                         runSpacing: 0.651.w,
      //                         children: [
      //                           w200SizedBox(
      //                             wd: (3.255 * 6).w,
      //                             child: TextField(
      //                               controller: nm_cont,
      //                               decoration: InputDecoration(
      //                                 labelText: "Clinic Name",
      //                                 hintText: "Clinic name",
      //                                 hoverColor: Colours.HunyadiYellow,
      //                                 border: OutlineInputBorder(
      //                                   borderRadius: BorderRadius.circular(
      //                                       Sizer.radius_10 / 5),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           w200SizedBox(
      //                             wd: (3.255 * 6).w,
      //                             child: TextField(
      //                               controller: add_cont,
      //                               decoration: InputDecoration(
      //                                 labelText: "Address",
      //                                 hintText: "Address",
      //                                 hoverColor: Colours.HunyadiYellow,
      //                                 border: OutlineInputBorder(
      //                                   borderRadius: BorderRadius.circular(
      //                                       Sizer.radius_10 / 5),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       SizedBox(
      //                         height: 1.37.h,
      //                       ),
      //                       Wrap(
      //                         spacing: 1.37.h,
      //                         runSpacing: 0.651.w,
      //                         children: [
      //                           w200SizedBox(
      //                             wd: (3.255 * 6).w,
      //                             child: TextField(
      //                               inputFormatters: [
      //                                 FilteringTextInputFormatter.digitsOnly,
      //                                 LengthLimitingTextInputFormatter(10)
      //                               ],
      //                               controller: mobno_cont,
      //                               decoration: InputDecoration(
      //                                 labelText: "Contact number",
      //                                 hintText: "Contact number",
      //                                 hoverColor: Colours.HunyadiYellow,
      //                                 border: OutlineInputBorder(
      //                                   borderRadius: BorderRadius.circular(
      //                                       Sizer.radius_10 / 5),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           w200SizedBox(
      //                             wd: (3.255 * 6).w,
      //                             child: TextField(
      //                               controller: mail_cont,
      //                               decoration: InputDecoration(
      //                                 labelText: "Email",
      //                                 hintText: "Email",
      //                                 hoverColor: Colours.HunyadiYellow,
      //                                 border: OutlineInputBorder(
      //                                   borderRadius: BorderRadius.circular(
      //                                       Sizer.radius_10 / 5),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       SizedBox(
      //                         height: 1.37.h,
      //                       ),
      //                       Wrap(
      //                         spacing: 1.37.h,
      //                         runSpacing: 0.651.w,
      //                         children: [
      //                           w200SizedBox(
      //                             wd: (3.255 * 6).w,
      //                             child: TextField(
      //                               controller: pswd_cont,
      //                               decoration: InputDecoration(
      //                                 labelText: "Password",
      //                                 hintText: "Password",
      //                                 hoverColor: Colours.HunyadiYellow,
      //                                 border: OutlineInputBorder(
      //                                   borderRadius: BorderRadius.circular(
      //                                       Sizer.radius_10 / 5),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           ElevatedButton(
      //                               onPressed: () {
      //                                 String nm = nm_cont.text.trim();
      //                                 String add = add_cont.text.trim();
      //                                 String cn = mobno_cont.text.trim();
      //                                 String mail = mail_cont.text.trim();
      //                                 String pswd = pswd_cont.text.trim();
      //                                 // String cntry = country.text.trim();
      //                                 // String st = state.text.trim();
      //                                 // String ct = city.text.trim();
      //                                 // print("c = $cntry");
      //                                 if (nm.isEmpty ||
      //                                         add.isEmpty ||
      //                                         pswd.isEmpty ||
      //                                         cn.isEmpty ||
      //                                         mail.isEmpty
      //                                     // cntry.isEmpty ||
      //                                     // st.isEmpty ||
      //                                     // ct.isEmpty

      //                                     ) {
      //                                   glb.errorToast(
      //                                       context, "Enter all the details");
      //                                 } else {
      //                                   addClinic_async(
      //                                     nm,
      //                                     cn,
      //                                     mail,
      //                                     pswd,
      //                                     add,
      //                                   );
      //                                 }
      //                               },
      //                               child: Txt(text: "Add"))
      //                         ],
      //                       ),
      //                       // SizedBox(
      //                       //   height: 1.37.h,
      //                       // ),
      //                       // SizedBox(
      //                       //   width: 32.55.w,
      //                       //   child: Container(
      //                       //     decoration: BoxDecoration(
      //                       //         border: Border.all(),
      //                       //         borderRadius:
      //                       //             BorderRadius.circular(0.55.w)),
      //                       //     child: Padding(
      //                       //       padding: EdgeInsets.all(12.sp),
      //                       //       child: Column(
      //                       //         children: [
      //                       //           Txt(
      //                       //             text: "Select region",
      //                       //             fntWt: FontWeight.bold,
      //                       //           ),
      //                       //           CountryStateCityPicker(
      //                       //             country: country,
      //                       //             state: state,
      //                       //             city: city,
      //                       //             dialogColor: Colours.scaffold_white,
      //                       //             textFieldDecoration: InputDecoration(
      //                       //               fillColor: Colors.grey[100],
      //                       //               filled: true,
      //                       //               suffixIcon: Icon(Iconsax.arrow_down5),
      //                       //               border: OutlineInputBorder(
      //                       //                 borderRadius:
      //                       //                     BorderRadius.circular(0.55.w),
      //                       //                 borderSide: BorderSide(
      //                       //                     color: Colours.RosePink),
      //                       //               ),
      //                       //             ),
      //                       //           ),
      //                       //         ],
      //                       //       ),
      //                       //     ),
      //                       //   ),
      //                       // ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ],
      //       )),
      // ),
    );
  }

  List<States_model> sm = [];
  GetAllStates_async() async {
    sm = [];
    Uri url = Uri.parse(glb.API.baseURL + glb.API.get_all_states);
    try {
      var res = await http.get(url);

      // print(res.statusCode);
      // print(res.body);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print("length = ${b.length}");
      print(bdy);
      for (int i = 0; i < b.length; i++) {
        sm.add(
          States_model(
            id: bdy[i]['id'].toString(),
            nm: bdy[i]['name'].toString(),
          ),
        );
      }
      setState(() {
        state_dropdownValue = sm.first.nm;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<cities_model> cm = [];
  GetAllCities_async(String id) async {
    cm = [];
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getCities_of_state);
    try {
      var res = await http.post(url, body: {
        'state_id': '$id',
      });

      // print(res.statusCode);
      // print(res.body);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print("length = ${b.length}");
      print(bdy);
      for (int i = 0; i < b.length; i++) {
        cm.add(
          cities_model(
            id: bdy[i]['id'].toString(),
            nm: bdy[i]['city'].toString(),
            state_id: bdy[i]['state_id'].toString(),
          ),
        );
      }
      setState(() {
        city_dropdownValue = cm.first.nm;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  AddBranch_async(
    String usrNM,
    String pswd,
    String city_id,
    String name,
    String mobno,
    String mail,
    String address,
  ) async {
    Uri url = Uri.parse(glb.API.baseURL + "addMasterCreds");
    try {
      var res = await http.post(url, body: {
        'role': '0',
        'user_name': '$usrNM',
        'password': '$pswd',
        'clinic_name': '$name',
        'email_id': '$mail',
        'mobile_no': '$mobno',
        'city_id': '$city_id',
        'address': '$address',
      });

      // print(res.statusCode);
      // print(res.body);
      // var bdy = jsonDecode(res.body);
      // List b = jsonDecode(res.body);
      // print("length = ${b.length}");
      print(res.statusCode);
      print(res.body);
      if (res.body.toString() == "User name already exists") {
        print("here");
        glb.errorToast(
            context, "User name already exists,try using different username");
        // glb.ConfirmationBox(context,
        //     "User name already exists,try using different username", () {});
        usrNM_cont.clear();
      } else if (res.body.toString() == '1') {
        glb.SuccessToast(context, "Done");
        getClinicBranches_async();
        usrNM_cont.clear();
        pswd_cont.clear();
        name_cont.clear();
        mobNo_cont.clear();
        mail_cont.clear();
        address_cont.clear();
      }
      setState(() {});
    } catch (e) {
      print("Exception => $e");
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => adminHome_pg(
          pgNO: 2,
        ),
      ),
    );
  }

  List<Branches_model> bm = [];
  getClinicBranches_async() async {
    bm = [];
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getClinicBranches);
    try {
      var res = await http.post(url, body: {
        'hq_id': '${glb.clinic.clinic_id}',
      });

      // print(res.statusCode);
      // print(res.body);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print("length = ${b.length}");
      print(bdy);

      setState(() {
        for (int i = 0; i < b.length; i++) {
          bm.add(
            Branches_model(
              id: bdy[i]['id'].toString(),
              hq_id: bdy[i]['hq_id'].toString(),
              usrNM: bdy[i]['user_name'].toString(),
              name: bdy[i]['name'].toString(),
              pswd: bdy[i]['password'].toString(),
              mail: bdy[i]['email_id'].toString(),
              mobno: bdy[i]['mob_no'].toString(),
              cityid: bdy[i]['city_id'].toString(),
              city: bdy[i]['city'].toString(),
              state: bdy[i]['stateName'].toString(),
              adrs: bdy[i]['address'].toString(),
              img1: bdy[i]['img1'].toString(),
              img2: bdy[i]['img2'].toString(),
              img3: bdy[i]['img3'].toString(),
              img4: bdy[i]['img4'].toString(),
              img5: bdy[i]['img5'].toString(),
            ),
          );
        }
      });
      setState(() {
        glb.Models.Branches_lst = bm;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}
