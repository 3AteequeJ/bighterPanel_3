import 'dart:convert';

import 'package:bighter_panel/Cards/Orders_card.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/allOrders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class DocOrdersScrn extends StatefulWidget {
  const DocOrdersScrn({super.key});

  @override
  State<DocOrdersScrn> createState() => _DocOrdersScrnState();
}

class _DocOrdersScrnState extends State<DocOrdersScrn> {
  List<AllordersModel> orders = [];
  List<AllordersModel> filteredOrders = [];
  TextEditingController searchController = TextEditingController();

  List<String> orderTypes = ['New orders', 'Shipped', 'delivered'];
  late String dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = orderTypes.first;

    getOrders('-1');
  }

  void getOrders(String type) async {
    Uri url = Uri.parse(glb.API.baseURL + glb.API.Admin_getDocOrdersummary);

    var res = await http.post(url, body: {
      "type": type,
    });

    if (res.statusCode == 200) {
      orders.clear();
      var data = jsonDecode(res.body);
      for (var i in data) {
        AllordersModel order = AllordersModel(
          orderId: i['id'].toString(),
          user_id: i['doc_id'].toString(),
          order_date: i['date_time'].toString(),
          user_name: i['doctor_name'].toString(),
          payment_id: i['payment_id'].toString(),
          total: i['total_amount'].toString(),
          user_image: i['branch_doc'].toString() == '0'
              ? (glb.API.baseURL +
                  "public/images/doctor_images/" +
                  i['user_img'].toString())
              : (glb.API.baseURL +
                  "public/images/branchDoc_images/" +
                  i['user_img'].toString()),
          user_address: i['address'].toString().replaceAll("///", ", "),
          user_mobno: i['mob_no'].toString(),
          user_email: i['email'].toString(),
          status: i['status'].toString(),
        );
        orders.add(order);
      }
      filteredOrders = List.from(orders);
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
                : GridView.builder(
                    itemCount: filteredOrders.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return OrdersCard(
                        order: filteredOrders[index],
                        userOrder: false,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
