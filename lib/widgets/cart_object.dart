import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/products.dart';
import 'package:ecart/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

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
      listen: false, // need this??
    );
    final cart = Provider.of<Cart>(context);
    return Column(
      children: [
        Padding(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width / 4 * 0.8,
                    height: 90,
                    imageUrl: cartItem.imageUrls[0],
                    fit: BoxFit.fill,
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
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Text(
                        '${cartItem.title}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Row(
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
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '________________________________________',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ],
          ),
        )
      ],
    );
  }
}

