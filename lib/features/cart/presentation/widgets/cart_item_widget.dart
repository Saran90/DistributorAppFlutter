import 'package:distributor_app_flutter/utils/colors.dart';
import 'package:distributor_app_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../pages/models/cart.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
      {Key? key,
      required this.cartModel,
      required this.onQuantityClicked,
      required this.onDeleteClicked})
      : super(key: key);

  final Cart cartModel;
  final Function() onQuantityClicked;
  final Function() onDeleteClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: (cartModel.quantity > 0) ? Colors.white.withOpacity(0.6) : Colors.white,
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text(cartModel.productName),
                ),
              )),
          Container(
            height: 60,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text('${cartModel.stock}'),
                ),
              )),
          Container(
            height: 60,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text('${cartModel.rate}'),
                ),
              )),
          Container(
            height: 60,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 4,
              child: InkWell(
                onTap: onQuantityClicked,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black54, width: 0.5),
                          bottom: BorderSide(color: Colors.black54, width: 0.5))),
                  child: Center(
                    child: Text('${cartModel.quantity}'),
                  ),
                ),
              )),
          Container(
            height: 60,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text('${cartModel.orderAmount.to2DigitFraction()}'),
                ),
              )),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: onDeleteClicked,
                child: SizedBox(
                  child: Center(
                      child: SvgPicture.asset(
                    'assets/icons/delete.svg',
                    width: 20,
                    height: 20,
                  )),
                ),
              )),
        ],
      ),
    );
  }
}
