import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colors.dart';

class FailedOrderItemWidget extends StatelessWidget {
  const FailedOrderItemWidget(
      {Key? key, required this.failedOrder, required this.onUploadClicked})
      : super(key: key);

  final Order failedOrder;
  final Function(int) onUploadClicked;

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
                  child: Text('${failedOrder.slNo}',style: const TextStyle(
                      fontSize: 12
                  ),),
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
                  child: Text(failedOrder.customerName,style: const TextStyle(
                      fontSize: 12
                  ),),
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
                  child: Text('${failedOrder.amount}',style: const TextStyle(
                      fontSize: 12
                  ),),
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
                  child: Text(getOrderStatusLabel(),style: const TextStyle(
                      fontSize: 12
                  ),),
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
                onTap: () {
                  if(failedOrder.status != -1){
                    onUploadClicked(failedOrder.orderId);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: failedOrder.status==-1?Colors.grey:appColorGradient2,
                      border: const Border(
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
    if (failedOrder.status == -2) {
      return 'Pending';
    } else if (failedOrder.status == 0) {
      return 'Failed';
    } else if (failedOrder.status == 2) {
      return 'Duplicate';
    } else if (failedOrder.status == -1) {
      return 'Sync Issue';
    } else {
      return 'Done';
    }
  }
}
