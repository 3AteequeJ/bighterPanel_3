import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bighter_panel/commonScreens/addClinic.dart';
import 'package:bighter_panel/commonScreens/addDoc.dart';
import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/doctor/Register_pg.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/doctor/patientDets.dart';
import 'package:bighter_panel/doctor/profilePrioritization_pg.dart';
import 'package:bighter_panel/login.dart';
import 'package:bighter_panel/selLogin.dart';

class RG {
  static const userSel_rt = '/';
  static const login_rt = '/login';
  static const docHome_rt = '/docHome';
  static const clinicHome_rt = '/clinicHome';
  static const patientDetails_rt = '/patientDetails';
  static const addDoc_rt = '/addDoc';
  static const register_rt = '/register';
  static const addClinic_rt = '/addClinic';
  static const profilePrioritization_rt = '/profilePrioritization';

  static final router = GoRouter(
    initialLocation: userSel_rt,
    routes: [
      GoRoute(
        path: userSel_rt,
        builder: (context, state) => const UserSel(),
      ),
      GoRoute(
        path: login_rt,
        builder: (context, state) => const Login_pg(),
      ),
      GoRoute(
        path: docHome_rt,
        builder: (context, state) => const DocHome_pg(),
      ),
      GoRoute(
        path: clinicHome_rt,
        builder: (context, state) => const clinicHome_pg(),
      ),
      // GoRoute(
      //   path: patientDetails_rt,
      //   builder: (context, state) => const PatientDetails(),
      // ),
      GoRoute(
        path: addDoc_rt,
        builder: (context, state) => const addDoc(),
      ),
      GoRoute(
        path: register_rt,
        builder: (context, state) => const Register_pg(),
      ),
      GoRoute(
        path: addClinic_rt,
        builder: (context, state) => const AddClinic(),
      ),
      GoRoute(
        path: profilePrioritization_rt,
        builder: (context, state) => const ProfilePrioritization(),
      ),
    ],
  );
}
