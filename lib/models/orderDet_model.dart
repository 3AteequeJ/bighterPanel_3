class OrderDetailsModel {
  late String username;
  late String admin_prod;
  late String adminProd_nm;
  late String status;
  late String docProd_nm;
  late String doc_nm;
  late String doc_mobno;
  late String doc_mail;
  late String doc_address;
  late String branchDocProd_nm;
  late String branchDoc_nm;
  late String branchDoc_mobno;
  late String branchDoc_mail;
  late String branchDoc_address;
  late String quant;
  late String price;

  OrderDetailsModel({
    required this.username,
    required this.admin_prod,
    required this.adminProd_nm,
    required this.status,
    required this.docProd_nm,
    required this.doc_nm,
    required this.doc_mobno,
    required this.doc_mail,
    required this.doc_address,
    required this.branchDocProd_nm,
    required this.branchDoc_nm,
    required this.branchDoc_mobno,
    required this.branchDoc_mail,
    required this.branchDoc_address,
    required this.quant,
    required this.price,
  });
}
