import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import '../../../../utils/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../app_config.dart';

class SalesUploadWidget extends StatefulWidget {
  const SalesUploadWidget({Key? key}) : super(key: key);

  @override
  State<SalesUploadWidget> createState() => _SalesUploadWidgetState();
}

class _SalesUploadWidgetState extends State<SalesUploadWidget> {
  double _uploadProgress = 0;
  bool _uploadComplete = false;
  bool _uploadFailed = false;
  bool _noOrdersAvailable = false;
  String _uploadMessage = '';
  int _uploaded = 0;
  int _failed = 0;

  @override
  void initState() {
    context.read<SalesOrderCubit>().sendSalesOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  appColorGradient1,
                  appColorGradient2
                ]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 24,
                left: 24,
                right: 24),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      height: 5,
                      width: 80,
                      margin: const EdgeInsets.only(top: 2),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30,bottom: 20),
                      child: Text(
                        'Sales Upload',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Visibility(
                      visible: _uploadComplete,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Center(
                            child: Text(
                              _uploadMessage,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ),
                    Visibility(
                      visible: !_noOrdersAvailable,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 20),
                        child: LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          lineHeight: 20.0,
                          curve: Curves.easeInCubic,
                          percent: _uploadProgress,
                          center: Text(
                            "${(_uploadProgress * 100).to2DigitFraction()}%",
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.black),
                          ),
                          barRadius: const Radius.circular(20),
                          animation: true,
                          animationDuration: 300,
                          backgroundColor: appColorGradient2,
                          progressColor: Colors.white,
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _uploadComplete && !_noOrdersAvailable,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Uploaded:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text: '$_uploaded',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800)),
                                        const TextSpan(
                                            text: '   orders',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400))
                                      ])),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Failed:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                const Expanded(flex: 1, child: SizedBox()),
                                Expanded(
                                    flex: 4,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text: '$_failed',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800)),
                                        const TextSpan(
                                            text: '   orders',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400))
                                      ])),
                                    )),
                              ],
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: AppButton(
                            startColor: appColorGradient1,
                            endColor: appColorGradient2,
                            onSubmit: () async {
                              AppConfig.appRouter.pop();
                            },
                            label: 'Close',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                BlocConsumer<SalesOrderCubit, SalesOrderState>(
                  builder: (context, state) {
                    return Container();
                  },
                  listener: (context, state) {
                    if (state is SalesOrdersLoading) {
                      setState(() {
                        _uploadComplete = false;
                        _uploadMessage =
                            'Uploading Sales Order, please wait!!!';
                      });
                    }
                    if (state is SalesOrdersSendSuccessfully) {
                      setState(() {
                        _uploadComplete = true;
                        _uploadProgress = 1;
                        _uploaded = state.uploadedOrders.length;
                        _failed = state.failedOrders.length;
                        _uploadMessage = state.message;
                      });
                    }
                    if (state is SalesOrdersSendingFailed) {
                      setState(() {
                        _uploadComplete = true;
                        _uploadFailed = true;
                        _uploadMessage = state.message;
                      });
                    }
                    if (state is NoSalesOrderAvailableForSending) {
                      setState(() {
                        _uploadComplete = true;
                        _uploadMessage = state.message;
                        _noOrdersAvailable = true;
                      });
                    }
                    if (state is SalesOrdersUploadProgress) {
                      setState(() {
                        _uploadProgress = state.progress;
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
