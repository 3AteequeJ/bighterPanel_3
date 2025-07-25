import 'package:bighter_panel/Admin/SideMenuPages/docOrderDets_scrn.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/commonScreens/orderDets_scrn.dart';
import 'package:bighter_panel/models/allOrders_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrdersCard extends StatelessWidget {
  final AllordersModel order;

  const OrdersCard({super.key, required this.order, this.userOrder = true});
  final bool userOrder;
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        userOrder
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsScrn(orderDetails: order),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocOrderDetailsScrn(
                    orderDetails: order,
                  ),
                ),
              );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              )
            ],
          ),
          padding: EdgeInsets.all(12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// User Info
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: currentWidth <= 600 ? 10.w : 2.5.w,
                    backgroundImage: NetworkImage(order.user_image),
                  ),
                  SizedBox(width: 2.w),
                  Txt(
                    text: order.user_name,
                    maxLn: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              SizedBox(height: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: "Total: ₹ ${order.total}",
                    textAlignment: TextAlign.left,
                  ),
                  Txt(text: "Payment ID: ${order.payment_id}"),
                ],
              ),

              /// Top Row: Date & Time
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Txt(text: glb.getDate(order.order_date)),
                  Txt(text: glb.getDateTIme(order.order_date)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
