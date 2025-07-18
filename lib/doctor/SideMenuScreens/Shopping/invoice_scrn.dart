import 'dart:convert';

import 'package:bighter_panel/Clinic/clinic_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/doctor/docHome_pg.dart';
import 'package:bighter_panel/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;
import 'package:razorpay_web/razorpay_web.dart';

class invoice_scrn extends StatefulWidget {
  const invoice_scrn({super.key});

  @override
  State<invoice_scrn> createState() => _invoice_scrnState();
}

class _invoice_scrnState extends State<invoice_scrn> {
  getShippingPrice_async() async {
    print("get shipping pricing");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getShippingCharge);

    try {
      var res = await http.get(url);
      var bdy = jsonDecode(res.body);

      print("PDM = ${bdy}");

      setState(() {
        glb.shippingCharge.price = bdy[0]['shipping_price'].toString();
        total_amount =
            int.parse(glb.invoiceTotal) + int.parse(glb.shippingCharge.price);
      });
    } catch (e) {}
  }

  int total_amount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShippingPrice_async();
    total_amount =
        int.parse(glb.invoiceTotal) + int.parse(glb.shippingCharge.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Txt(text: "Invoice"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          DataTable(border: TableBorder.all(), columns: [
            DataColumn(
              label: Txt(
                text: "Sl.no",
                fntWt: FontWeight.bold,
              ),
            ),
            DataColumn(
              label: Txt(
                text: "product",
                fntWt: FontWeight.bold,
              ),
            ),
            DataColumn(
              label: Txt(
                text: "Quantity",
                fntWt: FontWeight.bold,
              ),
            ),
            DataColumn(
              label: Txt(
                text: "price",
                fntWt: FontWeight.bold,
              ),
            ),
          ], rows: [
            ...glb.Invoice,
            DataRow(cells: [
              DataCell(Text('')),
              DataCell(Text('Shipping Price')),
              DataCell(Text('')),
              DataCell(Text('₹ ${glb.shippingCharge.price}')),
            ])
          ]),
          Txt(
            text:
                "Total: ${int.parse(glb.invoiceTotal) + int.parse(glb.shippingCharge.price)}",
            size: 18,
            fntWt: FontWeight.bold,
          ),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
              onPressed: () {
                razor_pay();
              },
              child: Txt(
                text: "Pay",
                fontColour: Colours.txt_white,
              ))
        ],
      ),
    );
  }

  String Payment_ID = "";
  razor_pay() {
    Razorpay razorpay = Razorpay();

    var options = {
      // rzp_live_BbZVdPkRGox44t
      'key': 'rzp_test_JUWKRLHkq2fyIe',
      'amount': total_amount * 100, // in paise
      'name': 'Bighter',
      'description': 'Medicine',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,

      'prefill': {
        'contact':
            glb.usrTyp == '1' ? glb.doctor.doc_id : glb.clinicBranchDoc.doc_id,
        'email':
            glb.usrTyp == '1' ? glb.doctor.email : glb.clinicBranchDoc.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.code.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.paymentId.toString());
    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
    setState(() {
      Payment_ID = response.paymentId.toString();
    });
    List<Map<String, String>> invoice = [];

    if (glb.usrTyp == "1") {
      for (int i = 0; i < glb.Models.CartProd_lst.length; i++) {
        invoice.add({
          "product_id": "${glb.Models.CartProd_lst[i].prod_id}",
          "doc_id": "${glb.doctor.doc_id}",
          "quantity": "${glb.Models.CartProd_lst[i].quant}",
          "price": "${glb.Models.CartProd_lst[i].price}",
          "payment_id": "${Payment_ID}",
          "branch_doc": "0",
          "shipping_price": "${glb.shippingCharge.price}",
        });
      }
    } else if (glb.usrTyp == '2') {
      for (int i = 0; i < glb.Models.CartProd_lst.length; i++) {
        invoice.add({
          "product_id": "${glb.Models.CartProd_lst[i].prod_id}",
          "doc_id": "${glb.clinicBranchDoc.doc_id}",
          "quantity": "${glb.Models.CartProd_lst[i].quant}",
          "shipping_price": "${glb.shippingCharge.price}",
          "price": "${glb.Models.CartProd_lst[i].price}",
          "payment_id": "${Payment_ID}",
          "branch_doc": "1",
        });
      }
    }

    print("Invoice>> " + jsonEncode(invoice));
    placeOrder_async(invoice);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  placeOrder_async(List<Map<String, String>> invoice) async {
    print("Placing order");
    Uri url = Uri.parse(glb.API.baseURL + "branch-doctor-order");

    try {
      var res = await http.post(
        url,
        body: {"send": jsonEncode(invoice)},
      );
      print("bdy " + res.body);
      if (res.statusCode == 200) {
        if (res.body.toString() == '1') {
          glb.SuccessToast(context, "Order placed successfully");
          remove_cart_product_async();
        }
      }
    } catch (e) {
      print("Exception=>> " + e.toString());
    }
  }

  remove_cart_product_async() async {
    print("Clearing cart");
    Uri url = Uri.parse(glb.API.baseURL + "remove_Doccart_product");
    for (int i = 0; i < glb.Models.CartProd_lst.length; i++) {
      try {
        var res = await http.post(url, headers: {
          'accept': 'application/json',
        }, body: {
          'cart_id': glb.Models.CartProd_lst[i].id,
        });
        print(res.statusCode);
        print(res.body);
        var bdy = jsonDecode(res.body);
        List b = jsonDecode(res.body);
        if (res.statusCode == 200) {}
        // print(res.body);
      } catch (e) {
        print("Exception => $e");
      }
    }
    if (glb.usrTyp == '1') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DocHome_pg(
            pgNO: 5,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => clinicHome_pg(
            pgNO: 6,
          ),
        ),
      );
    }
  }
}
