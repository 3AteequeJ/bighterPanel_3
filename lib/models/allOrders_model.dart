class AllordersModel {
  late String orderId;
  late String user_id;
  late String order_date;
  late String user_name;
  late String user_image;
  late String user_address;
  late String user_mobno;
  late String user_email;
  late String payment_id;
  late String total;
  AllordersModel({
    required this.orderId,
    required this.user_id,
    required this.order_date,
    required this.user_name,
    required this.user_image,
    required this.user_mobno,
    required this.user_address,
    required this.user_email,
    required this.payment_id,
    required this.total,
  });
}
