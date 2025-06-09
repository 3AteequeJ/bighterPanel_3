// ignore_for_file: prefer_const_constructors, file_names

import 'dart:convert';

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/BranchDocs_model.dart';
import 'package:bighter_panel/models/branches_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class AddBranchDoc_pg extends StatefulWidget {
  const AddBranchDoc_pg({super.key});

  @override
  State<AddBranchDoc_pg> createState() => _AddBranchDocState();
}

const List<String> list = <String>[
  'Dermatology',
  'Cosmetology',
  'Dietician',
  'Dentist',
  'Eye or Opthalmology',
  'Trichology',
  'Plastic surgon'
];

class _AddBranchDocState extends State<AddBranchDoc_pg> {
  String branch_dropdownValue = "Select Branch";
  String speciatily_dropdownValue = list.first;
  TextEditingController usrNM_cont = TextEditingController();
  TextEditingController pswd_cont = TextEditingController();
  TextEditingController name_cont = TextEditingController();
  TextEditingController mobNo_cont = TextEditingController();
  TextEditingController mail_cont = TextEditingController();
  TextEditingController degree_cont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.RosePink,
        title: Txt(
          text: "Add Branch Doctor",
          fontColour: Colours.txt_white,
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
                spacing: Sizer.w_50,
                runSpacing: Sizer.h_50,
                children: [
                  // todo: user_name textfield
                  SizedBox(
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
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
                  // todo: pswd textfield
                  SizedBox(
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
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

                  // todo: branches dropdown
                  Visibility(
                    visible: glb.clinicRole == '0',
                    child: SizedBox(
                      height: 100,
                      width: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSelectedItems: true,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(),
                        ),
                        items: glb.Models.Branches_lst
                            .map((branch) =>
                                "${branch.name} (${branch.city}/${branch.state})")
                            .toList(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                          labelText: "Select a Branch",
                          hintText: "Search for a Branch",
                        )),
                        onChanged: (String? newValue) {
                          setState(() {
                            branch_dropdownValue = newValue!;
                            print(branch_dropdownValue);
                            String newString = newValue
                                .replaceAll(RegExp(r'\(.*\)'), '')
                                .trim();
                            print("new string = $newString");
                            print(newString == "Apollo Hospital");
                            print(glb.Models.Branches_lst
                                .firstWhere(
                                    (branch) => branch.name == newString)
                                .usrNM);

                            print(">>" +
                                glb.Models.Branches_lst
                                    .contains(newString)
                                    .toString());
                            var selectedBranch = glb.Models.Branches_lst
                                .firstWhere((branch) =>
                                    branch.name == newString.trim());
                            String id = selectedBranch!.id;
                            print('Selected State ID: ${selectedBranch!.id}');
                          });
                        },
                        selectedItem: branch_dropdownValue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Sizer.h_50,
              ),
              Wrap(
                spacing: Sizer.w_50,
                runSpacing: Sizer.h_50,
                children: [
                  // todo: name textfield
                  SizedBox(
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
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

                  // todo: mobile number textfield
                  SizedBox(
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
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
                  // todo: mail textfield
                  SizedBox(
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                    height: 50,
                    child: TextField(
                      controller: mail_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  // todo: speciality dropdown
                  SizedBox(
                    height: 100,
                    width: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                    child: DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(),
                      ),
                      items: list,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelText: "Select speciality",
                        hintText: "Search speciality",
                      )),
                      onChanged: (String? newValue) {
                        setState(() {});
                      },
                      selectedItem: speciatily_dropdownValue,
                    ),
                  ),
                  // todo: Degree textfield
                  SizedBox(
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                    height: 50,
                    child: TextField(
                      controller: degree_cont,
                      decoration: InputDecoration(
                        hoverColor: Colours.HunyadiYellow,
                        labelText: "Degree",
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Sizer.h_50),
              // todo: Add button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      if (glb.clinicRole == '0') {
                        if (branch_dropdownValue.isEmpty ||
                            usrNM_cont.text.isEmpty ||
                            pswd_cont.text.isEmpty ||
                            branch_dropdownValue == "Select Branch") {
                          glb.errorToast(context,
                              "User name,password and branch are required");
                        } else {
                          // var selectedCity = cm
                          //     .firstWhere((city) => city.nm == speciatily_dropdownValue);
                          // var cityID = selectedCity.id;
                          String newString = branch_dropdownValue
                              .replaceAll(RegExp(r'\(.*\)'), '')
                              .trim();
                          var selectedBranch = glb.Models.Branches_lst
                              .firstWhere(
                                  (branch) => branch.name == newString.trim());

                          String id = selectedBranch.id;
                          var usrnm = usrNM_cont.text.trim();
                          var pswd = pswd_cont.text.trim();
                          var name = name_cont.text.trim();
                          var mobno = mobNo_cont.text.trim();
                          var deg = degree_cont.text.trim();
                          var mail = mail_cont.text.trim();
                          print("branchID = $id");
                          print("$usrnm\n$pswd\n$name\n$mobno\n$mail");
                          print(speciatily_dropdownValue);
                          print(branch_dropdownValue);

                          glb.loading(context);
                          AddBranchDoc_async(usrnm, pswd, id,
                              speciatily_dropdownValue, name, mobno, mail, deg);
                        }
                      } else if (glb.clinicRole == '1') {
                        if (branch_dropdownValue.isEmpty ||
                            usrNM_cont.text.isEmpty ||
                            pswd_cont.text.isEmpty) {
                          glb.errorToast(
                              context, "User name,password are required");
                        } else {
                          // var selectedCity = cm
                          //     .firstWhere((city) => city.nm == speciatily_dropdownValue);
                          // var cityID = selectedCity.id;
                          String id = glb.clinicBranch.branch_id;
                          var usrnm = usrNM_cont.text.trim();
                          var pswd = pswd_cont.text.trim();
                          var name = name_cont.text.trim();
                          var mobno = mobNo_cont.text.trim();
                          var deg = degree_cont.text.trim();
                          var mail = mail_cont.text.trim();
                          print("branchID = $id");
                          print("$usrnm\n$pswd\n$name\n$mobno\n$mail");
                          print(speciatily_dropdownValue);
                          print(branch_dropdownValue);

                          glb.loading(context);
                          AddBranchDoc_async(usrnm, pswd, id,
                              speciatily_dropdownValue, name, mobno, mail, deg);
                        }
                      }
                    },
                    child: Txt(text: "ADD")),
              )
            ],
          ),
        ),
      ),
    );
  }

  AddBranchDoc_async(String usrNM, String pswd, String branchid, String spec,
      String name, String mobno, String mail, String degree) async {
    Uri url = Uri.parse(glb.API.baseURL + "addMasterCreds");

    try {
      var res = await http.post(url, body: {
        'branch_id': "$branchid",
        'role': '2',
        'user_name': '$usrNM',
        'password': '$pswd',
        'name': '$name',
        'email_id': '$mail',
        'mob_no': '$mobno',
        'speciality': '$spec',
        'degree': '$degree'
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
        getAllDocs_async();
        usrNM_cont.clear();
        pswd_cont.clear();
        name_cont.clear();
        mobNo_cont.clear();
        mail_cont.clear();
      }
      setState(() {});
    } catch (e) {
      print("Exception => $e");
    }
    Navigator.pop(context);
  }

// ====================================================
  List<BranchDoctors_model> ad = [];
  getAllDocs_async() async {
    ad = [];
    print("get all docs async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getBranchDocs);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'all': '1',
        'hq_id': '${glb.clinic.clinic_id}',
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      print(bdy[0]['clinic_name']);
      for (int i = 0; i < b.length; i++) {
        ad.add(
          BranchDoctors_model(
            id: bdy[i]['id'].toString(),
            branch_id: bdy[i]['branch_id'].toString(),
            credentials_id: bdy[i]['credentials_id'].toString(),
            name: bdy[i]['name'].toString(),
            mobno: bdy[i]['mob_no'].toString(),
            email: bdy[i]['email'].toString(),
            degree: bdy[i]['degree'].toString(),
            speciality: bdy[i]['speciality'].toString(),
            img1: bdy[i]['img1'].toString(),
            img2: bdy[i]['img2'].toString(),
            img3: bdy[i]['img3'].toString(),
            img4: bdy[i]['img4'].toString(),
            img5: bdy[i]['img5'].toString(),
            city: bdy[i]['city_nm'].toString(),
            state: bdy[i]['state_nm'].toString(),
            branch_nm: bdy[i]['branch_nm'].toString(),
          ),
        );
      }
      setState(() {
        glb.Tdocs = b.length.toString();
        glb.Models.BranchDoc_lst = ad;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}
