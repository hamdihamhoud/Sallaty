import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartObject extends StatefulWidget {
  final String keys;
  final CartItem cartItem;
  CartObject(
    this.cartItem,
    this.keys,
  );

  @override
  _CartObjectState createState() => _CartObjectState();
}

class _CartObjectState extends State<CartObject> {
  @override
  Widget build(BuildContext context) {
    final bool hasSize = widget.cartItem.size == "0" ? false : true;
    final productProvider = Provider.of<ProductsProvider>(
      context,
    );
    final cart = Provider.of<Cart>(context);
    bool available = productProvider.checkIfAvailable(
      id: widget.cartItem.productId,
      color: widget.cartItem.color,
      amount: 1,
      size: widget.cartItem.size,
    );
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.15,
        secondaryActions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => {
                  cart.deleteProductFromCart(widget.keys),
                  productProvider.addToList(
                    amount: widget.cartItem.quantity,
                    color: widget.cartItem.color,
                    id: widget.cartItem.productId,
                    size: widget.cartItem.size,
                  ),
                },
              ),
            ),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              color: Theme.of(context).accentColor,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width / 4 * 0.8,
                            height: 90,
                            imageUrl: widget.cartItem.imageUrl,
                            fit: BoxFit.cover,
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
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            top: 2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.cartItem.title,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "${widget.cartItem.price.toStringAsFixed(0)} S.P",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                color: widget.cartItem.quantity > 1
                                    ? Theme.of(context).primaryColor
                                    : Color.fromARGB(255, 66, 66, 66),
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: widget.cartItem.quantity > 1
                                  ? Theme.of(context).primaryColor
                                  : Color.fromARGB(255, 66, 66, 66),
                            ),
                            child: Center(
                              child: IconButton(
                                  splashColor: widget.cartItem.quantity > 1
                                      ? ThemeData().splashColor
                                      : Colors.transparent,
                                  enableFeedback: widget.cartItem.quantity > 1,
                                  highlightColor: widget.cartItem.quantity > 1
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
                                    if (widget.cartItem.quantity > 1) {
                                      cart.undoAddingItem(keys: widget.keys);
                                      productProvider.addToList(
                                          id: widget.cartItem.productId,
                                          color: widget.cartItem.color,
                                          amount: 1,
                                          size: widget.cartItem.size);
                                    }
                                  }),
                            ),
                          ),
                        ),
                        Text(
                          widget.cartItem.quantity.toStringAsFixed(0),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF3333333),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                          ),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: available
                                    ? Theme.of(context).primaryColor
                                    : Color.fromARGB(255, 66, 66, 66),
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: available
                                  ? Theme.of(context).primaryColor
                                  : Color.fromARGB(255, 66, 66, 66),
                            ),
                            child: Center(
                              child: IconButton(
                                splashColor: available
                                    ? ThemeData().splashColor
                                    : Colors.transparent,
                                enableFeedback: available,
                                highlightColor: available
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
                                  if (available) {
                                    productProvider.removeFromList(
                                      id: widget.cartItem.productId,
                                      color: widget.cartItem.color,
                                      amount: 1,
                                      size: widget.cartItem.size,
                                    );
                                    cart.addItem(
                                      keys: widget.keys,
                                      color: widget.cartItem.color,
                                      imageUrl: widget.cartItem.imageUrl,
                                      size: widget.cartItem.size,
                                      productId: widget.cartItem.productId,
                                      price: (widget.cartItem.price /
                                          widget.cartItem.quantity),
                                      title: widget.cartItem.title,
                                      quantity: 1,
                                    );
                                    if (!productProvider.checkIfAvailable(
                                        id: widget.cartItem.productId,
                                        color: widget.cartItem.color,
                                        amount: 1,
                                        size: widget.cartItem.size)) {
                                      setState(() {
                                        available = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: hasSize
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.end,
                    children: [
                      if (hasSize)
                        Row(
                          children: [
                            Text(
                              "Size: ",
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${widget.cartItem.size}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Text(
                            "Color: ",
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4 / 4,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).accentColor,
                              ),
                              color: widget.cartItem.color,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
