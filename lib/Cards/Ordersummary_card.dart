import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/docOrderSummary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class OrderSummary_card extends StatefulWidget {
  const OrderSummary_card({
    super.key,
    required this.om,
  });
  final DocOrderSummary_model om;

  @override
  State<OrderSummary_card> createState() => _OrderSummary_cardState();
}

class _OrderSummary_cardState extends State<OrderSummary_card> {
  @override
  void initState() {
    // TODO: implement initState
    // List templist = widget.OrdersMap.values.elementAt(widget.idx);
    // Map tempMap = templist.first;
  }

  bool _prodsExp = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizer.Pad),
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(Sizer.Pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                  text:
                      "Status: ${widget.om.status == '-1' ? "Order Placed" : widget.om.status == '0' ? "Out for Delivery" : "Delivered"}",
                ),
                Txt(
                  text: "Date: ${glb.getDate(widget.om.DateTime)}",
                  fntWt: FontWeight.bold,
                  size: 16,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _prodsExp = !_prodsExp;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(text: "Products", fontColour: Colors.blue),
                      Icon(
                        _prodsExp
                            ? CupertinoIcons.arrowtriangle_up_fill
                            : CupertinoIcons.arrowtriangle_down_fill,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _prodsExp,
                  child: Column(
                    children: widget.om.productsList.map((product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(text: product.prod_nm),
                          Txt(
                            text: "${product.price}  x${product.quantity}",
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Divider(color: Colours.divider_grey),
                Txt(
                  text: "Total: " + widget.om.total_amount,
                  size: 16,
                  fntWt: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
