// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:bighter_panel/Admin/SideMenuPages/Appointments.dart';
import 'package:bighter_panel/Admin/Models/docProducts_model.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Admin/SideMenuPages/doctors/unverifiedDoctors/UnverifiedDocs_pg.dart';
import 'package:bighter_panel/Admin/Pharmacy/UserPharmacy/NewUserPharmacy.dart';
import 'package:bighter_panel/Admin/SideMenuPages/Clinic_pages/clinics.dart';
import 'package:bighter_panel/Admin/SideMenuPages/doctorsOrders.dart';
import 'package:bighter_panel/Admin/SideMenuPages/pricing_page.dart';
import 'package:bighter_panel/Admin/docProducts.dart';
import 'package:bighter_panel/Admin/SideMenuPages/doctors/VerifiedDoctors/doctors.dart';
import 'package:bighter_panel/Admin/main_pg.dart';
import 'package:bighter_panel/Admin/usersPhar.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/orders_scrn.dart';
import 'package:bighter_panel/models/AllClinics_model.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class adminHome_pg extends StatefulWidget {
  const adminHome_pg({
    super.key,
    this.pgNO = 0,
  });
  final int pgNO;
  @override
  State<adminHome_pg> createState() => _adminHome_pgState();
}

class _adminHome_pgState extends State<adminHome_pg> {
  bool sideMenuFull = false;
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  int pages_index = 0;
  List pages_lst = [
    Main_pg(),
    allDocs_pg(),
    AllClinics(),
    UnverifiedDoctors_pg(),
    newUserPharmacy(),
    DocProductsScreen(),
    AllAppointments(),
  ];
  void initState() {
    getAllDocs_async();
    getAllClinics_async();
    GetAdminProducts_async();
    GetDocProducts_async();
    getPharmacyPricing_async();
    get_featuredDocpricing_async();
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    sideMenu.changePage(widget.pgNO);

    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth <= 600
        ? Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color(0xff124076),
              title: Txt(
                text: "Bighter",
                size: 18,
                fontColour: Colours.orange,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    getAllDocs_async();
                    getAllClinics_async();
                    GetAdminProducts_async();
                    GetDocProducts_async();
                  },
                  child: Icon(
                    Icons.repeat,
                    color: Colours.icn_white,
                  ),
                )
              ],
            ),
            body: pages_lst[pages_index],
            drawer: Drawer(
              child: ListView(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide())),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 6.853.h * 2.5,
                          child: SizedBox(
                            height: Sizer.h_50 * 2,
                            child: Image.asset(
                              'assets/images/admin.png',
                            ),
                          ),
                        ),
                        Txt(text: "Admin")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.37.h * 2,
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Txt(text: "Dashboard"),
                    onTap: () {
                      setState(() {
                        pages_index = 0;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.doctor),
                    title: Txt(text: "Doctors"),
                    onTap: () {
                      setState(() {
                        pages_index = 1;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.officeBuilding),
                    title: Txt(text: "Clinics"),
                    onTap: () {
                      setState(() {
                        pages_index = 2;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.accountAlert),
                    title: Txt(text: "Unverified Doctors"),
                    onTap: () {
                      setState(() {
                        pages_index = 3;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.shoppingOutline),
                    title: Txt(text: "User Pharmacy"),
                    onTap: () {
                      setState(() {
                        pages_index = 4;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.cartOutline),
                    title: Txt(text: "Doctors Pharmacy"),
                    onTap: () {
                      setState(() {
                        pages_index = 5;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.cartOutline),
                    title: Txt(text: "All Appointments"),
                    onTap: () {
                      setState(() {
                        pages_index = 6;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            // backgroundColor: Color(0xff59A5D8),
            backgroundColor: Colours.icn_white,
            appBar: AppBar(
              backgroundColor: Color(0xff124076),
              centerTitle: true,
              title: Txt(
                text: "Bighter",
                size: 18,
                fontColour: Colours.orange,
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.list_sharp,
                  color: Colours.icn_white,
                ),
                onPressed: () {
                  setState(() {
                    sideMenuFull = !sideMenuFull;
                  });
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      getAllDocs_async();
                      // getAllClinics_async();
                    },
                    icon: Icon(
                      Iconsax.repeat,
                      color: Colours.icn_white,
                    ))
              ],
            ),
            body: Row(
              children: [
                SideMenu(
                  controller: sideMenu,
                  style: SideMenuStyle(
                    // showTooltip: false,
                    displayMode: sideMenuFull
                        ? SideMenuDisplayMode.auto
                        : SideMenuDisplayMode.compact,
                    // showHamburger: true,
                    arrowCollapse: Colors.red,
                    unselectedIconColor: Colours.icn_white,
                    unselectedTitleTextStyle:
                        TextStyle(color: Colours.txt_white),
                    backgroundColor: Color(0xff124076),
                    hoverColor: Colors.blue[100],
                    selectedHoverColor: Colors.blue[100],
                    selectedColor: Colors.lightBlue,
                    selectedTitleTextStyle:
                        const TextStyle(color: Colors.white),
                    selectedIconColor: Colors.white,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    // ),
                    // backgroundColor: Colors.grey[200]
                  ),
                  title: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            // maxHeight: 150,
                            // maxWidth: 150,
                            ),
                        child: Container(
                          color: Colors.blue,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Sizer.h_50 * 2,
                                child: Image.asset(
                                  'assets/images/admin.png',
                                ),
                              ),
                              Visibility(
                                  visible: sideMenuFull,
                                  child: Txt(text: "Admin"))
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 8.0,
                        endIndent: 8.0,
                      ),
                    ],
                  ),
                  // footer: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.lightBlue[50],
                  //         borderRadius: BorderRadius.circular(12)),
                  //     child: Padding(
                  //       padding:
                  //           const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  //       child: Text(
                  //         'mohada',
                  //         style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  items: [
                    SideMenuItem(
                      title: 'Dashboard',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: Icon(
                        Iconsax.home5,
                        color: Colours.icn_white,
                      ),
                    ),
                    SideMenuItem(
                      title: 'Doctors',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Iconsax.people5,
                        color: Colours.icn_white,
                      ),
                    ),

                    SideMenuItem(
                      badgeColor: Colours.icn_white,
                      // iconWidget: Icon(Icons.abc),
                      title: 'Clinics',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Iconsax.buildings,
                        color: Colours.icn_white,
                      ),
                    ),

                    SideMenuItem(
                      title: 'Unverified Doctors',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Icons.lock_person_outlined,
                        color: Colours.icn_white,
                      ),
                    ),

                    SideMenuItem(
                      title: 'Users pharmacy',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Iconsax.shopping_bag5,
                        color: Colours.icn_white,
                      ),
                    ),

                    SideMenuItem(
                      title: 'Doctors pharmacy',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Iconsax.shopping_cart5,
                        color: Colours.icn_white,
                      ),
                    ),
                    SideMenuItem(
                      title: 'All Appointments',
                      onTap: (index, _) {
                        GetAllAppointments();
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Icons.file_copy_rounded,
                        color: Colours.icn_white,
                      ),
                    ),
                    SideMenuItem(
                      title: 'Prices',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Icons.currency_rupee_sharp,
                        color: Colours.icn_white,
                      ),
                    ),
                    SideMenuItem(
                      title: 'User Orders',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Icons.takeout_dining,
                        color: Colours.icn_white,
                      ),
                    ),
                    SideMenuItem(
                      title: 'Doctors Orders',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Icons.takeout_dining_outlined,
                        color: Colours.icn_white,
                      ),
                    ),
                    SideMenuItem(
                      builder: (context, displayMode) {
                        return const Divider(
                          endIndent: 8,
                          indent: 8,
                        );
                      },
                    ),

                    // SideMenuItem(
                    //   title: 'Settings',
                    //   onTap: (index, _) {
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(Iconsax.setting),
                    // ),
                    // SideMenuItem(
                    //   onTap:(index, _){
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(Icons.image_rounded),
                    // ),
                    // SideMenuItem(
                    //   title: 'Only Title',
                    //   onTap:(index, _){
                    //     sideMenu.changePage(index);
                    //   },
                    // ),
                    // const SideMenuItem(
                    //   title: 'Exit',
                    //   icon: Icon(Iconsax.logout),
                    //    onTap:
                    // ),
                    SideMenuItem(
                      badgeColor: Colours.icn_white,
                      // iconWidget: Icon(Icons.abc),
                      title: 'Exit',
                      onTap: (index, _) {
                        Navigator.pushReplacementNamed(context, RG.login_rt);
                      },
                      icon: Icon(Iconsax.logout),
                    ),
                  ],
                ),
                Expanded(
                    child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    Main_pg(),
                    allDocs_pg(),
                    AllClinics(),
                    UnverifiedDoctors_pg(),
                    // usersPharm(),
                    newUserPharmacy(),
                    DocProductsScreen(),
                    AllAppointments(),
                    Pricing_pg(),
                    OrdersScrn(),
                    DocOrdersScrn(),

                    // Container(
                    //   color: Colors.white,
                    //   child: const Center(
                    //     child: Text(
                    //       'Download',
                    //       style: TextStyle(fontSize: 35),
                    //     ),
                    //   ),
                    // ),

                    // this is for SideMenuItem with builder (divider)
                    const SizedBox.shrink(),

                    Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          );
  }

  List<AllDoc_model> ad = [];
  getAllDocs_async() async {
    ad = [];
    print("get all docs async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getAllDocs);
    print("url>>>>??? $url");
    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'all_docs': '1',
        'clinic_id': '0',
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      print(bdy[0]['clinic_name']);
      for (int i = 0; i < b.length; i++) {
        ad.add(
          AllDoc_model(
            ID: bdy[i]['ID'].toString(),
            name: bdy[i]['Name'].toString(),
            mobno: bdy[i]['mobile_no'].toString(),
            img: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['doctor_img'].toString(),
            img2: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img1'].toString(),
            img3: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img2'].toString(),
            img4: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img3'].toString(),
            img5: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img4'].toString(),
            mail: bdy[i]['email_id'].toString(),
            pswd: bdy[i]['pswd'].toString(),
            speciality: bdy[i]['Speciality'].toString(),
            Degree: bdy[i]['Degree'].toString(),
            clinicID: bdy[i]['clinic_id'].toString(),
            available: bdy[i]['available'].toString(),
            rating: bdy[i]['Rating'].toString(),
            verified: bdy[i]['verified'].toString(),
            idImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['ID_proof'].toString(),
            CertImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['degree_certificate'].toString(),
            CouncilCertImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['medical_council_certificate'].toString(),
            branch_doc: '0',
          ),
        );
      }
      setState(() {
        glb.Tdocs = b.length.toString();
        glb.Models.AllDocs_lst = ad;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<AllClinics_model> ac = [];
  getAllClinics_async() async {
    ac = [];
    print("get all docs async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getAllClinics);

    try {
      var res = await http.get(url);
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      print(bdy[0]['clinic_name']);
      for (int i = 0; i < b.length; i++) {
        ac.add(
          AllClinics_model(
            ID: bdy[i]['ID'].toString(),
            name: bdy[i]['clinic_name'].toString(),
            address: bdy[i]['address'].toString(),
            cityID: bdy[i]['city_id'].toString(),
            mobno: bdy[i]['mobile_no'].toString(),
            password: bdy[i]['pswd'].toString(),
            img1: "${glb.API.baseURL}images/clinic_images/" +
                bdy[i]['img1'].toString(),
            img2: "${glb.API.baseURL}images/clinic_images/" +
                bdy[i]['img2'].toString(),
            img3: "${glb.API.baseURL}images/clinic_images/" +
                bdy[i]['img3'].toString(),
            img4: "${glb.API.baseURL}images/clinic_images/" +
                bdy[i]['img4'].toString(),
            img5: "${glb.API.baseURL}images/clinic_images/" +
                bdy[i]['img5'].toString(),
          ),
        );
      }
      setState(() {
        glb.Tclinics = b.length.toString();
        glb.Models.AllClinics_lst = ac;
      });
    } catch (e) {
      print("Exception => $e");
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

  List<docProducts_model> dm = [];
  GetDocProducts_async() async {
    dm = [];

    print("get doc prod ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.get_doctor_products);
    print(url);
    try {
      var res = await http.post(url, body: {
        'doctor_id': '0',
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      for (int i = 0; i < b.length; i++) {
        dm.add(
          docProducts_model(
            id: bdy[i]['id'].toString(),
            name: bdy[i]['product_name'].toString(),
            price: bdy[i]['price'].toString(),
            img: "${glb.API.baseURL}images/doctor_pharmacy/" +
                bdy[i]['image'].toString(),
            doc_id: bdy[i]['doctor_id'].toString(),
          ),
        );
      }
      setState(() {
        glb.Models.docProducts_lst = dm;
      });
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<Appointments_model> am = [];
  GetAllAppointments() async {
    am = [];
    Uri url = Uri.parse(glb.API.baseURL + glb.API.get_all_appointments);
    print(url);
    try {
      var res = await http.get(url);

      print("body hai >> ${res.body}");

      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);

      for (int i = 0; i < b.length; i++) {
        am.add(
          Appointments_model(
              ID: bdy[i]['ID'].toString(),
              userID: bdy[i]['user_id'].toString(),
              userNM: bdy[i]['name'].toString(),
              usr_img: "${glb.API.baseURL}images/user_images/" +
                  bdy[i]['user_img'].toString(),
              clinicID: bdy[i]['clinic_id'].toString(),
              type: bdy[i]['type'].toString(),
              status: bdy[i]['status'].toString(),
              dt_time: bdy[i]['timing'].toString(),
              doc_id: bdy[i]['doctor_id'].toString(),
              usr_mail: bdy[i]['mobile_no'].toString(),
              usr_mobno: bdy[i]['email_id'].toString(),
              clinicNM: bdy[i]['branch_nm'].toString(),
              city: bdy[i]['city'].toString(),
              state: bdy[i]['state'].toString(),
              doc_nm: bdy[i]['doc_nm'].toString(),
              doc_img: "${glb.API.baseURL}images/branchDoc_images/" +
                  bdy[i]['doc_img'].toString()),
        );
      }
      setState(() {
        glb.Models.appointments_lst.clear();
        glb.Models.appointments_lst = am;
      });
    } catch (e) {}
  }

  getPharmacyPricing_async() async {
    print("get pharmacy pricing");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getPharmacyPricing);

    try {
      var res = await http.get(
        url,
      );
      var bdy = jsonDecode(res.body);

      print("PDM = ${bdy}");

      setState(() {
        glb.pharmacyPricing.price = bdy[0]['price'].toString();
        glb.pharmacyPricing.comission = bdy[0]['commission'].toString();
        glb.pharmacyPricing.applicable = bdy[0]['applicable'].toString();
      });
    } catch (e) {}
  }

  get_featuredDocpricing_async() async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getFeaturedDocPricing);

    try {
      var res = await http.get(url);

      print(res.statusCode);
      print(res.body);

      var bdy = jsonDecode(res.body);

      setState(() {
        glb.ProfilePrioritization_pricing.s1_w = bdy[0]['1s_w'].toString();
        glb.ProfilePrioritization_pricing.s2_w = bdy[0]['2s_w'].toString();
        glb.ProfilePrioritization_pricing.s3_w = bdy[0]['3s_w'].toString();

        glb.ProfilePrioritization_pricing.s1_m = bdy[0]['1s_m'].toString();
        glb.ProfilePrioritization_pricing.s2_m = bdy[0]['2s_m'].toString();
        glb.ProfilePrioritization_pricing.s3_m = bdy[0]['3s_m'].toString();
      });
    } catch (e) {}
  }
}
