import 'dart:convert';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../Utilities/sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:bighter_panel/doctor/SideMenuScreens/NewAppointments/newAppointments.dart'
    as nap;

class NewAppointments_card extends StatefulWidget {
  const NewAppointments_card({
    super.key,
    required this.am,
    required this.filter,
  });
  final Appointments_model am;
  final String filter;
  @override
  State<NewAppointments_card> createState() => _NewAppointments_cardState();
}

Widget usrContainer = Container(),
    dateTime_container = Container(),
    Buttons_container = Container();

class _NewAppointments_cardState extends State<NewAppointments_card> {
  List<Widget> myContainers = [];
  @override
  void initState() {
    // TODO: implement initState

    myContainers = [usrCont(), DtCont(), btnCont()];
    if (glb.usrTyp == '2' && glb.clinicRole != '2') {
      myContainers.insert(1, docContainer());
      if (glb.clinicRole == '0') {
        myContainers.insert(2, BranchDetsCont());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: true,
      visible: widget.filter == 'All'
          ? true
          : widget.filter == 'Video'
              ? widget.am.type == '1'
              : widget.filter == 'In-Clinic'
                  ? widget.am.type == '0'
                  : widget.filter == 'Ongoing'
                      ? widget.am.status == '0'
                      : widget.filter == 'Cancled'
                          ? widget.am.status == '2'
                          : widget.filter == 'Completed'
                              ? widget.am.status == '1'
                              : false,
      child: Padding(
        padding: EdgeInsets.all(Sizer.Pad),
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(),
                left: BorderSide(
                  width: 3,
                  color: widget.am.type == '0' ? Colours.green : Colours.orange,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(Sizer.Pad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: myContainers,
              ),
            )),
      ),
    );
  }

  docContainer() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 200,
      ),
      child: Row(
        children: [
          // todo doc img
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colours.txt_grey,
              image: DecorationImage(
                onError: (exception, stackTrace) {
                  AssetImage("assets/images/user.png");
                },
                image: NetworkImage(widget.am.doc_img),
              ),
            ),
          ),
          Txt(text: widget.am.doc_nm)
        ],
      ),
    );
  }

  BranchDetsCont() {
    return Container(
      child: Row(
        children: [
          Icon(Icons.location_on_outlined),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(text: widget.am.clinicNM),
              Txt(text: widget.am.city),
              Txt(text: widget.am.state),
            ],
          ),
        ],
      ),
    );
  }

  usrCont() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 200,
      ),
      child: Row(
        children: [
          // todo usr img
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colours.txt_grey,
              image: DecorationImage(
                onError: (exception, stackTrace) {
                  AssetImage("assets/images/user.png");
                },
                image: NetworkImage(widget.am.usr_img),
              ),
            ),
          ),

          Expanded(
              child: Txt(
            text: widget.am.userNM,
            maxLn: 1,
          ))
        ],
      ),
    );
  }

  DtCont() {
    return Container(
      child: Row(
        children: [
          Icon(Icons.calendar_month_outlined),
          Column(
            children: [
              Txt(text: glb.getDateTIme(widget.am.dt_time)),
              Txt(text: glb.getDate(widget.am.dt_time)),
            ],
          )
        ],
      ),
    );
  }

  btnCont() {
    return widget.am.status == '0'
        ? Container(
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.Red,
                  ),
                  onPressed: () {
                    glb.ConfirmationBox(
                        context, "Do you want to cancle this appointment", () {
                      updtSts_async(widget.am.ID, '2');
                    });
                  },
                  child: Txt(text: "Cancle"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    glb.ConfirmationBox(context,
                        "Do you want to mark this appointment satus as completed",
                        () {
                      updtSts_async(widget.am.ID, '1');
                    });
                  },
                  child: Txt(text: "Completed"),
                ),
              ],
            ),
          )
        : widget.am.status == '1'
            ? Txt(
                text: "Completed",
                fontColour: Colours.green,
                fntWt: FontWeight.bold,
                size: 18,
              )
            : widget.am.status == '2'
                ? Txt(
                    text: "Cancled",
                    fontColour: Colours.Red,
                    fntWt: FontWeight.bold,
                    size: 18,
                  )
                : Column(
                    children: [
                      Txt(
                        text: "Time Up",
                        fontColour: Colours.HunyadiYellow,
                        fntWt: FontWeight.bold,
                        size: 18,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          glb.ConfirmationBox(context,
                              "Do you want to mark this appointment satus as completed",
                              () {
                            updtSts_async(widget.am.ID, '1');
                          });
                        },
                        child: Txt(text: "Completed"),
                      ),
                    ],
                  );
  }

  updtSts_async(String id, String sts) async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.update_status);

    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'app_id': "${id}",
        'sts': '$sts',
      });
      print(res.statusCode);
      print(res.body);
      var bdy = json.decode(res.body);
      print("status stscode = ${res.statusCode}");
      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);
        if (glb.usrTyp == '1') {
          getDocAppointments_async();
        } else if (glb.usrTyp == '2') {
          getDocAppointments1_async();
        }
      }
    } catch (e) {
      print("Exception => $e");
    }
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
              dt_time: bdy[i]['timing'].toString(),
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
              doc_img: bdy[i]['doc_img'].toString(),
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

  getDocAppointments1_async() async {
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
            dt_time: bdy[i]['timing'].toString(),
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
}
