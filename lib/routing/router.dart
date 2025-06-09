import 'package:bighter_panel/commonScreens/addClinic.dart';
import 'package:bighter_panel/commonScreens/addDoc.dart';
import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/doctor/Register_pg.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/doctor/patientDets.dart';
import 'package:bighter_panel/doctor/profilePrioritization_pg.dart';
import 'package:bighter_panel/login.dart';
import 'package:bighter_panel/selLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RG {
  static const String userSel_rt = "userSel_rt";
  static const String login_rt = "login_rt";
  static const String Doc_homePG_rt = "Doc_homePG_rt";
  static const String Clinic_homePG_rt = "Clinic_homePG_rt";
  static const String PatientDetails_rt = "PatientDetails_rt";

  static const String AddDoc_rt = "AddDoc_rt";
  static const String register_rt = "register_rt";
  static const String AddClinic_rt = "AddClinic_rt";
  static const String profile_prioritization_rt = "profile_prioritization_rt";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userSel_rt:
        return MaterialPageRoute(builder: (_) => const UserSel());
      case Doc_homePG_rt:
        return MaterialPageRoute(builder: (_) => const DocHome_pg());
      case Clinic_homePG_rt:
        return MaterialPageRoute(builder: (_) => const clinicHome_pg());
      case login_rt:
        return MaterialPageRoute(builder: (_) => const Login_pg());
      case AddDoc_rt:
        return MaterialPageRoute(builder: (_) => const addDoc());
      case AddClinic_rt:
        return MaterialPageRoute(builder: (_) => const AddClinic());
      case register_rt:
        return MaterialPageRoute(builder: (_) => const Register_pg());
      case profile_prioritization_rt:
        return MaterialPageRoute(builder: (_) => const ProfilePrioritization());
      // case PatientDetails_rt:
      // return MaterialPageRoute(builder: (_) => const PatientDetails());
      default:
        return MaterialPageRoute(builder: (_) => const UserSel());
    }
  }
}
