import 'dart:convert';

import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/allOrders_model.dart';
import 'package:bighter_panel/models/orderDet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class DocOrderDetailsScrn extends StatefulWidget {
  const DocOrderDetailsScrn({super.key, required this.orderDetails});
  final AllordersModel orderDetails;
  @override
  State<DocOrderDetailsScrn> createState() => _DocOrderDetailsScrnState();
}

class _DocOrderDetailsScrnState extends State<DocOrderDetailsScrn> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderDets();
  }

  List<OrderDetailsModel> orderDetails = [];
  getOrderDets() async {
    // Implement your logic to fetch orders here
    print("Fetching orders...");
    print("Order ID: ${widget.orderDetails.orderId}");
    print("User ID: ${glb.usrTyp}");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.Admin_getDocOrderDets);

    var res = await http.post(url, body: {
      "id": widget.orderDetails.orderId,
    });

    if (res.statusCode == 200) {
      print("Orders fetched successfully");
      print(res.body);
      orderDetails.clear();
      var data = jsonDecode(res.body);
      for (var i in data) {
        OrderDetailsModel order = OrderDetailsModel(
          admin_prod: i['admin_product'].toString(),
          adminProd_nm: i['product_name'].toString(),
          status: i['status'].toString(),
          docProd_nm: i['doctorProductName'].toString(),
          doc_nm: i['doctorName'].toString(),
          doc_mobno: i['doc_mobno'].toString(),
          doc_mail: i['doc_email'].toString(),
          doc_address: i['doc_address'].toString(),
          branchDocProd_nm: i['branchDocProductName'].toString(),
          branchDoc_nm: i['branchDoctorName'].toString(),
          branchDoc_mobno: i['branchDoc_mobno'].toString(),
          branchDoc_mail: i['branchDoc_email'].toString(),
          branchDoc_address: i['branchDoc_address'].toString(),
          quant: i['quantity'].toString(),
          price: i['price'].toString(),
          username: i['userName'].toString(),
        );
        orderDetails.add(order);
      }
      setState(() {
        print("fffjsnj");
        isLoading = false;
      });
    } else {
      print("Failed to fetch orders");
    }
  }

// String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 8.w,
                          width: 8.w,
                          color: Colors.grey[300],
                          child: Image.network(
                            widget.orderDetails.user_image,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                                "Customer name: " + orderDetails[0].username),
                            // Txt(text: orderDetails[0].admin_prod),
                            SelectableText("Payment ID: " +
                                widget.orderDetails.payment_id),
                            SelectableText(
                                "Total: " + widget.orderDetails.total),
                            SelectableText("Contact number: " +
                                widget.orderDetails.user_mobno),
                            SelectableText(
                              "Email: " + widget.orderDetails.user_email,
                            ),
                            SelectableText(
                                "Address: " + widget.orderDetails.user_address),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(),
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey.shade300),
                              columns: const [
                                DataColumn(label: Text('Sl No')),
                                DataColumn(label: Text('Product Name')),
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('Price')),
                              ],
                              rows: orderDetails.asMap().entries.map((entry) {
                                int index = entry.key;
                                OrderDetailsModel product = entry.value;
                                return DataRow(
                                  cells: [
                                    DataCell(Text('${index + 1}')),
                                    DataCell(Text(product.adminProd_nm)),
                                    DataCell(Text('${product.quant}')),
                                    DataCell(Text('₹${product.price}')),
                                  ],
                                );
                              }).toList(),
                            )),
                      ),
                    ),
                    Txt(text: widget.orderDetails.status),
                    widget.orderDetails.status == '-1'
                        ? ElevatedButton(
                            onPressed: () {
                              glb.ConfirmationBox(
                                  context, 'You have shipped this product/s',
                                  () {
                                UpdateStatus_async();
                              });
                            },
                            child: Txt(text: "Shipped"),
                          )
                        : widget.orderDetails.status == '0'
                            ? ElevatedButton(
                                onPressed: () {
                                  glb.ConfirmationBox(context,
                                      'You have delivered this product/s', () {
                                    UpdateStatus_async();
                                  });
                                },
                                child: Txt(text: "Delivered"),
                              )
                            : Container()
                  ],
                ),
              ));
  }

  UpdateStatus_async() async {
    print("updating order status");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.AdminDocOrderStatusUpdt);
    var res = await http.post(url, body: {
      "id": widget.orderDetails.orderId,
      "status": widget.orderDetails.status == '-1' ? '0' : '1',
    });

    if (res.statusCode == 200) {
      print("Order status updated successfully");
      getOrderDets();
      Navigator.pop(context);
    } else {
      print("Failed to update order status");
    }
  }
}
