import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/Pharmacy.dart';
import 'package:bighter_panel/doctor/Schedule/NewSchedule.dart';
import 'package:bighter_panel/doctor/Schedule/schedule.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/NewAppointments/newAppointments.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Pharmacy/newPharmacy.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Treatments/Treatments.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/docOrders.dart';
import 'package:bighter_panel/doctor/dashboard.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/ic_aptmnt.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/profile_set.dart';
import 'package:bighter_panel/doctor/orders_scrn.dart';
import 'package:bighter_panel/doctor/video_appointments.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:bighter_panel/models/BookedAppointments_model.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/DocShopProd.dart';
import 'package:bighter_panel/models/CartProducts_model.dart';
import 'package:bighter_panel/models/myFeaturedProducts_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class DocHome_pg extends StatefulWidget {
  const DocHome_pg({
    super.key,
    this.pgNO = 0,
  });
  final int pgNO;
  @override
  State<DocHome_pg> createState() => _DocHome_pgState();
}

class _DocHome_pgState extends State<DocHome_pg> {
  final player = AudioPlayer();

  int pages_index = 0;
  List pages_lst = [
    DocDashboard(),
    NewAppointments(),
    NewSchedule(),
    Treatments_scrn(),
    newPharmacy(),
    OrdersScrn(),
    DoctorShopProd(),
    profile_settings(),
  ];
  Future<void> playado(String src) async {
    await player.play(AssetSource("assets/audio/noti.mp3"));
  }

  bool sideMenuFull = false;
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    sideMenu.changePage(widget.pgNO);
    getDocAppointments_async();
    getMy_featured_product();
    GetDocProducts_async();
    GetDocCart_async();
    getBookedVideoAppointments();
    featuredDoc_async();
    getPharmacyPricing_async();
  }

  featuredDoc_async() async {
    print("featuredDoc_async");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.featuredDoc);

    print(glb.doctor.doc_id);
    print(glb.usrTyp == '1' ? "0" : "1");
    try {
      var res = await http.post(url, body: {
        'doc_id': glb.doctor.doc_id,
        'branch_doc': glb.usrTyp == '1' ? "0" : "1",
      });
      print("fd stat code: ${res.statusCode}");
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      if (b.isNotEmpty) {
        setState(() {
          glb.featuredDoc = true;
        });
      }
      print("Featured doc body vvvvvvvvv\n$bdy");
    } catch (e) {}
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return currentWidth <= 600
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Sizer.h_50,
                          child: SizedBox(
                            height: Sizer.h_10 * 3,
                            child: Image.network(
                              glb.doctor.img,
                            ),
                          ),
                        ),
                        Txt(text: glb.doctor.name)
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
                    leading: Icon(MdiIcons.folderAlert),
                    title: Txt(text: "All Appointments"),
                    onTap: () {
                      setState(() {
                        pages_index = 1;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.clock),
                    title: Txt(text: "Schedule"),
                    onTap: () {
                      setState(() {
                        pages_index = 2;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.medication),
                    title: Txt(text: "Treatments"),
                    onTap: () {
                      setState(() {
                        pages_index = 3;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.cart),
                    title: Txt(text: "Pharmacy"),
                    onTap: () {
                      setState(() {
                        pages_index = 4;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.shopping),
                    title: Txt(text: "Shop"),
                    onTap: () {
                      setState(() {
                        pages_index = 5;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.shopping),
                    title: Txt(text: "Settings"),
                    onTap: () {
                      setState(() {
                        pages_index = 6;
                        _scaffoldKey.currentState!.openEndDrawer();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.account),
                    title: Txt(text: "Profile"),
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
                  onPressed: () async {
                    // playado("d");
                    await getDocAppointments_async();
                    Navigator.pushReplacementNamed(context, RG.Doc_homePG_rt);
                  },
                  icon: Icon(
                    Iconsax.repeat,
                    color: Colours.icn_white,
                  ),
                ),
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
                          // color: Colors.blue,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Sizer.h_50 * 2,
                                child: Image.network(
                                  '${glb.doctor.img}?cache_bust=${Random().nextInt(10000)}',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset("assets/images/doc.png");
                                  },
                                ),
                              ),
                              Visibility(
                                  visible: sideMenuFull,
                                  child: Txt(
                                    text: "${glb.doctor.name}",
                                    fontColour: Colours.txt_white,
                                    fntWt: FontWeight.bold,
                                  ))
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
                    // SideMenuItem(
                    //   badgeColor: Colours.icn_white,
                    //   // iconWidget: Icon(Icons.abc),
                    //   title: 'Inclinic Appointments',
                    //   onTap: (index, _) {
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(
                    //     Icons.file_copy_rounded,
                    //     color: Colours.icn_white,
                    //   ),
                    // ),
                    SideMenuItem(
                      badgeColor: Colours.icn_white,
                      // iconWidget: Icon(Icons.abc),
                      title: 'Appointments',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Icons.file_copy_rounded,
                        color: Colours.icn_white,
                      ),
                    ),
                    // SideMenuItem(
                    //   badgeColor: Colours.icn_white,
                    //   // iconWidget: Icon(Icons.abc),
                    //   title: 'Video Appointments',
                    //   onTap: (index, _) {
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(
                    //     Iconsax.monitor_mobbile,
                    //     color: Colours.icn_white,
                    //   ),
                    // ),
                    // SideMenuItem(
                    //   badgeColor: Colours.icn_white,
                    //   // iconWidget: Icon(Icons.abc),
                    //   title: 'Schedule',
                    //   onTap: (index, _) {
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(
                    //     Iconsax.calendar,
                    //     color: Colours.icn_white,
                    //   ),
                    // ),
                    SideMenuItem(
                      badgeColor: Colours.icn_white,
                      // iconWidget: Icon(Icons.abc),
                      title: 'Schedule',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Iconsax.calendar5,
                        color: Colours.icn_white,
                      ),
                    ),
                    SideMenuItem(
                      badgeColor: Colours.icn_white,
                      // iconWidget: Icon(Icons.abc),
                      title: 'Treatments',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Iconsax.box,
                        color: Colours.icn_white,
                      ),
                    ),
                    // SideMenuItem(
                    //   badgeColor: Colours.icn_white,
                    //   // iconWidget: Icon(Icons.abc),
                    //   title: 'old Pharmacy',
                    //   onTap: (index, _) {
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(
                    //     Iconsax.shopping_bag5,
                    //     color: Colours.icn_white,
                    //   ),
                    // ),
                    SideMenuItem(
                      badgeColor: Colours.icn_white,
                      // iconWidget: Icon(Icons.abc),
                      title: 'Pharmacy',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(
                        Iconsax.shopping_bag5,
                        color: Colours.icn_white,
                      ),
                    ),

                    SideMenuItem(
                      title: 'Orders',
                      onTap: (index, _) {
                        print("index = $index");
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.inventory_2),
                    ),
                    SideMenuItem(
                      builder: (context, displayMode) {
                        return const Divider(
                          endIndent: 8,
                          indent: 8,
                        );
                      },
                    ),
                    SideMenuItem(
                      title: 'Shop',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.shopify),
                    ),
                    SideMenuItem(
                      title: 'My orders',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.inventory),
                    ),

                    SideMenuItem(
                      builder: (context, displayMode) {
                        return const Divider(
                          endIndent: 8,
                          indent: 8,
                        );
                      },
                    ),
                    SideMenuItem(
                      title: 'Settings',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Iconsax.setting),
                    ),
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
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    DocDashboard(),
                    NewAppointments(),
                    NewSchedule(),
                    Treatments_scrn(),
                    newPharmacy(),
                    OrdersScrn(),
                    Container(),
                    DoctorShopProd(),
                    DoctorsOrders(),
                    Container(),
                    profile_settings(),
                  ],
                )),
              ],
            ),
          );
  }

  List<Appointments_model> AM = [];
  getDocAppointments_async() async {
    AM = [];
    print("getDocAppointments_async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getDocAppointments);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'all': '1',
        'doctor_id': "${glb.doctor.doc_id}",
      });
      print(res.statusCode);
      print(res.body);
      var bdy = json.decode(res.body);
      List b = json.decode(res.body);
      print(bdy[0]['status']);
      var tia = 0, tva = 0;
      for (int i = 0; i < b.length; i++) {
        setState(() {
          AM.add(
            Appointments_model(
              ID: bdy[i]['ID'].toString(),
              userID: bdy[i]['user_id'].toString(),
              userNM: bdy[i]['name'].toString(),
              clinicID: bdy[i]['clinic_id'].toString(),
              dt_time:
                  bdy[i]['date'].toString() + ' ' + bdy[i]['timing'].toString(),
              usr_img: "${glb.API.baseURL}images/user_images/" +
                  bdy[i]['user_img'].toString(),
              type: bdy[i]['type'].toString(),
              status: bdy[i]['status'].toString(),
              doc_id: bdy[i]['doctor_id'].toString(),
              usr_mail: bdy[i]['mobile_no'].toString(),
              usr_mobno: bdy[i]['email_id'].toString(),
              clinicNM: '',
              city: '',
              state: '',
              doc_nm: '',
              doc_img: '',
            ),
          );
          if (bdy[i]['type'].toString() == '0') {
            tia = tia + 1;
          } else {
            tva = tva + 1;
          }
          glb.Tia = tia.toString();
          glb.Tva = tva.toString();
        });
      }
      setState(() {
        // pageController.jumpToPage(1);
        glb.Models.appointments_lst = AM;
        // Navigator.pushReplacementNamed(context, RG.Doc_homePG_rt);
        // pageController.jumpToPage(0);
      });
    } catch (e) {
      print("Exception => $e");
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

  List<BookedAppointments_model> bam = [];
  getBookedVideoAppointments() async {
    bam = [];
    print("get book ");
    // Uri url = Uri.parse(glb.API.baseURL + "book_video_slot");
    Uri url = Uri.parse(glb.API.baseURL + "get_video_slot");
    print(url);
    try {
      var res = await http.post(url, body: {
        'doctor_id':
            '${glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id}',
        'date': "${glb.getDate_sys(DateTime.now().toString())}",
        'branch_doc': '${glb.usrTyp == '1' ? '0' : '1'}',
        // "slot_time": "2024-04-29 09:30:00"
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      for (int i = 0; i < b.length; i++) {
        bam.add(BookedAppointments_model(
            ID: bdy[i]['id'].toString(), time: bdy[i]['slot_time'].toString()));
      }
      setState(() {
        glb.Models.BookedAppointments_lst = bam;
      });
      print(bdy);
      print(b.length);
    } catch (e) {
      print("Exception => $e");
    }
  }

  List<MyFeaturedProducts_model> fpm = [];
  getMy_featured_product() async {
    print("get admin prod ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.get_doc_FP);
    print(url);
    try {
      var res = await http.post(url, body: {
        'doc_id': '${glb.doctor.doc_id}',
      });
      print(res.body);
      List b = jsonDecode(res.body);
      var bdy = jsonDecode(res.body);
      if (res.statusCode == 200) {
        // glb.SuccessToast(context, "Done");
        for (int i = 0; i < b.length; i++) {
          fpm.add(
            MyFeaturedProducts_model(
              id: bdy[i]['id'].toString(),
              prodID: bdy[i]['product_id'].toString(),
              doc_id: bdy[i]['doc_id'].toString(),
              admin_product: bdy[i]['admin_product'].toString(),
              sts: bdy[i]['status'].toString(),
            ),
          );
        }
        setState(() {
          glb.Models.myFeaturedProducts_lst = fpm;
        });
      }
    } catch (e) {
      print("Exception => $e");
    }
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
        'doc_id': "${glb.doctor.doc_id}",
        'branch_doc': '1',
      };
    }
    print("body = $bodyy");
    try {
      var res = await http.post(
        url,
        body: bodyy,
      );

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
}
