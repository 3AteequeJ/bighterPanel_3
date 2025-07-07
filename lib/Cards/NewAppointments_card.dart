import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class NewAppointments_card extends StatefulWidget {
  final Appointments_model appointment;
  final String filter;

  const NewAppointments_card({
    super.key,
    required this.appointment,
    required this.filter,
  });

  @override
  State<NewAppointments_card> createState() => _NewAppointments_cardState();
}

class _NewAppointments_cardState extends State<NewAppointments_card> {
  final List<Widget> _containers = [];
  final List<Appointments_model> _appointments = [];

  @override
  void initState() {
    super.initState();
    _buildContainers();
  }

  void _buildContainers() {
    _containers.addAll([
      _userContainer(),
      _dateTimeContainer(),
      _buttonsContainer(),
    ]);

    if (glb.usrTyp == '2' && glb.clinicRole != '2') {
      _containers.insert(1, _doctorContainer());
      if (glb.clinicRole == '0') {
        _containers.insert(2, _branchDetailsContainer());
      }
    }
  }

  bool _shouldDisplay() {
    final appointment = widget.appointment;
    final filter = widget.filter;

    if (filter == 'All') return true;
    if (filter == 'Video') return appointment.type == '1';
    if (filter == 'In-Clinic') return appointment.type == '0';
    if (filter == 'Ongoing') return appointment.status == '0';
    if (filter == 'Canceled') return appointment.status == '2';
    if (filter == 'Completed') return appointment.status == '1';

    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldDisplay()) return const SizedBox();

    return Padding(
      padding: EdgeInsets.all(Sizer.Pad),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                width: 4,
                color: widget.appointment.type == '0'
                    ? Colours.green
                    : Colours.orange,
              ),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(Sizer.Pad),
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: _containers,
            ),
          ),
        ),
      ),
    );
  }

  Widget _userContainer() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _circleImage(widget.appointment.usr_img),
          const SizedBox(width: 10),
          Txt(
            text: widget.appointment.userNM,
            maxLn: 1,
            fntWt: FontWeight.w500,
          ),
        ],
      );

  Widget _doctorContainer() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _circleImage(widget.appointment.doc_img),
          const SizedBox(width: 10),
          Txt(text: widget.appointment.doc_nm),
        ],
      );

  Widget _branchDetailsContainer() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_outlined),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(text: widget.appointment.clinicNM),
              Txt(text: widget.appointment.city),
              Txt(text: widget.appointment.state),
            ],
          ),
        ],
      );

  Widget _dateTimeContainer() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month_outlined),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(text: glb.getDateTIme(widget.appointment.dt_time)),
              Txt(text: glb.getDate(widget.appointment.dt_time)),
            ],
          ),
        ],
      );

  Widget _buttonsContainer() {
    final status = widget.appointment.status;

    if (status == '0') {
      return Wrap(
        spacing: 10,
        children: [
          _statusButton("Cancel", Colours.Red, () {
            _confirmStatusUpdate(
                '2', "Do you want to cancel this appointment?");
          }),
          _statusButton("Completed", Colours.green, () {
            _confirmStatusUpdate(
                '1', "Do you want to mark this appointment as completed?");
          }),
        ],
      );
    } else if (status == '1') {
      return _statusLabel("Completed", Colours.green);
    } else if (status == '2') {
      return _statusLabel("Canceled", Colours.Red);
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _statusLabel("Time Up", Colours.HunyadiYellow),
          const SizedBox(height: 5),
          _statusButton("Completed", Colours.green, () {
            _confirmStatusUpdate(
                '1', "Do you want to mark this appointment as completed?");
          }),
        ],
      );
    }
  }

  Widget _statusButton(String text, Color color, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onTap,
      child: Txt(text: text),
    );
  }

  Widget _statusLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Txt(
        text: text,
        fontColour: color,
        fntWt: FontWeight.bold,
        size: 16,
      ),
    );
  }

  Widget _circleImage(String url) {
    return ClipOval(
      child: Image.network(
        url,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Image.asset("assets/images/user.png", height: 50, width: 50),
      ),
    );
  }

  void _confirmStatusUpdate(String status, String message) {
    glb.ConfirmationBox(context, message, () {
      _updateStatus(widget.appointment.ID, status);
    });
  }

  Future<void> _updateStatus(String id, String status) async {
    final url = Uri.parse(glb.API.baseURL + glb.API.update_status);

    try {
      final res = await http.post(
        url,
        headers: {'accept': 'application/json'},
        body: {'app_id': id, 'sts': status},
      );

      if (res.statusCode == 200) {
        glb.SuccessToast(context, "Done");
        Navigator.pop(context);

        if (glb.usrTyp == '1') {
          await getDocAppointmentsAsync();
        } else if (glb.usrTyp == '2') {
          await getDocAppointments1Async();
        }
      }
    } catch (e) {
      print("Update status exception: $e");
    }
  }

  List<Appointments_model> AM = [];
  getDocAppointmentsAsync() async {
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

  getDocAppointments1Async() async {
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
