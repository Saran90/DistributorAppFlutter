import 'package:distributor_app_flutter/core/data/local_storage/models/hive_customer_model.dart';
import 'package:flutter/material.dart';

class CustomerItemWidget extends StatelessWidget {
  const CustomerItemWidget({Key? key, required this.customerModel})
      : super(key: key);

  final HiveCustomerModel customerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: const Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        customerModel.name ?? '',
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black87),
      ),
    );
  }
}
