import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'customer_login_screen.dart';

@RoutePage(name: 'CustomerLoginRouter')
class CustomerLoginWrapper extends StatelessWidget {
  const CustomerLoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomerLoginScreen();
  }
}
