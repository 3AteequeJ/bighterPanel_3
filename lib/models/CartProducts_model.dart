class CartProducts_Model {
  late String id;
  late String name;
  late String prod_id;
  late String price;
  late String img1;
  late String img2;
  late String img3;
  late String img4;
  late String img5;
  late String desc;
  late int quant; 

  CartProducts_Model({
    required this.id,
    required this.prod_id,
    required this.name,
    required this.price,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.desc,
    required this.quant,
  });
}
