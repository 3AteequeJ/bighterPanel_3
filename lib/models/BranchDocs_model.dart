class BranchDoctors_model {
  late String id;
  late String branch_id;
  late String branch_nm;
  late String credentials_id;
  late String name;
  late String mobno;
  late String email;
  late String degree;
  late String speciality;
  late String img1;
  late String img2;
  late String img3;
  late String img4;
  late String img5;
  late String city;
  late String state;

  BranchDoctors_model({
    required this.id,
    required this.branch_id,
    required this.credentials_id,
    required this.name,
    required this.mobno,
    required this.email,
    required this.degree,
    required this.speciality,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.city,
    required this.state,
    required this.branch_nm,
  });
}
