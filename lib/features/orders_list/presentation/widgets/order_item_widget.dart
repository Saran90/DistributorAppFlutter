import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colors.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget(
      {Key? key, required this.pendingOrder, required this.onUploadClicked})
      : super(key: key);

  final Order pendingOrder;
  final Function(int) onUploadClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text('${pendingOrder.slNo}',style: const TextStyle(
                      fontSize: 12
                  ),),
                ),
              )),
          Container(
            height: 70,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text(pendingOrder.customerName,style: const TextStyle(
                      fontSize: 12
                  ),),
                ),
              )),
          Container(
            height: 70,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text('${pendingOrder.amount.to2DigitFraction()}',style: const TextStyle(
                      fontSize: 12
                  ),),
                ),
              )),
          Container(
            height: 70,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text(getOrderStatusLabel(),style: const TextStyle(
                      fontSize: 12
                  ),),
                ),
              )),
          Container(
            height: 70,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => onUploadClicked(pendingOrder.orderId),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: appColorGradient2,
                      border: Border(
                          top: BorderSide(color: Colors.black54, width: 0.5),
                          bottom:
                              BorderSide(color: Colors.black54, width: 0.5))),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/upload.svg',
                      color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  String getOrderStatusLabel() {
    if (pendingOrder.status == -2) {
      return 'Pending';
    } else {
      return 'Done';
    }
  }
}
