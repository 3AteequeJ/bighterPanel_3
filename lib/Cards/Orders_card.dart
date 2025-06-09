import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/commonScreens/orderDets_scrn.dart';
import 'package:bighter_panel/models/allOrders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrdersCard extends StatefulWidget {
  const OrdersCard({super.key, required this.order});
  final AllordersModel order;

  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(currentWidth <= 600 ? 8.sp : 0.5.sp),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScrn(
                orderDetails: widget.order,
              ),
            ),
          );
        },
        child: Container(
          // height: 100,
          // width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Txt(text: glb.getDate(widget.order.order_date)),
                    SizedBox(
                      width: 1.w,
                    ),
                    Txt(
                      text: glb.getDateTIme(widget.order.order_date),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: currentWidth <= 600 ? 10.w : 2.w,
                      backgroundImage: NetworkImage(widget.order.user_image),
                    ),
                    SizedBox(width: 1.w),
                    Txt(
                      text: widget.order.user_name,
                      // fontSize: 14,
                      // fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Txt(
                  text: "Total: ₹ " + widget.order.total,
                  textAlignment: TextAlign.center,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Txt(
                  text: "Payment ID: " + widget.order.payment_id,
                  // fontSize: 14,
                  // fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
