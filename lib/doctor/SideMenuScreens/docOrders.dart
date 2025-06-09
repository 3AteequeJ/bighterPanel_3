import 'dart:convert';

import 'package:bighter_panel/Cards/Ordersummary_card.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/docOrderSummary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorsOrders extends StatefulWidget {
  const DoctorsOrders({super.key});

  @override
  State<DoctorsOrders> createState() => _DoctorsOrdersState();
}

class _DoctorsOrdersState extends State<DoctorsOrders> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyOrders_async();
  }

  List<DocOrderSummary_model> om = [];
  List<products> prdts = [];
  getMyOrders_async() async {
    om = [];
    Map<String, List<products>> paymentProductsMap = {};
    Map<String, DocOrderSummary_model> summaryMap = {};

    Uri url = Uri.parse(glb.API.baseURL + glb.API.get_docOrder_summary);

    try {
      var res = await http.post(url, body: {
        'doc_id':
            '${glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id}',
        'branch_doc': '${glb.usrTyp == '1' ? '0' : '1'}'
      });
      print(res.body);
      if (res.statusCode == 200) {
        var bdy = jsonDecode(res.body);

        for (int i = 0; i < bdy.length; i++) {
          final item = bdy[i];

          // Validate and fallback if missing
          String getField(dynamic key, [String fallback = '']) {
            return item[key]?.toString() ?? fallback;
          }

          String paymentId = getField('payment_id');

          final productItem = products(
            prod_id: getField('product_id'),
            prod_nm: getField('product_name'),
            price: getField('price'),
            quantity: getField('quantity'),
            img: getField('image'),
          );

          // Add product to its payment group
          paymentProductsMap.putIfAbsent(paymentId, () => []).add(productItem);

          // Create summary model if not already created
          if (!summaryMap.containsKey(paymentId)) {
            summaryMap[paymentId] = DocOrderSummary_model(
              id: getField('id'),
              payment_id: paymentId,
              total_amount: getField('total_amount'),
              DateTime: getField('date_time'),
              productsList: [],
              status: getField('summary_status'),
            );
          }
        }

        // Assign product lists to each summary model
        summaryMap.forEach((paymentId, summary) {
          summary.productsList = paymentProductsMap[paymentId]!;
          om.add(summary);
        });
      }

      setState(() {
        isLoading = false;
        print("${om.length} <= length");
      });
    } catch (e, stackTrace) {
      print("Error fetching orders: $e");
      print("Stack trace: $stackTrace");
    }
  }

  Map<String, List<Map<String, String>>> OrdersMap = {};
  addEntry(String key, Map<String, String> value) {
    if (OrdersMap.containsKey(key)) {
      OrdersMap[key]!.add(value); // Append to the existing list
    } else {
      OrdersMap[key] = [value]; // Create a new list with the value
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : om.isEmpty
            ? Center(
                child: Txt(text: "No orders found"),
              )
            : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return OrderSummary_card(
                          om: om.reversed.toList()[index],
                        );
                      },
                      childCount: om.length,
                    ),
                  ),
                ],
              );
  }
}
