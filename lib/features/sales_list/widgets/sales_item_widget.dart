import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';

class SalesItemWidget extends StatelessWidget {
  const SalesItemWidget(
      {Key? key, required this.order})
      : super(key: key);

  final Order order;

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
                  child: Text('${order.slNo}',style: const TextStyle(
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
                  child: Text(order.customerName,style: const TextStyle(
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
                  child: Text('${order.amount.to2DigitFraction()}',style: const TextStyle(
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
        ],
      ),
    );
  }

  String getOrderStatusLabel() {
    if (order.status == 0) {
      return 'Pending';
    } else {
      return 'Uploaded';
    }
  }
}
