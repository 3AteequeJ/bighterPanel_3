class Appointments_model {
  late String ID;
  late String type;
  late String dt_time;
  late String status;
  late String userID;
  late String userNM;
  late String usr_img;
  late String usr_mobno;
  late String usr_mail;

  late String doc_id;
  late String doc_nm;
  late String doc_img;

  late String clinicID;
  late String clinicNM;
  late String city;
  late String state;

  Appointments_model({
    required this.ID,
    required this.userID,
    required this.userNM,
    required this.usr_img,
    required this.clinicID,
    required this.type,
    required this.status,
    required this.dt_time,
    required this.doc_id,
    required this.usr_mail,
    required this.usr_mobno,
    required this.clinicNM,
    required this.city,
    required this.state,
    required this.doc_nm,
    required this.doc_img,
  });
}
