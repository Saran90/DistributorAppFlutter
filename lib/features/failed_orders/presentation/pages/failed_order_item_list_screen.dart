import 'package:distributor_app_flutter/app_config.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/widgets/order_detail_item_widget.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/strings.dart';

class FailedOrdersItemListScreen extends StatefulWidget {
  const FailedOrdersItemListScreen({Key? key, required this.orderId})
      : super(key: key);

  final int orderId;

  @override
  State<FailedOrdersItemListScreen> createState() =>
      _FailedOrdersItemListScreenState();
}

class _FailedOrdersItemListScreenState
    extends State<FailedOrdersItemListScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  List<HiveOrderDetailsModel> _orderItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
                    'Order Items',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () =>
                            _showDeleteConfirmationBottomSheet(widget.orderId),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 25,
                        ))
                  ],
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: appColor,
                  toolbarHeight: 30,
                  titleSpacing: 0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsetsDirectional.only(
                      start: 10,
                    ),
                    title: Container(
                      color: appColor,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  'SNo',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 8,
                              child: Center(
                                child: Text(
                                  'Item Name',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  'MRP',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  'Rate',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  'Qty',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 4,
                              child: Center(
                                child: Text(
                                  'Total',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                _orderItems.isNotEmpty
                    ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                          OrderDetailItemWidget(
                            orderItem: _orderItems[index],
                            index: index,
                          ),
                      childCount: _orderItems.length),
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
          BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
            builder: (context, state) {
              if (state is OrderDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
            listener: (context, state) {
              if (state is OrderDetailsPopulated) {
                setState(() {
                  _orderItems = state.orderDtails;
                });
              }
              if (state is OrderSummaryFetchingFailed) {
                setState(() {
                  _orderItems = [];
                });
              }
            },
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
              if (state is OrderSummaryDeleted) {
                context.showMessage('Order Deleted!');
                AppConfig.appRouter.pop();
              }
              if (state is OrderSummaryDeletionFailed) {
                context.showMessage(state.message);
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationBottomSheet(int id) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) =>
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
                  bottom: MediaQuery
                      .of(context)
                      .viewInsets
                      .bottom,
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
                      'Order Delete',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      orderDeletionMessage,
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
                                  context
                                      .read<OrderSummaryCubit>()
                                      .deleteSummary(widget.orderId);
                                  AppConfig.appRouter.pop();
                                },
                                label: 'Delete',
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
}
