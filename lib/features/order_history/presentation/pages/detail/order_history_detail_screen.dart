import 'package:distributor_app_flutter/features/order_history/presentation/models/order_history.dart';
import 'package:distributor_app_flutter/features/order_history/presentation/widgets/order_history_detail_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/colors.dart';
import '../../../../login/presentation/bloc/auth/auth_cubit.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  const OrderHistoryDetailScreen({Key? key,required this.orderHistory}) : super(key: key);

  final OrderHistory orderHistory;

  @override
  State<OrderHistoryDetailScreen> createState() => _OrderHistoryDetailScreenState();
}

class _OrderHistoryDetailScreenState extends State<OrderHistoryDetailScreen> {

  final _tableHeaderStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);

  bool _isCustomer = false;

  @override
  void initState() {
    var authState = context.read<AuthCubit>().state;
    if(authState is Authenticated){
      _isCustomer = authState.isCustomer;
    }
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
                  title: Text(
                    _isCustomer?'Order Details':'${widget.orderHistory.customerName}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
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
                              flex: 5,
                              child: Center(
                                child: Text(
                                  'Product Name',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                          Container(
                            height: 70,
                            width: 0.5,
                            color: Colors.transparent,
                          ),
                          Expanded(
                              flex: 3,
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
                              flex: 3,
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
                              flex: 3,
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
                              flex: 3,
                              child: Center(
                                child: Text(
                                  'Amount',
                                  style: _tableHeaderStyle,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                widget.orderHistory.items?.isNotEmpty??false
                    ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) => OrderHistoryDetailItemWidget(
                        item: widget.orderHistory.items![index],
                      ),
                      childCount: widget.orderHistory.items?.length),
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
        ],
      ),
    );
  }
}
