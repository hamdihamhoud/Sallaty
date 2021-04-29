import 'package:ecart/providers/cart.dart';
import 'package:ecart/widgets/alert_dialog.dart';
import 'package:ecart/widgets/soldout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/product_images_carousel.dart';

// ignore: must_be_immutable
class ProductDetailsSceen extends StatelessWidget {
  static const routeName = '/product-details';
  int amount = 1;
  void setAmount(int a) => amount = a;
  int cartItemId = 0;
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final Product product = productProvider.findId(productId);
    final cart = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  child: Stack(children: [
                    CarouselWithIndicator(product.imageUrls),
                    Positioned(
                      right: 15,
                      top: 15,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black54),
                        child: FavoriteIcon(product: product),
                      ),
                    ),
                  ]),
                ),
                // seller
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    productProvider.findSeller().name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                // title
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: Theme.of(context).accentColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                // rating
                RatingBarIndicator(
                  rating: product.rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(9),
                  child: Text('Quantity: ${product.quantity}'),
                ),
                Divider(),
                // Details
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Item details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
                ...product.specs.keys.map((e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Text(
                          e,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        width: mediaQuery.size.width * 0.50,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Text(product.specs[e]),
                        width: mediaQuery.size.width * 0.50,
                      ),
                    ],
                  );
                }).toList(),
                Divider(),
                // Description
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 100),
                  padding: const EdgeInsets.all(8),
                  child: Scrollbar(
                    child:
                        SingleChildScrollView(child: Text(product.description)),
                  ),
                ),
                Divider(),
                // Price
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
                if (!product.hasDiscount)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${product.price} SYP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                if (product.hasDiscount)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${product.price} SYP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                if (product.hasDiscount)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${(product.price - product.price * product.discountPercentage / 100).toStringAsFixed(0)} SYP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                Divider(),
                // Return
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Returns & Replacement',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Text(
                        'Return',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      width: mediaQuery.size.width * 0.50,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: product.isReturnable
                          ? Text('${product.returningPeriod} day')
                          : Text(
                              'X',
                              style: TextStyle(color: Colors.red),
                            ),
                      width: mediaQuery.size.width * 0.50,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Text(
                        'Replace',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      width: mediaQuery.size.width * 0.50,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: product.isReturnable
                          ? Text('${product.replacementPeriod} day')
                          : Text(
                              'X',
                              style: TextStyle(color: Colors.red),
                            ),
                      width: mediaQuery.size.width * 0.50,
                    ),
                  ],
                )
              ],
            ),
          ),
          if (productProvider.checkIfAvailable(productId))
            Row(
              children: [
                Container(
                    color: Theme.of(context).primaryColor,
                    child: QuantityIcon(
                      amount: amount,
                      maxAmount: product.quantity,
                      setter: setAmount,
                    )),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: Theme.of(context).accentColor,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if(productProvider.removeFromList(productId, amount))
                            {
                                cart.addItem(
                                  productId: product.id, //key
                                  quantity: amount,
                                  title: product.title,
                                  price: product.hasDiscount
                                      ? (product.price -
                                          product.price *
                                              product.discountPercentage /
                                              100)
                                      : product.price,
                                  imageUrls: product.imageUrls,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      amount > 1
                                          ? '$amount item\'s added to your cart'
                                          : '$amount item added to your cart',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    duration: Duration(milliseconds: 700),
                                  ),
                                );
                                setAmount(1);
                                cartItemId++;
                              }
                      },
                      icon: Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Colors.black,
                      ),
                      label: Text(
                        'ADD TO CART',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            SoldOut(),
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 19,
      padding: const EdgeInsets.all(0),
      color: Colors.red,
      icon: widget.product.isFavorite
          ? Icon(Icons.favorite_rounded)
          : Icon(Icons.favorite_border_rounded),
      onPressed: () {
        setState(() {
          widget.product.toggleFav();
        });
      },
    );
  }
}

// ignore: must_be_immutable
class QuantityIcon extends StatefulWidget {
  QuantityIcon({
    Key key,
    @required this.amount,
    @required this.maxAmount,
    @required this.setter,
  }) : super(key: key);
  int amount;
  int maxAmount;
  Function setter;
  @override
  _QuantityIconState createState() => _QuantityIconState();
}

class _QuantityIconState extends State<QuantityIcon> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {
              if (widget.amount > 1) {
                setState(() {
                  widget.amount--;
                  widget.setter(widget.amount);
                });
              }
            },
          ),
        ),
        Text(
          widget.amount.toString(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (widget.amount < widget.maxAmount) {
                  widget.amount++;
                  widget.setter(widget.amount);
                } else {
                  showAlertDialog(
                    context: context,
                    title: 'Opps!',
                    subTitle: "There is no enuogh quantity",
                  );
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
