import 'package:ecart/providers/cart.dart';
import 'package:ecart/screens/main_screen.dart';
import 'package:ecart/widgets/cart_object.dart';
import 'package:ecart/widgets/complete_purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'drawer_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final Map<String, CartItem> items = cart.items;
    final List<CartItem> components = items.values.toList();
    return Scaffold(
      body: components.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Image.asset(
                    'assets/images/empty_cart.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Text(
                    "Empty Cart",
                    style: TextStyle(
                      color:
                          Theme.of(context).primaryColor,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 30,
                    right: 30,
                  ),
                  child: Text(
                    'Looks like you haven\'t made your choice yet...',
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(
                                AppBottomNavigationBarController.routeName),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Back to store',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Icon(
                                Icons.store,
                              ),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          onPrimary: Theme.of(context).accentColor,
                        )),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: components.length,
                    itemBuilder: (context, index) => CartObject(
                      components[index],
                      items.keys.firstWhere(
                          (element) => items[element] == components[index]),
                    ),
                  ),
                ),
                CompletePurchase(cart: cart),
              ],
            ),
    );
  }
}
