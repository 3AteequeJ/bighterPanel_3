import 'dart:convert';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/allOrders_model.dart';
import 'package:bighter_panel/models/orderDet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailsScrn extends StatefulWidget {
  const OrderDetailsScrn({super.key, required this.orderDetails});
  final AllordersModel orderDetails;
  @override
  State<OrderDetailsScrn> createState() => _OrderDetailsScrnState();
}

class _OrderDetailsScrnState extends State<OrderDetailsScrn> {
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
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getOrderDetails);

    var res = await http.post(url, body: {
      "id": widget.orderDetails.orderId,
      "admin_product": glb.usrTyp == '0'
          ? '1'
          : glb.usrTyp == '1'
              ? '0'
              : '-1',
      "doc_id": glb.usrTyp == '0'
          ? '0'
          : glb.usrTyp == '1'
              ? glb.doctor.doc_id
              : glb.clinicBranchDoc.doc_id,
    });

    if (res.statusCode == 200) {
      print("Orders fetched successfully");
      print(res.body);
      orderDetails.clear();
      var data = jsonDecode(res.body);
      for (var i in data) {
        OrderDetailsModel order = OrderDetailsModel(
          admin_prod: i['admin_product'].toString(),
          adminProd_nm: i['adminProductName'].toString(),
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
                          child: glb.usrTyp == '0'
                              ? DataTable(
                                  border: TableBorder.all(),
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.grey.shade300),
                                  columns: const [
                                    DataColumn(label: Text('Sl No')),
                                    DataColumn(label: Text('Product Name')),
                                    DataColumn(label: Text('Quantity')),
                                    DataColumn(label: Text('Price')),
                                    DataColumn(label: Text('Doctor Name')),
                                    DataColumn(label: Text('Doctor details')),
                                    DataColumn(label: Text('Doctor address')),
                                  ],
                                  rows:
                                      orderDetails.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    OrderDetailsModel product = entry.value;
                                    return DataRow(
                                      cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(product.admin_prod == '1'
                                            ? product.adminProd_nm
                                            : product.admin_prod == '0'
                                                ? product.docProd_nm
                                                : product.branchDocProd_nm)),
                                        DataCell(Text('${product.quant}')),
                                        DataCell(Text('₹${product.price}')),
                                        DataCell(Text(product.admin_prod == '1'
                                            ? "___"
                                            : product.doc_nm)),
                                        DataCell(product.admin_prod == '1'
                                            ? Txt(text: "___")
                                            : Column(
                                                children: [
                                                  Txt(
                                                      text:
                                                          "Contact no: ${product.admin_prod == '0' ? product.doc_mobno : product.branchDoc_mobno}"),
                                                  Txt(
                                                      text:
                                                          "mail: ${product.admin_prod == '0' ? product.doc_mail : product.branchDoc_mail}"),
                                                ],
                                              )),
                                        DataCell(Txt(
                                            text: product.admin_prod == '1'
                                                ? "___"
                                                : product.admin_prod == '0'
                                                    ? product.doc_address
                                                    : product
                                                        .branchDoc_address)),
                                      ],
                                    );
                                  }).toList(),
                                )
                              : DataTable(
                                  border: TableBorder.all(),
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.grey.shade300),
                                  columns: const [
                                    DataColumn(label: Text('Sl No')),
                                    DataColumn(label: Text('Product Name')),
                                    DataColumn(label: Text('Quantity')),
                                    DataColumn(label: Text('Price')),
                                  ],
                                  rows:
                                      orderDetails.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    OrderDetailsModel product = entry.value;
                                    return DataRow(
                                      cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(product.admin_prod == '1'
                                            ? product.adminProd_nm
                                            : product.admin_prod == '0'
                                                ? product.docProd_nm
                                                : product.branchDocProd_nm)),
                                        DataCell(Text('${product.quant}')),
                                        DataCell(Text('₹${product.price}')),
                                      ],
                                    );
                                  }).toList(),
                                ),
                        ),
                      ),
                    ),
                    if (glb.usrTyp != '0')
                      (orderDetails.first.status == '-2'
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
                          : orderDetails.first.status == '-1'
                              ? ElevatedButton(
                                  onPressed: () {
                                    glb.ConfirmationBox(context,
                                        'You have delivered this product/s',
                                        () {
                                      UpdateStatus_async();
                                    });
                                  },
                                  child: Txt(text: "Delivered"),
                                )
                              : Container()),
                    if (glb.usrTyp == '0')
                      (widget.orderDetails.status == '-1'
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
                                        'You have delivered this product/s',
                                        () {
                                      UpdateStatus_async();
                                    });
                                  },
                                  child: Txt(text: "Delivered"),
                                )
                              : Container()),
                  ],
                ),
              ));
  }

  UpdateStatus_async() async {
    print(widget.orderDetails.status);
    Uri url = glb.usrTyp == '0'
        ? Uri.parse(glb.API.baseURL + glb.API.OrderStatusUpdate)
        : Uri.parse(glb.API.baseURL + glb.API.updateOrderStatus);
    var res = await http.post(url,
        body: glb.usrTyp == '0'
            ? {
                "id": widget.orderDetails.orderId,
                "status": widget.orderDetails.status == '-1' ? '0' : '1',
              }
            : {
                "order_id": widget.orderDetails.orderId,
                "doc_id": glb.usrTyp == '1'
                    ? glb.doctor.doc_id
                    : glb.clinicBranchDoc.doc_id,
                'branch_doc': glb.usrTyp == '1' ? '0' : '1',
                "status": widget.orderDetails.status == '-2' ? '-1' : '0',
              });

    if (res.statusCode == 200) {
      print("Order status updated successfully");
      // getOrderDets();
      // Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => adminHome_pg(
                    pgNO: 8,
                  )));
    } else {
      print("Failed to update order status");
    }
  }
}
