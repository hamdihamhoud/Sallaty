import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../screens/product_details_screen.dart';

import '../models/product.dart';
import '../models/product_details_screen_args.dart';

class ProductItem extends StatelessWidget {
  final bool isGridView;
  final bool isSeller;
  ProductItem({
    this.isGridView = false,
    this.isSeller = false,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailsSceen.routeName,
          arguments: ProducDetailsScreenArgs(
            id: product.id,
            isSeller: isSeller,
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            fit: StackFit.passthrough,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    // color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          // Colors.grey[300].withOpacity(0.3),
                          // Colors.black.withOpacity(0.6),
                          Colors.black12,
                          Colors.black87
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
                // constraints: BoxConstraints(maxHeight: 120),
                child: CachedNetworkImage(
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
                  fit: BoxFit.cover,
                ),
              ),
              if (!isSeller)
                Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black54),
                      child: Consumer<Product>(
                        builder: (ctx, pr, _) => Center(
                          child: IconButton(
                            iconSize: 19,
                            padding: const EdgeInsets.all(0),
                            color: Colors.red,
                            icon: pr.isFavorite
                                ? Icon(Icons.favorite_rounded)
                                : Icon(Icons.favorite_border_rounded),
                            onPressed: () {
                              pr.toggleFav(
                                  // token,
                                  // userId,
                                  );
                            },
                          ),
                        ),
                      ),
                    )),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    if (!product.hasDiscount)
                      Text(
                        '${product.price} SYP',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    if (product.hasDiscount)
                      Text(
                        '${product.price} SYP',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white,
                            fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    if (product.hasDiscount)
                      Text(
                        '${(product.price - product.price * product.discountPercentage / 100).toStringAsFixed(0)} SYP',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    SizedBox(
                      height: 6,
                    ),
                    RatingBarIndicator(
                      rating: product.rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemSize: 16,
                      unratedColor: Colors.white,
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
