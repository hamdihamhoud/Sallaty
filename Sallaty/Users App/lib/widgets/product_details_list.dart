import 'package:ecart/models/product.dart';
import 'package:ecart/providers/products.dart';
import 'package:ecart/widgets/colors_circule.dart';
import 'package:ecart/widgets/product_details.dart';
import 'package:ecart/widgets/read_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductDetailsList extends StatelessWidget {
  const ProductDetailsList({
    Key key,
    @required this.product,
    @required this.productProvider,
    @required this.theme,
    @required this.colorsNumber,
    @required this.hasSize,
    @required this.ownerName,
    @required this.mediaQuery,
  }) : super(key: key);

  final Product product;
  final ProductsProvider productProvider;
  final ThemeData theme;
  final int colorsNumber;
  final bool hasSize;
  final String ownerName;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text(
                        '${product.title}',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text(
                        ownerName,
                        style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          if (product.discountPercentage == 0)
                            Text(
                              '${product.price.toInt()} S.P',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (product.discountPercentage > 0)
                            Text(
                              '${product.price.toInt()} S.P',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (product.discountPercentage > 0)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Text(
                                '${(product.price - product.price * product.discountPercentage / 100).toStringAsFixed(0)} S.P',
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 0,
                      ),
                      child: RatingBarIndicator(
                        rating: product.rating,
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ProductDetails(
                        colorsNumber: colorsNumber,
                        hasSize: hasSize,
                        product: product,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      if (colorsNumber <= 3)
                        for (int i = 0; i < colorsNumber; i++)
                          ColorCircule(
                            product.colorsAndQuantityAndSizes.keys.elementAt(i),
                          ),
                      if (colorsNumber > 3)
                        for (int i = 0; i < 3; i++)
                          ColorCircule(
                            product.colorsAndQuantityAndSizes.keys.elementAt(i),
                          ),
                      if (colorsNumber > 3)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 3,
                          ),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              border: Border.all(
                                color: theme.primaryColor,
                                width: 3,
                              ),
                              color: Colors.black12,
                            ),
                            child: Center(
                              child: Text(
                                "+${colorsNumber - 3}",
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                'Descreption',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: ReadMoreText(
                '${product.description} ',
                style: TextStyle(
                  color: Color(0xFF828282),
                  fontSize: 16,
                ),
                colorClickableText: Color(0xFF333333),
              ),
            ),
            (product.specs.length != 0)
                ? Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Text(
                      'Item details',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: 0,
                    ),
                  ),
            ...product.specs.keys.map((e) {
              if (product.specs.length != 0)
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: mediaQuery.size.width * 0.3,
                        ),
                        child: Text(
                          "$e:  ",
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: mediaQuery.size.width * 0.5,
                        ),
                        child: Text(
                          product.specs[e],
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            }).toList(),
            (product.specs.length != 0)
                ? Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 3,
                    ),
                    child: Text(
                      'Returns & Replacement',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Text(
                      'Returns & Replacement',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Return',
                      style: TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: product.returning.period != 0
                        ? Row(
                            children: [
                              Text(
                                '${product.returning.period} ',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product.returning.type
                                    .toString()
                                    .split('.')
                                    .last,
                                style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'X',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Replace',
                      style: TextStyle(
                        color: Color(0xFF828282),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: product.replacement.period != 0
                        ? Row(
                            children: [
                              Text(
                                '${product.replacement.period} ',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product.replacement.type
                                    .toString()
                                    .split('.')
                                    .last,
                                style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'X',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                'Warranty',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  right: 30,
                  left: 30,
                ),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: product.warranty.period != 0
                          ? Colors.green
                          : Colors.redAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      )),
                  child: product.warranty.period != 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${product.warranty.period}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Text(
                                product.warranty.type
                                    .toString()
                                    .split('.')
                                    .last,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Icon(
                                Icons.verified_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Warranty",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Icon(
                                Icons.warning_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Related Products',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder(
                    future: product.type.length != 0 &&
                            product.type != 'other'
                        ? productProvider.fetchByType(product.type)
                        : productProvider.fetchByCategory(product.category),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                            height: 290,
                            child: Center(child: CircularProgressIndicator()));
                      List<Product> relatedProducts = snapshot.data;
                      final i = relatedProducts
                          .indexWhere((element) => element.id == product.id);
                      relatedProducts.removeAt(i);
                      return relatedProducts != null &&
                              relatedProducts.length != 0
                          ? Container(
                              height: 290,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: relatedProducts.length,
                                  itemBuilder: (ctx, index) =>
                                      ChangeNotifierProvider.value(
                                        value: relatedProducts[index],
                                        child: ProductItem(),
                                      )),
                            )
                          : Container(
                              height: 290,
                              child: Center(child: Text('No data found')));
                    }),
              ],
            ),
            SizedBox(
              height: 85,
              width: mediaQuery.size.width,
            )
          ],
        ),
      ),
    );
  }
}
