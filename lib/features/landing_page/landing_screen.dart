import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/app_button.dart';
import '../../utils/colors.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _backgroundImage(),
            _content(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundImage() {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
        ));
  }

  Widget _content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconWidget(),
          _appNameWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  label: 'Agent Login',
                  onSubmit: _onAgentClicked,
                  startColor: appColorGradient1,
                  endColor: appColorGradient2,
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: 'Customer Login',
                  onSubmit: _onCustomerClicked,
                  startColor: appColorGradient1,
                  endColor: appColorGradient2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _iconWidget() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(AppConfig.instance.logo!))),
    );
  }

  Widget _appNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        AppConfig.instance.appName!.toUpperCase().replaceAll(' ', '\n'),
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
            height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }

  _onAgentClicked() {
    AppConfig.appRouter.push(const LoginRouter());
  }

  _onCustomerClicked() {
    AppConfig.appRouter.push(const CustomerLoginRouter());
  }
}
