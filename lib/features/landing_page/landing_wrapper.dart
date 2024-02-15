import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'landing_screen.dart';

@RoutePage(name: 'LandingRouter')
class LandingWrapper extends StatelessWidget {
  const LandingWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LandingScreen();
  }
}
