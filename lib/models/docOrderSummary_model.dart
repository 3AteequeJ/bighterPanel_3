class DocOrderSummary_model {
  late String id;
  late String status;
  late String payment_id;
  late String total_amount;
  late List<products> productsList;
  late String DateTime;

  DocOrderSummary_model({
    required this.id,
    required this.status,
    required this.payment_id,
    required this.total_amount,
    required this.productsList,
    required this.DateTime,
  });
}

class products {
  late String prod_id;
  late String prod_nm;
  late String price;
  late String quantity;
  late String img;

  products({
    required this.prod_id,
    required this.prod_nm,
    required this.price,
    required this.quantity,
    required this.img,
  });
}
