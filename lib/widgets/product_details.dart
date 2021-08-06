import 'package:ecart/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final int colorsNumber;
  final bool hasSize;
  final Product product;

  const ProductDetails(
      {@required this.colorsNumber,
      @required this.hasSize,
      @required this.product});
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      titleTextStyle: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.normal,
        color: theme.primaryColor,
      ),
      title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text('Product Details'),
        ),
      ),
      content: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height * 0.5,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: colorsNumber,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 24,
                    right: 24,
                  ),
                  child: Container(
                    width: mediaQuery.size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        width: 2,
                        color: theme.primaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 50,
                              width: mediaQuery.size.width,
                              decoration: BoxDecoration(
                                color: product.colorsAndQuantityAndSizes.keys
                                    .elementAt(index),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                border: Border.all(
                                    width: 2, color: theme.accentColor),
                              ),
                            ),
                          ),
                          if (hasSize)
                            for (int i = 0;
                                i <
                                    product.colorsAndQuantityAndSizes.entries
                                        .elementAt(index)
                                        .value
                                        .length;
                                i++)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Size: ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF828282),
                                              ),
                                            ),
                                            Text(
                                              product.colorsAndQuantityAndSizes
                                                  .entries
                                                  .elementAt(index)
                                                  .value
                                                  .entries
                                                  .elementAt(i)
                                                  .key
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: theme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Quantity: ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF828282),
                                              ),
                                            ),
                                            Text(
                                              product.colorsAndQuantityAndSizes
                                                  .entries
                                                  .elementAt(index)
                                                  .value
                                                  .entries
                                                  .elementAt(i)
                                                  .value
                                                  .toStringAsFixed(0),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    product.colorsAndQuantityAndSizes
                                                                .entries
                                                                .elementAt(
                                                                    index)
                                                                .value
                                                                .entries
                                                                .elementAt(i)
                                                                .value ==
                                                            0
                                                        ? Colors.red
                                                        : theme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (i !=
                                      (product.colorsAndQuantityAndSizes.entries
                                              .elementAt(index)
                                              .value
                                              .length) -
                                          1)
                                    Divider(
                                      color: Color(0xFF828282),
                                      indent: 25,
                                      endIndent: 25,
                                      height: 5,
                                      thickness: 2,
                                    ),
                                ],
                              )
                          else
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Quantity: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF828282),
                                    ),
                                  ),
                                  Text(
                                    product.colorsAndQuantityAndSizes.entries
                                        .elementAt(index)
                                        .value
                                        .entries
                                        .elementAt(0)
                                        .value
                                        .toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: product.colorsAndQuantityAndSizes
                                                  .entries
                                                  .elementAt(index)
                                                  .value
                                                  .entries
                                                  .elementAt(0)
                                                  .value ==
                                              0
                                          ? Colors.red
                                          : theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                ),
              ),
              width: double.infinity,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
    );
  }
}
