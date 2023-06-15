import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/sales_order/sales_order_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/pages/models/order.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/widgets/order_item_widget.dart';
import 'package:distributor_app_flutter/utils/app_router.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../../../../core/data/local_storage/models/hive_order_summary_model.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../utils/colors.dart';
import '../widgets/sales_upload_widget.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({Key? key}) : super(key: key);

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  List<Order> _pendingOrders = [];

  @override
  void initState() {
    _getAllPendingOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(bottom: _pendingOrders.isNotEmpty ? 160 : 0),
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
                    'Pending Orders',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverVisibility(
                  visible: _pendingOrders.isNotEmpty,
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: appColor,
                    toolbarHeight: 30,
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
                                      'SNo',
                                      style: _tableHeaderStyle,
                                    ),
                                  ),
                                )),
                            Container(
                              height: 70,
                              width: 0.5,
                              color: Colors.transparent,
                            ),
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
                            Container(
                              height: 70,
                              width: 0.5,
                              color: Colors.transparent,
                            ),
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
                            Container(
                              height: 70,
                              width: 0.5,
                              color: Colors.transparent,
                            ),
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
                _pendingOrders.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => InkWell(
                                  onTap: () async {
                                    await AppConfig.appRouter.push(
                                        OrdersItemListRouter(
                                            orderId:
                                                _pendingOrders[index].orderId));
                                    _getAllPendingOrders();
                                  },
                                  child: OrderItemWidget(
                                    pendingOrder: _pendingOrders[index],
                                    onUploadClicked: (id) =>
                                        _onOrderUploadClicked(id),
                                  ),
                                ),
                            childCount: _pendingOrders.length),
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
            visible: _pendingOrders.isNotEmpty,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 160,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [appColorGradient1, appColorGradient2]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  children: [_cartSummaryWidget(), _actionButtons()],
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
                  _pendingOrders = state.orderSummaries;
                });
              }
              if (state is OrderSummaryFetchingFailed) {
                setState(() {
                  _pendingOrders = [];
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
                _getAllPendingOrders();
              }
              if (state is SalesOrderSendingFailed) {
                context.showMessage(state.message);
                _getAllPendingOrders();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _cartSummaryWidget() {
    return Container(
      height: 110,
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
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_pendingOrders.length}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
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
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_orderAmount()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white),
                      ))),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
    for (var orderItem in _pendingOrders) {
      totalAmount += orderItem.amount;
    }
    return totalAmount.to2DigitFraction();
  }

  _onSendClicked() async {
    await _showSalesUploadingBottomSheet();
    _getAllPendingOrders();
  }

  void _getAllPendingOrders() {
    context.read<OrderSummaryCubit>().getAllOrderSummaries(-2);
  }

  void _onOrderUploadClicked(int id) {
    context.read<SalesOrderCubit>().sendSalesOrderUpdate(id);
  }

  Future<void> _showSalesUploadingBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => BlocProvider<SalesOrderCubit>(
          create: (context) => AppConfig.s1(),
          child: const SalesUploadWidget(),
        ),
      ),
    );
    // FocusManager.instance.primaryFocus?.unfocus();
  }
}
