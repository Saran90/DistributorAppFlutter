import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SalesItemWidget extends StatelessWidget {
  const SalesItemWidget(
      {Key? key, required this.order, required this.onUploadClicked})
      : super(key: key);

  final Order order;
  final Function() onUploadClicked;

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
                  child: Text('${order.slNo}'),
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
                  child: Text(order.customerName),
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
                  child: Text('${order.amount}'),
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
          Container(
            height: 60,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: onUploadClicked,
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
              )),
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
