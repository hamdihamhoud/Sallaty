import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/product_details_screen.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isGridView;
  ProductItem({this.product, this.isGridView = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsSceen.routeName, arguments: product);
      },
      child: AspectRatio(
        aspectRatio: 2/3,
        // Container(
        //                     width: isGridView ? width * 0.45 : 120,
        //             // height: isGridView ? width * 0.40 : 120,
        child: Card(
          // color: Colors.tr,
          elevation: 3,

          // semanticContainer: false,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     width: 0.4,
          //   ),
          // borderRadius: BorderRadius.circular(15),
          // ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight:120),
                // padding: const EdgeInsets.all(5),
                // margin: const EdgeInsets.only(bottom: 8),
                child: CachedNetworkImage(
                  // width: isGridView ? width * 0.40 : 120,
                  // height: isGridView ? width * 0.40 : 120,

                  alignment: Alignment.center,
                  imageUrl: product.imageUrls.first,
                  progressIndicatorBuilder: (ctx, str, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).accentColor),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Center(child: const Icon(Icons.error)),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    if (!product.hasDiscount)
                      Text(
                        '${product.price} SYP',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16),
                      ),
                    if (product.hasDiscount)
                      Text(
                        '${product.price} SYP',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.start,
                      ),
                    if (product.hasDiscount)
                      Text(
                        '${(product.price - product.price * product.discountPercentage / 100)} SYP',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 16),
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
