import 'package:distributor_app_flutter/features/failed_orders/presentation/widgets/failed_order_item_widget.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/widgets/order_item_widget.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app_config.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../../../../../../utils/colors.dart';
import '../../../../utils/strings.dart';

class FailedOrdersListScreen extends StatefulWidget {
  const FailedOrdersListScreen({Key? key}) : super(key: key);

  @override
  State<FailedOrdersListScreen> createState() => _FailedOrdersListScreenState();
}

class _FailedOrdersListScreenState extends State<FailedOrdersListScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  List<Order> _failedOrders = [];

  @override
  void initState() {
    _loadFailedOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: _failedOrders.isNotEmpty ? 90 : 0),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: appColor,
                  pinned: true,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [appColorGradient1, appColorGradient2]),
                    ),
                  ),
                  automaticallyImplyLeading: true,
                  leadingWidth: 50,
                  centerTitle: true,
                  title: const Text(
                    'Failed Orders',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverVisibility(
                  visible: _failedOrders.isNotEmpty,
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: appColor,
                    toolbarHeight: 20,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsetsDirectional.only(
                        start: 5,
                      ),
                      title: Container(
                        color: appColor,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      'Sl.No',
                                      style: _tableHeaderStyle,
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 8,
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      'Customer Name',
                                      style: _tableHeaderStyle,
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      'Amount',
                                      style: _tableHeaderStyle,
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      'Status',
                                      style: _tableHeaderStyle,
                                    ),
                                  ),
                                )),
                            const Expanded(flex: 2, child: SizedBox()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _failedOrders.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (ctx, index) => InkWell(
                                  onTap: () async {
                                    await AppConfig.appRouter.push(
                                        FailedOrdersItemListRouter(
                                            orderId:
                                                _failedOrders[index].orderId));
                                    _loadFailedOrders();
                                  },
                                  child: FailedOrderItemWidget(
                                      failedOrder: _failedOrders[index],
                                      onUploadClicked: (id) =>
                                          _showUploadConfirmationBottomSheet(
                                              id)),
                                ),
                            childCount: _failedOrders.length),
                      )
                    : const SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No data available',
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Visibility(
            visible: _failedOrders.isNotEmpty,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 110,
                child: Column(
                  children: [_cartSummaryWidget()],
                ),
              ),
            ),
          ),
          BlocConsumer<OrderSummaryCubit, OrderSummaryState>(
            builder: (context, state) {
              if (state is OrderSummaryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is OrderSummaryPopulated) {
                setState(() {
                  _failedOrders = state.orderSummaries;
                });
              }
              if (state is OrderSummaryFetchingFailed) {
                setState(() {
                  _failedOrders = [];
                });
              }
            },
          ),
          BlocConsumer<SalesOrderCubit, SalesOrderState>(
            builder: (context, state) {
              if (state is SalesOrderLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is NoSalesOrderAvailableForSending) {
                context.showMessage(state.message);
              }
              if (state is SalesOrderSendSuccessfully) {
                context.showMessage(state.message);
                _loadFailedOrders();
              }
              if (state is SalesOrderSendingFailed) {
                context.showMessage(state.message);
              }
            },
          )
        ],
      ),
    );
  }

  Widget _cartSummaryWidget() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            appColorGradient1,
            appColorGradient2
          ]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                    flex: 6,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Total number of items:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ))),
                Expanded(
                    flex: 4,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${_failedOrders.length}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22,
                              color: Colors.white),
                        ))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(
                    flex: 6,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Gross Amount:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ))),
                Expanded(
                    flex: 4,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${_orderAmount()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22,
                              color: Colors.white),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Center(
        child: AppButton(
          startColor: appColorGradient1,
          endColor: appColorGradient2,
          label: 'Send Sales Order',
          onSubmit: _onSendClicked,
        ),
      ),
    );
  }

  double _orderAmount() {
    double totalAmount = 0;
    for (var orderItem in _failedOrders) {
      totalAmount += orderItem.amount;
    }
    return totalAmount.to2DigitFraction();
  }

  _onSendClicked() async {}

  void _onOrderUploadClicked(int id) {
    context.read<SalesOrderCubit>().sendSalesOrderUpdateForcefully(id);
  }

  Future<void> _showUploadConfirmationBottomSheet(int id) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                appColorGradient1,
                appColorGradient2
              ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 24,
              left: 24,
              right: 24),
          child: Column(
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
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Sales Upload',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  duplicateOrderUpdateMessage,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          child: AppButton(
                            startColor: appColorGradient1,
                            endColor: appColorGradient2,
                            onSubmit: () async {
                              AppConfig.appRouter.pop();
                            },
                            label: 'Cancel',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          child: AppButton(
                            startColor: appColorGradient1,
                            endColor: appColorGradient2,
                            onSubmit: () async {
                              _onOrderUploadClicked(id);
                              AppConfig.appRouter.pop();
                            },
                            label: 'Upload',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loadFailedOrders() {
    context
        .read<OrderSummaryCubit>()
        .getAllFailedOrderSummaries();
  }
}
