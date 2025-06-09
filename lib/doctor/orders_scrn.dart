import 'dart:convert';

import 'package:bighter_panel/Cards/Orders_card.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/allOrders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class OrdersScrn extends StatefulWidget {
  const OrdersScrn({super.key});

  @override
  State<OrdersScrn> createState() => _OrdersScrnState();
}

class _OrdersScrnState extends State<OrdersScrn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  List<AllordersModel> orders = [];
  getOrders() async {
    // Implement your logic to fetch orders here
    print("Fetching orders...");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getDocOrders);
    var res = await http.post(url, body: {
      "doc_id":
          glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
      "branch_doc": glb.usrTyp == '1' ? '0' : '1',
    });

    if (res.statusCode == 200) {
      print("Orders fetched successfully");
      print(res.body);
      orders.clear();
      var data = jsonDecode(res.body);
      for (var i in data) {
        AllordersModel order = AllordersModel(
          orderId: i['id'].toString(),
          user_id: i['user_id'].toString(),
          order_date: i['date_time'].toString(),
          user_name: i['name'].toString(),
          payment_id: i['payment_id'].toString(),
          total: i['total_amount'].toString(),
          user_image: glb.API.baseURL +
              "public/images/user_images/" +
              i['user_img'].toString(),
          user_address: i['address'].toString().replaceAll("///", ", "),
          user_mobno: i['mobile_no'].toString(),
          user_email: i['email_id'].toString(),
        );
        orders.add(order);
      }
      setState(() {});
    } else {
      print("Failed to fetch orders");
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return currentWidth <= 600
        ? Container(
            child: Txt(text: "<600>"),
          )
        : orders.isEmpty
            ? Center(
                child: Txt(text: "No orders found"),
              )
            : Container(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: orders.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.7,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return OrdersCard(order: orders[index]);
                        }),
                  ),
                ),
              );
  }
}
