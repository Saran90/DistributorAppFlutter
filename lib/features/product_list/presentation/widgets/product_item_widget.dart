import 'package:distributor_app_flutter/core/data/local_storage/models/hive_product_model.dart';
import 'package:distributor_app_flutter/features/product_list/presentation/pages/models/product.dart';
import 'package:distributor_app_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({Key? key, required this.productModel})
      : super(key: key);

  final Product productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: (productModel.quantity!=null && productModel.quantity!>0)?appColorGradient2:Colors.white,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black54, width: 0.5),
                          bottom: BorderSide(color: Colors.black54, width: 0.5))),
                  child: CachedNetworkImage(
                    imageUrl: productModel.image??'',
                    placeholder: (context, url) => SvgPicture.asset('assets/icons/item_icon.svg',fit: BoxFit.scaleDown,),
                    errorWidget: (context, url, error) => SvgPicture.asset('assets/icons/item_icon.svg',fit: BoxFit.scaleDown),
                  ))),
          Container(
            height: 60,
            width: 0.5,
            color: Colors.black54,
          ),
          Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 0.5),
                        bottom: BorderSide(color: Colors.black54, width: 0.5))),
                child: Center(
                  child: Text('${productModel.name}'),
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
                  child: Text('${productModel.stock}'),
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
                  child: Text('${productModel.rate}'),
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
                  child: Text('${productModel.quantity}'),
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
                  child: Text('${productModel.total}'),
                ),
              )),
        ],
      ),
    );
  }
}
