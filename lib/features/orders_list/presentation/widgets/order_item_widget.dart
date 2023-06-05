import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget(
      {Key? key, required this.pendingOrder})
      : super(key: key);

  final Order pendingOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
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
                  child: Text('${pendingOrder.slNo}'),
                ),
              )),
          Container(
            height: 60,
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
                  child: Text(pendingOrder.customerName),
                ),
              )),
          Container(
            height: 60,
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
                  child: Text('${pendingOrder.amount}'),
                ),
              )),
          Container(
            height: 60,
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
                  child: Text(getOrderStatusLabel()),
                ),
              )),
        ],
      ),
    );
  }

  String getOrderStatusLabel() {
    if(pendingOrder.status==0){
      return 'Pending';
    }else{
      return 'Done';
    }
  }
}
