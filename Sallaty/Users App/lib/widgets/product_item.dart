import 'package:ecart/providers/auth.dart';
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
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

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
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.black12,
                        Colors.black45,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
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
                Positioned(
                  bottom: 5,
                  child: RatingBarIndicator(
                    rating: product.rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemSize: 16,
                    unratedColor: Colors.white,
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
                        color: Colors.white70,
                      ),
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
                                authProvider.token,
                                authProvider.id,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: 80,
            width: 150,
            child: Column(
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (product.discountPercentage == 0)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      '${product.price} SYP',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                if (product.discountPercentage > 0)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      '${product.price} SYP',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: theme.primaryColor,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                if (product.discountPercentage > 0)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      '${(product.price - product.price * product.discountPercentage / 100).toStringAsFixed(0)} SYP',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: theme.primaryColor,
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
