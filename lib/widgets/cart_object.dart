import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/products.dart';
import 'package:ecart/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartObject extends StatefulWidget {
  final String productId;
  final CartItem cartItem;
  CartObject(
    this.cartItem,
    this.productId,
  );

  @override
  _CartObjectState createState() => _CartObjectState(
        this.cartItem,
        this.productId,
      );
}

class _CartObjectState extends State<CartObject> {
  bool addButtonState = true;
  bool removeButtonState = false;
  final String productId;
  final CartItem cartItem;
  _CartObjectState(
    this.cartItem,
    this.productId,
  );
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(
      context,
      listen: false, // need this??
    );
    final cart = Provider.of<Cart>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 20,
        top: 20,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 8,
                    ),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 4 * 0.8,
                      height: 90,
                      imageUrl: widget.cartItem.imageUrls[0],
                      fit: BoxFit.fitWidth,
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 11,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )),
                    width: MediaQuery.of(context).size.width / 4,
                    height: 105,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      child: Text(
                        "${widget.cartItem.price.toStringAsFixed(0)} S.P",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
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
              left: 5,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: 1 == 1
                            ? Color.fromARGB(255, 66, 66, 66)
                            : Theme.of(context).accentColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: 1 == 1
                          ? Color.fromARGB(255, 66, 66, 66)
                          : Theme.of(context).accentColor,
                    ),
                    child: Center(
                      child: IconButton(
                        splashColor: removeButtonState
                            ? ThemeData().splashColor
                            : Colors.transparent,
                        enableFeedback: removeButtonState,
                        highlightColor: removeButtonState
                            ? ThemeData().highlightColor
                            : Colors.transparent,
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          /* if (widget.amount > 1) {
                            setState(() {
                              removeButtonState = true;
                              addButtonState = true;
                              widget.amount--;
                              widget.setter(widget.amount);
                            });
                            if (widget.amount == 1) {
                              setState(() {
                                removeButtonState = false;
                              });
                            }
                          } */
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  cartItem.quantity.toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: 1 == 1
                            ? Color.fromARGB(255, 66, 66, 66)
                            : Theme.of(context).accentColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: 1 == 1
                          ? Color.fromARGB(255, 66, 66, 66)
                          : Theme.of(context).accentColor,
                    ),
                    child: Center(
                      child: IconButton(
                        splashColor: addButtonState
                            ? ThemeData().splashColor
                            : Colors.transparent,
                        enableFeedback: addButtonState,
                        highlightColor: addButtonState
                            ? ThemeData().highlightColor
                            : Colors.transparent,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
/*                       if (widget.amount < widget.maxAmount) {
                            setState(() {
                              removeButtonState = true;
                              widget.amount++;
                              widget.setter(widget.amount);
                            });
                            if (widget.amount == widget.maxAmount) {
                              setState(() {
                                addButtonState = false;
                              });
                            }
                          } */
                        },
                      ),
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
