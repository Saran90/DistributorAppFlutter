import 'package:distributor_app_flutter/core/widgets/app_button.dart';
import 'package:distributor_app_flutter/features/login/presentation/bloc/manufacture/manufacture_cubit.dart';
import 'package:distributor_app_flutter/features/login/presentation/pages/models/manufacture.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/colors.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../../../../core/widgets/icon_drop_down.dart';
import '../../../../core/widgets/icon_text_field.dart';
import '../bloc/auth/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

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
            BlocConsumer<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container();
              },
              listener: (context, state) {
                if (state is Authenticated) {
                  AppConfig.appRouter.replace(const DataDownloadRouter());
                }
                if (state is AuthenticationFailed) {
                  context.showMessage(state.message);
                }
              },
            ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _appLogoWidget(),
            _userNameWidget(),
            _passwordWidget(),
            _loginButton()
          ],
        ),
      ),
    );
  }

  Widget _userNameWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: IconTextField(
        hint: 'Enter username',
        icon: 'assets/icons/user.png',
        controller: _userNameController,
        whiteBackground: false,
        textInputType: TextInputType.text,
      ),
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: IconTextField(
        hint: 'Enter password',
        icon: 'assets/icons/password.png',
        controller: _passwordController,
        whiteBackground: false,
        isPassword: true,
      ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: AppButton(
        label: 'Login',
        onSubmit: _onLoginClicked,
        startColor: appColorGradient1,
        endColor: appColorGradient2,
      ),
    );
  }

  Widget _appLogoWidget() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(AppConfig.instance.logo!))),
    );
  }

  void _onLoginClicked() {
    if (_userNameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<AuthCubit>().login(
          _userNameController.text.trim(), _passwordController.text.trim());
    } else {
      context.showMessage('Please provide required information.');
    }
  }
}
