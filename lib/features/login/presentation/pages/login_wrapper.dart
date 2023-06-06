import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

@RoutePage(name: 'LoginRouter')
class LoginWrapper extends StatelessWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
