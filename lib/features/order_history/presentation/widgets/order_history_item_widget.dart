import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/models/order_history.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/utils/colors.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';

class OrderHistoryItemWidget extends StatelessWidget {
  const OrderHistoryItemWidget(
      {Key? key,
      required this.orderItem,required this.isCustomer})
      : super(key: key);

  final OrderHistory orderItem;
  final bool isCustomer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(left: 10),
      color: Colors.white,
      child: Row(
        children: [
          if(!isCustomer) Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text(
                    '${orderItem.customerName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )),
          if(!isCustomer) Container(
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
                    '${orderItem.orderDate?.toDDMMYYYYHHMMSSFormat()}',
                    style: const TextStyle(fontSize: 12),textAlign: TextAlign.center,
                  ),
                ),
              )),
          Container(
            height: 70,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text(
                    '${orderItem.orderAmount}',
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
                    '${orderItem.status}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
