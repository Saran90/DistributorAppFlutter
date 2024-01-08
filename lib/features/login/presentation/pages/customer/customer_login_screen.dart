import 'package:distributor_app_flutter/core/widgets/app_button.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/colors.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app_config.dart';
import '../../../../../core/widgets/icon_text_field.dart';
import '../../bloc/auth/auth_cubit.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({Key? key}) : super(key: key);

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
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
            Visibility(
                visible: AppConfig.instance.flavor == AppFlavor.varsha.name,
                child: _titleWidget()),
            _userNameWidget(),
            _passwordWidget(),
            _loginButton(),
            Visibility(
                visible: AppConfig.instance.flavor == AppFlavor.varsha.name,
                child: _backButton())
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: Text(
        'Customer Login',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
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

  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: _onBackClicked,
        child: const Text(
          'Back',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
        ),
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

  _onBackClicked() {
    AppConfig.appRouter.pop();
  }
}
