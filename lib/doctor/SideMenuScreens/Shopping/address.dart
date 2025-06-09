import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/SideMenuScreens/Shopping/invoice_scrn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class Address_Scrn extends StatefulWidget {
  const Address_Scrn({super.key});

  @override
  State<Address_Scrn> createState() => _Address_ScrnState();
}

class _Address_ScrnState extends State<Address_Scrn> {
  TextEditingController nm_cont = TextEditingController();
  TextEditingController mobno_cont = TextEditingController();
  TextEditingController mail_cont = TextEditingController();
  TextEditingController pswd_cont = TextEditingController();
  TextEditingController address_cont = TextEditingController();
  bool isHid = true;
  @override
  void initState() {
    setState(() {
      if (glb.usrTyp == '1') {
        nm_cont.text = glb.doctor.name;
        mobno_cont.text = glb.doctor.mobile_no;
        mail_cont.text = glb.doctor.email;
        pswd_cont.text = glb.doctor.pswd;
        address_cont.text = glb.doctor.address;
      } else if (glb.usrTyp == '2') {
        nm_cont.text = glb.clinicBranchDoc.name;
        mobno_cont.text = glb.clinicBranchDoc.mobile_no;
        mail_cont.text = glb.clinicBranchDoc.email;
        pswd_cont.text = glb.clinicBranchDoc.pswd;
        address_cont.text = glb.clinicBranchDoc.address;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Txt(text: "Confirm address"),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizer.Pad),
        child: Column(
          children: [
            Expanded(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  // todo: name
                  w200SizedBox(
                    wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                    child: TextField(
                      controller: nm_cont,
                      decoration: InputDecoration(
                        labelText: "Doctor name",
                        hoverColor: Colours.HunyadiYellow,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  // todo: email tf
                  w200SizedBox(
                    wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                    child: TextField(
                      controller: mail_cont,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hoverColor: Colours.HunyadiYellow,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  // todo: mobno tf
                  w200SizedBox(
                    wd: (3.255 * 6).w,
                    child: TextField(
                      controller: mobno_cont,
                      decoration: InputDecoration(
                        labelText: "Mobile number",
                        hoverColor: Colours.HunyadiYellow,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Sizer.radius_10 / 5),
                        ),
                      ),
                    ),
                  ),
                  // todo: address
                  SizedBox(
                    width: currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
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
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => invoice_scrn()));
                },
                child: Txt(text: "Proceed"))
          ],
        ),
      ),
    );
  }
}
