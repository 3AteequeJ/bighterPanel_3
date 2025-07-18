import 'dart:convert';
import 'dart:math';

import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Clinic/SidemenuPages.dart/Branches.dart/allBranches.dart';
import 'package:bighter_panel/Clinic/appointments_pg.dart';
import 'package:bighter_panel/Clinic/SidemenuPages.dart/Doctors/doctors_pg.dart';
import 'package:bighter_panel/Clinic/clinicProfile.dart';
import 'package:bighter_panel/Clinic/settings/settings_scrn.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/Clinic/SidemenuPages.dart/dashboard/dashboard.dart';
import 'package:bighter_panel/doctor/Schedule/NewSchedule.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/DocShopProd.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Treatments/Treatments.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/docOrders.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/profile_set.dart';
import 'package:bighter_panel/doctor/orders_scrn.dart';
import 'package:bighter_panel/doctor/video_appointments.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:bighter_panel/models/BookedAppointments_model.dart';
import 'package:bighter_panel/models/BranchDocs_model.dart';
import 'package:bighter_panel/models/CartProducts_model.dart';
import 'package:bighter_panel/models/branches_model.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:responsive_sizer/responsive_sizer.dart';

import 'SidemenuPages.dart/pharmacy/PharmacyBranchDoc.dart';
// import 'package:flutter_side_menu/flutter_side_menu.dart';

class clinicHome_pg extends StatefulWidget {
  const clinicHome_pg({
    super.key,
    this.pgNO = 0,
  });
  final int pgNO;
  @override
  State<clinicHome_pg> createState() => _clinicHome_pgState();
}

class _clinicHome_pgState extends State<clinicHome_pg> {
  bool sideMenuFull = false;
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  void initState() {
    getAllDocs_async();

    if (glb.clinicRole == '0') {
      getClinicBranches_async();
    } else if (glb.clinicRole == '2') {
      GetDocCart_async();
    }
    getDocAppointments_async();
    GetDocProducts_async();
    getBookedVideoAppointments();
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    sideMenu.changePage(widget.pgNO);
    super.initState();
  }

  int pages_index = 0;
  List pages_lst1 = [
    Dashboadrd(),
    AllBranches_pg(),
    allDoctors_pg(),
    Appointments_pg(),
    Settings_scrn(),
  ];
  List pages_lst2 = [
    Dashboadrd(),
    allDoctors_pg(),
    Appointments_pg(),
    Settings_scrn(),
  ];

  List pages_lst3 = [
    Dashboadrd(),
    Appointments_pg(),
    DoctorShopProd(),
    PharmacyBranchDoc(),
    Treatments_scrn(),
    NewSchedule(),
    Settings_scrn(),
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return currentWidth <= 600
        ? Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color(0xff124076),
              centerTitle: true,
              title: Txt(
                text: "Bighter",
                size: 18,
                fontColour: Colours.orange,
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    getAllDocs_async();
                    await getDocAppointments_async();
                    Navigator.pushReplacementNamed(
                        context, RG.Clinic_homePG_rt);
                  },
                  icon: Icon(
                    Iconsax.repeat,
                    color: Colours.icn_white,
                  ),
                ),
              ],
            ),
            body: glb.clinicRole == '0'
                ? pages_lst1[pages_index]
                : glb.clinicRole == '1'
                    ? pages_lst2[pages_index]
                    : pages_lst3[pages_index],
            drawer: glb.clinicRole == '0'
                ? Drawer(
                    child: ListView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide())),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: Sizer.h_50,
                                child: SizedBox(
                                  height: Sizer.h_10 * 3,
                                  child: Image.network(
                                    glb.clinicRole == '0'
                                        ? "${glb.clinic.img1}?cache_bust=${Random().nextInt(10000)}"
                                        : glb.clinicRole == '1'
                                            ? "${glb.clinicBranch.img1}?cache_bust=${Random().nextInt(10000)}"
                                            : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                                  ),
                                ),
                              ),
                              Txt(
                                text: glb.clinicRole == '0'
                                    ? "${glb.clinic.clinic_name}"
                                    : glb.clinicRole == '1'
                                        ? "${glb.clinicBranch.clinic_name}\n${glb.clinicBranch.city}"
                                        : "${glb.clinicBranchDoc.name}",
                              ),
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
                          leading: Icon(Icons.grain_sharp),
                          title: Txt(text: "All Branches"),
                          onTap: () {
                            setState(() {
                              pages_index = 1;
                              _scaffoldKey.currentState!.openEndDrawer();
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Txt(text: "All doctors"),
                          onTap: () {
                            setState(() {
                              pages_index = 2;
                              _scaffoldKey.currentState!.openEndDrawer();
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.file_copy),
                          title: Txt(text: "Appointments"),
                          onTap: () {
                            setState(() {
                              pages_index = 3;
                              _scaffoldKey.currentState!.openEndDrawer();
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Txt(text: "Settings"),
                          onTap: () {
                            setState(() {
                              pages_index = 4;
                              _scaffoldKey.currentState!.openEndDrawer();
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Txt(text: "Logout"),
                          onTap: () {
                            Navigator.popUntil(context, (route) => false);
                          },
                        )
                      ],
                    ),
                  )
                : glb.clinicRole == '1'
                    ? Drawer(
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Sizer.h_50,
                                    child: SizedBox(
                                      height: Sizer.h_10 * 3,
                                      child: Image.network(
                                        glb.clinicRole == '0'
                                            ? "${glb.clinic.img1}?cache_bust=${Random().nextInt(10000)}"
                                            : glb.clinicRole == '1'
                                                ? "${glb.clinicBranch.img1}?cache_bust=${Random().nextInt(10000)}"
                                                : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                                      ),
                                    ),
                                  ),
                                  Txt(
                                    text: glb.clinicRole == '0'
                                        ? "${glb.clinic.clinic_name}"
                                        : glb.clinicRole == '1'
                                            ? "${glb.clinicBranch.clinic_name}\n${glb.clinicBranch.city}"
                                            : "${glb.clinicBranchDoc.name}",
                                  ),
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
                              leading: Icon(Icons.person),
                              title: Txt(text: "Doctors"),
                              onTap: () {
                                setState(() {
                                  pages_index = 1;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.file_copy),
                              title: Txt(text: "Appointments"),
                              onTap: () {
                                setState(() {
                                  pages_index = 2;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Txt(text: "Settings"),
                              onTap: () {
                                setState(() {
                                  pages_index = 3;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.logout),
                              title: Txt(text: "Logout"),
                              onTap: () {
                                Navigator.popUntil(context, (route) => false);
                              },
                            )
                          ],
                        ),
                      )
                    : Drawer(
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide())),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Sizer.h_50,
                                    child: SizedBox(
                                      height: Sizer.h_10 * 3,
                                      child: Image.network(
                                        glb.clinicRole == '0'
                                            ? "${glb.clinic.img1}?cache_bust=${Random().nextInt(10000)}"
                                            : glb.clinicRole == '1'
                                                ? "${glb.clinicBranch.img1}?cache_bust=${Random().nextInt(10000)}"
                                                : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                                      ),
                                    ),
                                  ),
                                  Txt(
                                    text: glb.clinicRole == '0'
                                        ? "${glb.clinic.clinic_name}"
                                        : glb.clinicRole == '1'
                                            ? "${glb.clinicBranch.clinic_name}\n${glb.clinicBranch.city}"
                                            : "${glb.clinicBranchDoc.name}",
                                  ),
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
                              leading: Icon(Icons.file_copy),
                              title: Txt(text: "Appointments"),
                              onTap: () {
                                setState(() {
                                  pages_index = 1;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.shop),
                              title: Txt(text: "Shop"),
                              onTap: () {
                                setState(() {
                                  pages_index = 2;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.shopping_cart),
                              title: Txt(text: "Pharmacy"),
                              onTap: () {
                                setState(() {
                                  pages_index = 3;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.folder_special),
                              title: Txt(text: "Treatments"),
                              onTap: () {
                                setState(() {
                                  pages_index = 4;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.calendar_month),
                              title: Txt(text: "Schedule"),
                              onTap: () {
                                setState(() {
                                  pages_index = 5;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Txt(text: "Settings"),
                              onTap: () {
                                setState(() {
                                  pages_index = 6;
                                  _scaffoldKey.currentState!.openEndDrawer();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.logout),
                              title: Txt(text: "Logout"),
                              onTap: () {
                                Navigator.popUntil(context, (route) => false);
                              },
                            )
                          ],
                        ),
                      ))
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
                    getAllDocs_async();
                    await getDocAppointments_async();
                    Navigator.pushReplacementNamed(
                        context, RG.Clinic_homePG_rt);
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
                                      glb.clinicRole == '0'
                                          ? "${glb.clinic.img1}?cache_bust=${Random().nextInt(10000)}"
                                          : glb.clinicRole == '1'
                                              ? "${glb.clinicBranch.img1}?cache_bust=${Random().nextInt(10000)}"
                                              : "${glb.clinicBranchDoc.img1}?cache_bust=${Random().nextInt(10000)}",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            "assets/images/clinic.png");
                                      },
                                    )),
                                Visibility(
                                  visible: sideMenuFull,
                                  child: Txt(
                                    text: glb.clinicRole == '0'
                                        ? "${glb.clinic.clinic_name}"
                                        : glb.clinicRole == '1'
                                            ? "${glb.clinicBranch.clinic_name}\n${glb.clinicBranch.city}"
                                            : "${glb.clinicBranchDoc.name}",
                                    fontColour: Colours.txt_white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                      ],
                    ),
                    items: glb.clinicRole == '0'
                        ? [
                            SideMenuItem(
                              title: 'Dashboard',
                              onTap: (index, _) {
                                sideMenu.changePage(index);
                              },
                              icon: Icon(
                                Iconsax.home5,
                                color: Colours.icn_white,
                              ),
                              tooltipContent:
                                  "This is a tooltip for Dashboard item",
                            ),
                            SideMenuItem(
                              badgeColor: Colours.icn_white,
                              // iconWidget: Icon(Icons.abc),
                              title: 'Branches',
                              onTap: (index, _) {
                                sideMenu.changePage(index);
                              },
                              icon: Icon(
                                Iconsax.tree4,
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
                              title: 'Appointments',
                              onTap: (index, _) {
                                sideMenu.changePage(index);
                              },
                              icon: const Icon(
                                Icons.file_copy_rounded,
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
                                Navigator.pushReplacementNamed(
                                    context, RG.login_rt);
                              },
                              icon: Icon(Iconsax.logout),
                            ),
                          ]
                        : glb.clinicRole == '1'
                            ? [
                                SideMenuItem(
                                  title: 'Dashboard',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: Icon(
                                    Iconsax.home5,
                                    color: Colours.icn_white,
                                  ),
                                  tooltipContent:
                                      "This is a tooltip for Dashboard item",
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
                                  title: 'Appointments',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: const Icon(
                                    Icons.file_copy_rounded,
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
                                    Navigator.pushReplacementNamed(
                                        context, RG.login_rt);
                                  },
                                  icon: Icon(Iconsax.logout),
                                ),
                              ]
                            : [
                                SideMenuItem(
                                  title: 'Dashboard',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: Icon(
                                    Iconsax.home5,
                                    color: Colours.icn_white,
                                  ),
                                  tooltipContent:
                                      "This is a tooltip for Dashboard item",
                                ),
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
                                SideMenuItem(
                                  badgeColor: Colours.icn_white,
                                  // iconWidget: Icon(Icons.abc),
                                  title: 'Schedule',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month,
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
                                SideMenuItem(
                                  badgeColor: Colours.icn_white,
                                  // iconWidget: Icon(Icons.abc),
                                  title: 'Pharmacy',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colours.icn_white,
                                  ),
                                ),
                                SideMenuItem(
                                  badgeColor: Colours.icn_white,
                                  // iconWidget: Icon(Icons.abc),
                                  title: 'Orders',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: const Icon(
                                    Icons.inventory,
                                    color: Colours.icn_white,
                                  ),
                                ),
                                SideMenuItem(
                                  badgeColor: Colours.icn_white,
                                  // iconWidget: Icon(Icons.abc),
                                  title: 'Shop',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: const Icon(
                                    Icons.shopify_sharp,
                                    color: Colours.icn_white,
                                  ),
                                ),
                                SideMenuItem(
                                  badgeColor: Colours.icn_white,
                                  // iconWidget: Icon(Icons.abc),
                                  title: 'My Orders',
                                  onTap: (index, _) {
                                    sideMenu.changePage(index);
                                  },
                                  icon: const Icon(
                                    Icons.inventory_2,
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
                                    Navigator.pushReplacementNamed(
                                        context, RG.login_rt);
                                  },
                                  icon: Icon(Iconsax.logout),
                                ),
                              ]),
                Expanded(
                    child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children: glb.clinicRole == '0'
                            ? [
                                Dashboadrd(),
                                AllBranches_pg(),
                                allDoctors_pg(),
                                Appointments_pg(),
                                // video_appointments(),
                                // this is for SideMenuItem with builder (divider)

                                Settings_scrn(),
                              ]
                            : glb.clinicRole == '1'
                                ? [
                                    Dashboadrd(),
                                    allDoctors_pg(),
                                    Appointments_pg(),
                                    // video_appointments(),
                                    // this is for SideMenuItem with builder (divider)

                                    Settings_scrn(),
                                  ]
                                : [
                                    Dashboadrd(),
                                    Appointments_pg(),
                                    // video_appointments(),
                                    NewSchedule(),
                                    Treatments_scrn(),
                                    PharmacyBranchDoc(),
                                    OrdersScrn(),
                                    DoctorShopProd(),
                                    DoctorsOrders(),
                                    // this is for SideMenuItem with builder (divider)

                                    // Settings_scrn(),
                                    Clinicprofile_settings(),
                                  ])),
              ],
            ),
          );
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

  List<BranchDoctors_model> ad = [];
  getAllDocs_async() async {
    ad = [];
    print("get all docs async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getBranchDocs);
    var body1 = {};
    if (glb.clinicRole == '0') {
      body1 = {
        'all': '1',
        'hq_id': '${glb.clinic.clinic_id}',
      };
    } else if (glb.clinicRole == '1') {
      body1 = {
        'all': '0',
        'hq_id': '${glb.clinicBranch.branch_id}',
      };
    }
    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: body1,
      );
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

  List<Appointments_model> AM = [];
  getDocAppointments_async() async {
    AM = [];
    print(" clinin getDocAppointments_async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getAppointments);
    var boody = {};
    if (glb.clinicRole == '2') {
      url = Uri.parse(glb.API.baseURL + "New_get_appointments");
      boody = {'doctor_id': '${glb.clinicBranchDoc.doc_id}', 'branch_doc': '1'};
    } else if (glb.clinicRole == '1') {
      url = Uri.parse(glb.API.baseURL + "New_get_branch_appointments");
      boody = {'branch_id': '${glb.clinicBranch.branch_id}', 'branch_doc': '1'};
    } else if (glb.clinicRole == '0') {
      url = Uri.parse(glb.API.baseURL + "New_get_clinic_appointments");
      boody = {'clinic_id': '${glb.clinic.clinic_id}', 'branch_doc': '1'};
    }

    try {
      var res = await http.post(
        url,
        headers: {
          'accept': 'application/json',
        },
        body: boody,
      );
      print(res.statusCode);
      print("sppointments body " + res.body);
      var bdy = json.decode(res.body);
      List b = json.decode(res.body);

      var tia = 0, tva = 0;
      for (int i = 0; i < b.length; i++) {
        AM.add(
          Appointments_model(
            ID: bdy[i]['app_id'].toString(),
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
            clinicNM: bdy[i]['branch_nm'].toString(),
            city: bdy[i]['city'].toString(),
            state: bdy[i]['state'].toString(),
            doc_nm: bdy[i]['doc_nm'].toString(),
            doc_img: "${glb.API.baseURL}images/branchDoc_images/" +
                bdy[i]['doc_img'].toString(),
          ),
        );
        if (bdy[i]['type'].toString() == '0') {
          tia = tia + 1;
        } else {
          tva = tva + 1;
        }
        setState(() {
          glb.Tia = tia.toString();
          glb.Tva = tva.toString();
        });
      }
      setState(() {
        glb.Models.appointments_lst = AM;
      });
    } catch (e) {
      print("Exception => ${"get clinic appointment>> " + e.toString()}");
    }
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

  List<myProducts_model> pm = [];
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
        'doc_id': "${glb.clinicBranchDoc.doc_id}",
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
            img1: bdy[i]['image'].toString(),
            img2: bdy[i]['img2'].toString(),
            img3: bdy[i]['img3'].toString(),
            img4: bdy[i]['img4'].toString(),
            img5: bdy[i]['img5'].toString(),
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
}
