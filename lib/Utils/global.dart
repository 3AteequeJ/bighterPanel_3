import 'package:bighter_panel/Admin/Models/docProducts_model.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllClinics_model.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:bighter_panel/models/AppointmentAdmin_model.dart';
import 'package:bighter_panel/models/Appointments_model.dart';
import 'package:bighter_panel/models/BookedAppointments_model.dart';
import 'package:bighter_panel/models/BranchDocs_model.dart';
import 'package:bighter_panel/models/CartProducts_model.dart';
import 'package:bighter_panel/models/DoctorShopping_model.dart';
import 'package:bighter_panel/models/Treatments_model.dart';
import 'package:bighter_panel/models/branches_model.dart';
import 'package:bighter_panel/models/myFeaturedProducts_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

class API {
  static const String baseURL = "https://rts.bighter.com/";
  static const String login = "getUser";
  static const String Clogin = "getClinic";
  static const String Dlogin = "getDoc";
  static const String AddDoc = "AddDoc";
  static const String getAllDocs = "getDoctors";
  static const String getAllClinics = "getAllClinics";
  static const String getShippingCharge = "get_shipping_charge";
  static const String AddClinic = "AddClinic";

  static const String getAppointments = "get_Appointments";
  static const String upload_clinic_img = "upload_clinic_img";
  static const String upload_doctor_images = "upload_doc_images";
  static const String new_reg_doc = "NewAddDoc";
  static const String UpdateDocVeri = "UpdateDocVeri";
  static const String UpdateClinic = "UpdateClinic";
  static const String UpdateDocDet = "UpdateDocDet";
  static const String getDocAppointments = "get_doctor_slots";
  static const String update_status = "update_status";
  static const String get_all_appointments = "get_all_appointments";
  // Pharmacy
  static const String add_admin_products = "admin_pharmacy";
  static const String add_doctor_products = "doctor_pharmacy";
  static const String add_Branchdoctor_products = "Branch_doctor_pharmacy";

  static const String get_doctor_products = "get_DocProducts";
  static const String GetAdminProducts = "get_AdminProducts";
  static const String get_BranchDocProducts = "get_BranchDocProducts";
  // tretments
  static const String getDocTreatments = "get_DocTrtmts";
  static const String addDocTreatments = "add_docTrtmnts";
  static const String updateTreatment = "updateTreatment";

  static const String del_docTrtmnts = "del_docTrtmnts";

  static const String updateAvailability = "UpdateAvailability";
  // feature
  static const String add_featured_product = "add_featured_product";
  static const String get_doc_FP = "get_doc_FP";

  static const String DelAdminSingleProdImg = "DelAdminSingleProdImg";
  static const String DelDocSingleProdImg = "DelDocSingleProdImg";

  // location
  static const String get_all_states = "get_all_states";
  static const String getCities_of_state = "getCities_of_state";

  // Add branch
  static const String AddBranch = "AddBranch";
  static const String getClinicBranches = "getClinicBranches";
  static const String getBranchDocs = "getBranchDocs";

  // delete doc
  static const String delete_doc = "delete_doc";

  static const String featuredDoc = "get_is_featured_doc";
  static const String addFeaturedDoc = "add_featured_doc";
  static const String getFeaturedDocPricing = "get_featuredDoc_pricing";
  static const String featDocSlotAvailability = "featDocSlotAvailability";
  static const String updateProfileProritizationPrice =
      "updateProfileProritizationPrice";

  static const String getPharmacyPricing = "getPharmacyPricing";
  static const String addPharmUser = "add_pharmacy_user";
  static const String updatePharmPrice = "updatePharmPrice";

  static const String UpdateAdditionalFields = "updateAF";

  static const String getDocOrders = "GetAllDocOrders";
  static const String getOrderDetails = "GetOrdersDets";

  static const String get_docOrder_summary = "get_docOrder_summary";
  static const String updateOrderStatus = "DocShiptoAdmin";
}

List<DataRow> Invoice = [];
String invoiceTotal = "";
bool featuredDoc = false;
bool pharmacy_user = false;

class shippingCharge {
  static String price = "0";
}

class Models {
  static List<AllDoc_model> AllDocs_lst = [];
  static List<AllClinics_model> AllClinics_lst = [];
  static List<Appointments_model> appointments_lst = [];
  static List<AppointAdmin_model> appointments_admin_lst = [];

  static List<myProducts_model> adminProducts_lst = [];
  static List<docProducts_model> docProducts_lst = [];
  static List<Treatments_model> Treatments_lst = [];
  static List<BookedAppointments_model> BookedAppointments_lst = [];
  static List<MyFeaturedProducts_model> myFeaturedProducts_lst = [];

  static List<Branches_model> Branches_lst = [];
  static List<BranchDoctors_model> BranchDoc_lst = [];

  static List<DoctorShop_model> DoctorShop_lst = [];
  static List<CartProducts_Model> CartProd_lst = [];
}

String usrTyp = "0"; //todo: 0- admin, 1- user, 2- clinic
String clinicRole =
    ''; //todo: 0 - HQ(Main headquarters), 1 - branch, 2 - Doctor

String Tdocs = "00";
String Tclinics = "00";
String Tva = "00";
String Tia = "00";

class clinic {
  static String clinic_id = '';
  static String usr_nm = '';
  static String credentials_id = '';
  static String clinic_name = '';
  static String contact_no = '';
  static String email_id = '';
  static String pswd = '';
  static String address = '';
  static String img1 = "";
  static String img2 = "";
  static String img3 = "";
  static String img4 = "";
  static String img5 = "";
}

class clinicBranch {
  static String usr_nm = '';
  static String pswd = '';
  static String credentials_id = '';
  static String branch_id = '';
  static String clinic_name = '';
  static String branch_name = '';
  static String contact_no = '';
  static String email_id = '';
  static String city = '';
  static String State = '';
  static String clinicAddress = '';
  static String BranchAddress = '';
  static String img1 = "";
  static String img2 = "";
  static String img3 = "";
  static String img4 = "";
  static String img5 = "";
}

class clinicBranchDoc {
  static String doc_id = "";
  static String credentials_id = "";
  static String name = "";
  static String mobile_no = "";
  static String email = "";
  static String usr_nm = "";

  static String pswd = "";
  static String branch_id = '';
  static String speciality = "";
  static String Degree = "";
  static String clinic_id = "";
  static String available = "";
  static String available_from = "";
  static String available_to = "";
  static String address = "";
  static String rating = "";
  static String img5 = "";
  static String img1 = "";
  static String img2 = "";
  static String img3 = "";
  static String img4 = "";
  static String IDProof = "";
  static String degree_certificate = "";
  static String medical_council_certificate = "";
  static String city_id = "";
  static String LocationLnk = "";
  static String fees_clinic = "";
  static String fees_online = "";
  static String personal_stmt = "";
  static String experience = "";
}

class doctor {
  static String doc_id = "";
  static String name = "";
  static String mobile_no = "";
  static String email = "";
  static String pswd = "";
  static String speciality = "";
  static String Degree = "";
  static String experience = "";
  static String LocationLnk = "";
  static String address = "";
  static String clinic_id = "";
  static String available = "";
  static String available_from = "";
  static String available_to = "";
  static String rating = "";
  static String img = "";
  static String img1 = "";
  static String img2 = "";
  static String img3 = "";
  static String img4 = "";
  static String IDProof = "";
  static String degree_certificate = "";
  static String medical_council_certificate = "";
  static String city_id = "";
  static String pharmacy_user = "";
  static String fees_clinic = "";
  static String fees_online = "";
  static String personal_stmt = "";
}

class ProfilePrioritization_pricing {
  static String s1_w = "";
  static String s2_w = "";
  static String s3_w = "";

  static String s1_m = "";
  static String s2_m = "";
  static String s3_m = "";

  static bool s1_w_ava = true;
  static bool s2_w_ava = true;
  static bool s3_w_ava = true;

  static bool s1_m_ava = true;
  static bool s2_m_ava = true;
  static bool s3_m_ava = true;
}

errorToast(BuildContext context, String msg) {
  toastification.show(
    backgroundColor: Colours.Red,
    context: context,
    type: ToastificationType.error,
    icon: Icon(
      Iconsax.information5,
      size: 6.853.h,
      color: Color.fromARGB(255, 255, 232, 23),
    ),
    title: Txt(
      text: msg,
      // fntWt: FontWeight.bold,
      size: 16,
      fontColour: Colours.txt_black,
    ),
    closeButtonShowType: CloseButtonShowType.none,
    // backgroundColor: const Color.fromARGB(255, 248, 223, 144),
    autoCloseDuration: Duration(seconds: 2),
    showProgressBar: false,
  );
}

SuccessToast(BuildContext context, String msg) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    icon: Icon(
      Icons.check,
      size: 6.853.h,
      color: Colours.green,
    ),
    title: Txt(
      text: msg,
      // fntWt: FontWeight.bold,
      size: 12,
      fontColour: Colours.txt_black,
    ),
    closeButtonShowType: CloseButtonShowType.none,
    // backgroundColor: const Color.fromARGB(255, 248, 223, 144),
    autoCloseDuration: Duration(seconds: 2),
    showProgressBar: false,
  );
}

loading(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: Sizer.h_50,
            width: Sizer.w_50 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(text: "Loading"),
                CircularProgressIndicator(
                  color: Colours.blue,
                )
              ],
            ),
          ),
        );
      });
}

getDateTIme(String str) {
  try {
    var date = DateTime.parse(str);
    // var d1 = DateTime(11,11,11);
    // var hr = DateFormat('hh').format(date);
    // var min = DateFormat('mm').format(date);
    // var a = DateFormat('a').format(date);
    var dt = DateFormat('h:mm a').format(date);
    return dt;
    // return "$hr" + ":" + "$min " + "$a";
    // return d1.toString();
  } catch (e) {
    return "__";
  }
}

getDateTIme_sys(String str) {
  var date = DateTime.parse(str);
  // var d1 = DateTime(11,11,11);
  var hr = DateFormat('HH').format(date);
  var min = DateFormat('mm').format(date);
  return "$hr" + ":" + "$min ";
  // return d1.toString();
}

getDate(String str) {
  try {
    var date = DateTime.parse(str);
    // var d1 = DateTime(11,11,11);
    var dd = DateFormat('dd').format(date);
    var yr = DateFormat('yyyy').format(date);
    var MM = DateFormat('MM').format(date);
    var a = DateFormat('a').format(date);
    return dd + "/" + MM + "/" + yr;
    // return d1.toString();
  } catch (e) {
    return "__/__";
  }
}

getDate_sys(String str) {
  var date = DateTime.parse(str);
  // var d1 = DateTime(11,11,11);
  var dd = DateFormat('yyyy-MM-dd').format(date);
  // var yr = DateFormat('yyyy').format(date);
  // var MM = DateFormat('MM').format(date);
  // var a = DateFormat('a').format(date);
  return dd;
  // return dd + "/" + MM + "/" + yr;
  // return d1.toString();
}

ConfirmationBox(BuildContext context, String msg, VoidCallback onPrsd) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Txt(
            text: "Are you sure?",
            fntWt: FontWeight.bold,
          ),
          content: Txt(text: msg),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Txt(text: "Cancle"),
            ),
            ElevatedButton(
              onPressed: onPrsd,
              child: Txt(text: "OK"),
            ),
          ],
        );
      });
}

class pharmacyPricing {
  static String price = "";
  static String comission = "";
  static String applicable = "";
}
