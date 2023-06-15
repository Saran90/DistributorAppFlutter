import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';

class OrderDetailItemWidget extends StatelessWidget {
  const OrderDetailItemWidget(
      {Key? key, required this.orderItem, required this.index})
      : super(key: key);

  final HiveOrderDetailsModel orderItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text('${index + 1}',style: const TextStyle(
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
                  child: Text(
                    orderItem.productName,
                    style: const TextStyle(fontSize: 12),
                  ),
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
                  child: Text(
                    '${orderItem.mrp}',
                    style: const TextStyle(fontSize: 12),
                  ),
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
                  child: Text(
                    '${orderItem.rate}',
                    style: const TextStyle(fontSize: 12),
                  ),
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
                  child: Text(
                    '${orderItem.quantity}',
                    style: const TextStyle(fontSize: 12),
                  ),
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
                  child: Text(
                    '${orderItem.total.to2DigitFraction()}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
