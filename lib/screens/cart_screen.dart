import 'package:ecart/providers/cart.dart';
import 'package:ecart/screens/home_screen.dart';
import 'package:ecart/widgets/cart_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'drawer_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final Map<String, CartItem> items = cart.items;
    final List<CartItem> components = items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      drawer: DrawerScreen(),
      body: components.length == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no-cart-items.png',
                  fit: BoxFit.contain,
                ),
                Text(
                  "Empty Cart",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                    left: 30,
                    right: 30,
                  ),
                  child: Text(
                    'Looks like you haven\'t made your choice yet...',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: 200,
                  ),
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName),
                      child: Text(
                        'Back to menu',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.greenAccent,
                      )),
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

                      ///!!!!!!!!!!!!!!!!!!!!
                    ), //* sending the productid which is itemId not cartItemId
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${cart.total} SP',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '40.0 SP',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 5)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            elevation: MaterialStateProperty.all(0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero))),
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            'Confirm Order',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
      bottomNavigationBar: BottomBar(3, context),
    );
  }
}
