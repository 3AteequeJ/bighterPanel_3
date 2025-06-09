import 'package:bighter_panel/Cards/AppointmentRequest_card.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AppointmentAdmin_model.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class AdminAllAppointments_card extends StatefulWidget {
  const AdminAllAppointments_card({
    super.key,
    required this.am,
    required this.filter,
  });
  final AppointAdmin_model am;
  final String filter;
  @override
  State<AdminAllAppointments_card> createState() =>
      _AdminAllAppointments_cardState();
}

class _AdminAllAppointments_cardState extends State<AdminAllAppointments_card> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.filter == 'All'
          ? true
          : widget.filter == 'Video'
              ? widget.am.typ == '1'
              : widget.filter == 'In-Clinic'
                  ? widget.am.typ == '0'
                  : widget.filter == 'Ongoing'
                      ? widget.am.status == '0'
                      : widget.filter == 'Cancled'
                          ? widget.am.status == '2'
                          : widget.filter == 'Completed'
                              ? widget.am.status == '1'
                              : false,
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Container(
          height: Sizer.h_50 * 2,
          color: widget.am.typ == '0'
              ? Colours.blue.withOpacity(.5)
              : Colours.orange.withOpacity(.5),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // todo: user row

                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                          image: DecorationImage(
                              image: NetworkImage("${widget.am.usr_img}"))),
                    ),
                    Txt(text: widget.am.usr_nm),
                  ],
                ),
                // todo: doc row
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.am.doc_img,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(text: widget.am.doc_nm),
                          Expanded(child: Txt(text: widget.am.address)),
                        ],
                      ),
                    ),
                  ],
                ),
                //todo: clinic row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Txt(
                      text: glb.getDateTIme(widget.am.Date_time),
                    ),
                    Txt(
                      text: glb.getDate(widget.am.Date_time),
                    ),
                    Txt(
                      text: getClinicNM(widget.am.Date_time),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDocNM(String doc_id) {
    String a = "t";
    for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
      if (doc_id == glb.Models.AllDocs_lst[i].ID) {
        a = glb.Models.AllDocs_lst[i].name;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getDocimg(String doc_id) {
    String a = "t";
    for (int i = 0; i < glb.Models.AllDocs_lst.length; i++) {
      if (doc_id == glb.Models.AllDocs_lst[i].ID) {
        a = glb.Models.AllDocs_lst[i].img;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }

  getClinicNM(String clinic_id) {
    String a = "t";
    for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
      if (clinic_id == glb.Models.AllClinics_lst[i].ID) {
        a = glb.Models.AllClinics_lst[i].name;
        break;
      } else {
        a = "";
      }
    }
    return a;
  }
}
