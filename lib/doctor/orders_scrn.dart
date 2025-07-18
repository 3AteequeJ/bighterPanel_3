import 'dart:convert';

import 'package:bighter_panel/Cards/Orders_card.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/allOrders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class OrdersScrn extends StatefulWidget {
  const OrdersScrn({super.key});

  @override
  State<OrdersScrn> createState() => _OrdersScrnState();
}

class _OrdersScrnState extends State<OrdersScrn> {
  List<AllordersModel> orders = [];
  List<AllordersModel> filteredOrders = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dropdownValue = orderTypes.first;
    getOrders('-1');
  }

  void getOrders(String type) async {
    print("Fetching orders...");
    Uri url = glb.usrTyp == '0'
        ? Uri.parse(glb.API.baseURL + glb.API.getAllOrders)
        : Uri.parse(glb.API.baseURL + glb.API.getDocOrders);

    var res = glb.usrTyp == '0'
        ? await http.post(url, body: {'type': type})
        : await http.post(url, body: {
            "doc_id": glb.usrTyp == '1'
                ? glb.doctor.doc_id
                : glb.clinicBranchDoc.doc_id,
            "branch_doc": glb.usrTyp == '1' ? '0' : '1',
          });
    print(res.statusCode);
    print("Response status: ${res.body}");
    if (res.statusCode == 200) {
      orders.clear();
      var data = jsonDecode(res.body);
      print(res.body);
      for (var i in data) {
        AllordersModel order = AllordersModel(
          orderId: i['id'].toString(),
          user_id: i['user_id'].toString(),
          order_date: glb.usrTyp == '0'
              ? i['order_datetime'].toString()
              : i['date_time'].toString(),
          user_name: glb.usrTyp == '0'
              ? i['user_name'].toString()
              : i['name'].toString(),
          payment_id: i['payment_id'].toString(),
          total: i['total_amount'].toString(),
          user_image: glb.API.baseURL +
              "public/images/user_images/" +
              i['user_img'].toString(),
          user_address: i['address'].toString().replaceAll("///", ", "),
          user_mobno: i['mobile_no'].toString(),
          user_email: i['email_id'].toString(),
          status: i['status'].toString(),
        );
        orders.add(order);
      }
      filteredOrders =
          List.from(orders).reversed.toList().cast<AllordersModel>();
      setState(() {});
    }
  }

  void filterOrders(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredOrders = orders.where((order) {
        return order.user_name.toLowerCase().contains(query) ||
            order.payment_id.toLowerCase().contains(query) ||
            order.total.toLowerCase().contains(query);
      }).toList();
    });
  }

  late String dropdownValue;
  List<String> orderTypes = ['New orders', 'Shipped', 'delivered'];
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= 600) {
      return Center(child: Txt(text: "<600>"));
    }

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            hint: Text('Select status'),
            items: orderTypes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                if (newValue == 'New orders') {
                  getOrders('-1');
                } else if (newValue == 'Shipped') {
                  getOrders('0');
                } else if (newValue == 'delivered') {
                  getOrders('1');
                }
              });
            },
          ),

          /// Search bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: TextField(
              controller: searchController,
              onChanged: filterOrders,
              decoration: InputDecoration(
                hintText: "Search orders...",
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 16),

          /// Orders Grid
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(child: Txt(text: "No orders found"))
                : ListView.builder(
                    itemCount: filteredOrders.length,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 4,
                    //   childAspectRatio: 1.5,
                    //   mainAxisSpacing: 10,
                    //   crossAxisSpacing: 10,
                    // ),
                    itemBuilder: (context, index) {
                      return OrdersCard(order: filteredOrders[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
