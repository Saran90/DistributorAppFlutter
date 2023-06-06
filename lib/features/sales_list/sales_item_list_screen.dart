import 'package:distributor_app_flutter/core/data/local_storage/models/hive_order_details_model.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_details/order_details_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/bloc/order_summary/order_summary_cubit.dart';
import 'package:distributor_app_flutter/features/orders_list/presentation/widgets/order_detail_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colors.dart';

class SalesItemListScreen extends StatefulWidget {
  const SalesItemListScreen({Key? key}) : super(key: key);

  @override
  State<SalesItemListScreen> createState() => _SalesItemListScreenState();
}

class _SalesItemListScreenState extends State<SalesItemListScreen> {
  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  List<HiveOrderDetailsModel> _orderItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 140),
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
                    'Sales Order Items',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: appColor,
                  toolbarHeight: 20,
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
                                  'Sl.No',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 60,
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
                            height: 60,
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
                            height: 60,
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
                            height: 60,
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
                            height: 60,
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
          )
        ],
      ),
    );
  }
}
