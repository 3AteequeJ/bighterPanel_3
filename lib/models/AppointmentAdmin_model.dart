class AppointAdmin_model {
  late String id;
  late String usr_id;
  late String usr_nm;
  late String usr_img;
  late String doc_id;
  late String doc_nm;
  late String doc_img;
  late String branch_doc;
  late String branch_id;
  late String clinic_id;
  late String typ;
  late String address;
  late String city;
  late String state;
  late String status;
  late String Date_time;

  AppointAdmin_model({
    required this.id,
    required this.usr_id,
    required this.usr_nm,
    required this.usr_img,
    required this.doc_id,
    required this.doc_nm,
    required this.doc_img,
    required this.branch_doc,
    required this.typ,
    required this.branch_id,
    required this.clinic_id,
    required this.city,
    required this.state,
    required this.status,
    required this.Date_time,
    required this.address,
  });
}
