import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartObject extends StatelessWidget {
  final String productId;
  final CartItem cartItem;
  CartObject(
    this.cartItem,
    this.productId,
  );
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(
      context,
    );
    final cart = Provider.of<Cart>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 4 * 0.8,
                  height: 90,
                  imageUrl: cartItem.imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (ctx, str, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).accentColor),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Center(child: const Icon(Icons.error)),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.title,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${cartItem.price.toStringAsFixed(0)} S.P",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: cartItem.quantity > 1
                          ? Theme.of(context).accentColor
                          : Color.fromARGB(255, 66, 66, 66),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: cartItem.quantity > 1
                        ? Theme.of(context).accentColor
                        : Color.fromARGB(255, 66, 66, 66),
                  ),
                  child: Center(
                    child: IconButton(
                        splashColor: cartItem.quantity > 1
                            ? ThemeData().splashColor
                            : Colors.transparent,
                        enableFeedback: cartItem.quantity > 1,
                        highlightColor: cartItem.quantity > 1
                            ? ThemeData().highlightColor
                            : Colors.transparent,
                        icon: Center(
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                        onPressed: () {
                          /*  if (cartItem.quantity > 1) {
                            cart.undoAddingItem(productId);
                            productProvider.addToList(productId, 1);
                          } */
                        }),
                  ),
                ),
              ),
              Text(
                cartItem.quantity.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                ),
                child: Container(
                    /*  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: productProvider.checkIfAvailable(productId)
                          ? Theme.of(context).accentColor
                          : Color.fromARGB(255, 66, 66, 66),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: productProvider.checkIfAvailable(productId)
                        ? Theme.of(context).accentColor
                        : Color.fromARGB(255, 66, 66, 66),
                  ),
                  child: Center(
                    child: IconButton(
                        splashColor: productProvider.checkIfAvailable(productId)
                            ? ThemeData().splashColor
                            : Colors.transparent,
                        enableFeedback:
                            productProvider.checkIfAvailable(productId),
                        highlightColor:
                            productProvider.checkIfAvailable(productId)
                                ? ThemeData().highlightColor
                                : Colors.transparent,
                        icon: Center(
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                        onPressed: () {
                          if (productProvider.removeFromList(productId, 1)) {
                            cart.addItem(
                              productId: productId,
                              price: (cartItem.price / cartItem.quantity),
                              title: cartItem.title,
                              quantity: 1,
                            );
                          }
                        }),
                  ), */
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.15,
        secondaryActions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => {
                cart.deleteProductFromCart(productId),
                productProvider.addToList(productId, cartItem.quantity),
              },
            ),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            right: 10,
            top: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Stack(children: [
                    Positioned(
                      top: 5,
                      left: 10,
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width / 4 * 0.8,
                        height: 90,
                        imageUrl: cartItem.imageUrls[0],
                        fit: BoxFit.fitWidth,
                        progressIndicatorBuilder:
                            (ctx, str, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).accentColor),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Center(child: const Icon(Icons.error)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 10,
                            color: Color.fromARGB(255, 60, 60, 60),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          )),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          '${cartItem.title}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(),
                                  color: Colors.blue[100],
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 20,
                                      color: Colors.blueAccent,
                                    ),
                                    tooltip: 'Decrease quantity by one',
                                    onPressed: () {
                                      cart.undoAddingItem(productId);
                                      productProvider.addToList(productId, 1);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 35,
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(),
                                  color: Colors.blue[50],
                                ),
                                child: Center(
                                  child: Text(
                                    "${cartItem.quantity}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(),
                                  color: Colors.blue[100],
                                ),
                                child: IconButton(
                                  tooltip: 'Increase quantity by one',
                                  icon: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  onPressed: () {
                                    productProvider.removeFromList(productId, 1)
                                        ? cart.addItem(
                                            productId: productId,
                                            price: (cartItem.price /
                                                cartItem.quantity),
                                            title: cartItem.title,
                                            quantity: 1,
                                          )
                                        : showAlertDialog(
                                            context: context,
                                            title: "Opps!",
                                            subTitle:
                                                'There is no enuogh quantity',
                                          );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  '${cartItem.price} SP',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ); */
