import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_summary_model.dart';
import 'package:distributor_app_flutter/features/orders_list/data/datasource/models/SendSalesOrderUpdateRequest.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/widgets/order_detail_item_widget.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_config.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/strings.dart';

class OrdersItemListScreen extends StatefulWidget {
  const OrdersItemListScreen({Key? key, required this.orderId})
      : super(key: key);

  final int orderId;

  @override
  State<OrdersItemListScreen> createState() => _OrdersItemListScreenState();
}

class _OrdersItemListScreenState extends State<OrdersItemListScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  List<HiveOrderDetailsModel> _orderItems = [];

  HiveOrderSummaryModel? hiveOrderSummaryModel;

  @override
  void initState() {
    context.read<OrderSummaryCubit>().getOrderSummary(widget.orderId);
    super.initState();
  }

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
                    'Pending Order Items',
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
                  pinned: true,
                  titleSpacing: 0,
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
                            (context, index) => OrderDetailItemWidget(
                                  orderItem: _orderItems[index],
                                  index: index,
                                  editEnabled: true,
                                  onQuantityClicked: () =>
                                      _onQuantityClicked(_orderItems[index]),
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
                if (_orderItems.isEmpty) {
                  context
                      .read<OrderSummaryCubit>()
                      .deleteSummary(hiveOrderSummaryModel!.orderId);
                }
              }
              if (state is OrderDetailsFetchingFailed) {
                setState(() {
                  _orderItems = [];
                });
              }
              if (state is OrderDetailsUpdated) {
                context
                    .read<OrderDetailsCubit>()
                    .getOrderDetailsForOrder(widget.orderId);
                if (hiveOrderSummaryModel != null) {
                  _updateOrderSummary();
                  context
                      .read<OrderSummaryCubit>()
                      .updateOrderSummary(hiveOrderSummaryModel!);
                }
              }
              if (state is OrderDetailsUpdationFailed) {
                context.showMessage(state.message);
              }
              if (state is OrderDetailItemDeleted) {
                if (_orderItems.length > 1) {
                  context.showMessage('Order item deleted!');
                }
                context
                    .read<OrderDetailsCubit>()
                    .getOrderDetailsForOrder(widget.orderId);
                if (hiveOrderSummaryModel != null && _orderItems.length > 1) {
                  _updateOrderSummary();
                  context
                      .read<OrderSummaryCubit>()
                      .updateOrderSummary(hiveOrderSummaryModel!);
                }
              }
              if (state is OrderDetailItemDeletionFailed) {
                context.showMessage(state.message);
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
              if (state is OrderSummaryByIdFetched) {
                setState(() {
                  hiveOrderSummaryModel = state.hiveOrderSummaryModel;
                });
              }
              if (state is OrderSummaryByIdFetchingFailed) {
                context.showMessage(state.message);
              }
              if (state is OrderSummaryUpdated) {

              }
              if (state is OrderSummaryUpdationFailed) {
                context.showMessage(state.message);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationBottomSheet(int id) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [appColorGradient1, appColorGradient2]),
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

  void _onQuantityClicked(HiveOrderDetailsModel orderDetailsModel) {
    _showQuantitySelectionBottomSheet(orderDetailsModel, _onQuantitySelected);
  }

  void _showQuantitySelectionBottomSheet(
      HiveOrderDetailsModel orderDetailsModel,
      Function(int quantity, HiveOrderDetailsModel orderDetailsModel)
          onQuantitySelected) async {
    final quantityFieldFocusNode = FocusNode();
    final quantityController = TextEditingController();
    if (orderDetailsModel.quantity > 0) {
      quantityController.text = '${orderDetailsModel.quantity}';
    }
    quantityFieldFocusNode.requestFocus();
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [appColorGradient1, appColorGradient2]),
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
                color: Colors.white,
                height: 5,
                width: 80,
                margin: const EdgeInsets.only(top: 8),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Enter quantity',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(top: 40, bottom: 20),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    cursorColor: Colors.black87,
                    focusNode: quantityFieldFocusNode,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+'))
                    ],
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    enableInteractiveSelection: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter quantity',
                      hintStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: SizedBox(
                  height: 50,
                  child: AppButton(
                    startColor: appColorGradient1,
                    endColor: appColorGradient2,
                    onSubmit: () async {
                      if (quantityController.text.isNotEmpty) {
                        int quantity = int.parse(quantityController.text);
                        await AppConfig.appRouter.pop();
                        onQuantitySelected(quantity, orderDetailsModel);
                      } else {
                        int quantity = 0;
                        await AppConfig.appRouter.pop();
                        onQuantitySelected(quantity, orderDetailsModel);
                      }
                    },
                    label: 'Submit',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onQuantitySelected(
      int quantity, HiveOrderDetailsModel hiveOrderDetailsModel) {
    for (int i = 0; i < _orderItems.length; i++) {
      if (_orderItems[i].productId == hiveOrderDetailsModel.productId) {
        _orderItems[i].quantity = quantity;
        _orderItems[i].total = quantity * _orderItems[i].rate;
        if (quantity == 0) {
          //Delete Order item
          context
              .read<OrderDetailsCubit>()
              .deleteOrderDetailById(_orderItems[i].id);
        } else {
          //Update Order item
          context.read<OrderDetailsCubit>().updateOrderDetails(_orderItems[i]);
        }
        break;
      }
    }
  }

  void _updateOrderSummary() {
    double orderAmount = 0;
    for (int i = 0; i < _orderItems.length; i++) {
      double orderItemAmount = _orderItems[i].quantity * _orderItems[i].rate;
      orderAmount += orderItemAmount;
    }
    hiveOrderSummaryModel?.orderAmount = orderAmount;
    setState(() {});
  }
}
