import 'package:ecart/models/product.dart';
import 'package:ecart/providers/products.dart';
import 'package:ecart/widgets/colors_circule.dart';
import 'package:ecart/widgets/product_details.dart';
import 'package:ecart/widgets/read_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsList extends StatelessWidget {
  const ProductDetailsList({
    Key key,
    @required this.product,
    @required this.productProvider,
    @required this.theme,
    @required this.colorsNumber,
    @required this.hasSize,
    @required this.mediaQuery,
  }) : super(key: key);

  final Product product;
  final ProductsProvider productProvider;
  final ThemeData theme;
  final int colorsNumber;
  final bool hasSize;
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
                        productProvider.findSeller().name,
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
                                '${(product.price - product.price * product.discountPercentage / 100)} S.P',
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
                    bottom: 7,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "$e:  ",
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        product.specs[e],
                        style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 16,
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
                        color: Color(0xFF333333),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    child: product.returning.period != 0
                        ? Text(
                            '${product.returning.period} ' +
                                product.returning.type
                                    .toString()
                                    .split('.')
                                    .last,
                            style: TextStyle(
                              color: Color(0xFF828282),
                              fontSize: 16,
                            ),
                          )
                        : Text(
                            'X',
                            style: TextStyle(
                              color: Color(0xFF828282),
                              fontSize: 16,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 7,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Replace',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    child: product.replacement.period != 0
                        ? Text(
                            '${product.replacement.period} ' +
                                product.replacement.type
                                    .toString()
                                    .split('.')
                                    .last,
                            style: TextStyle(
                              color: Color(0xFF828282),
                              fontSize: 16,
                            ),
                          )
                        : Text(
                            'X',
                            style: TextStyle(
                              color: Color(0xFF828282),
                              fontSize: 16,
                            ),
                          ),
                  ),
                ],
              ),
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
