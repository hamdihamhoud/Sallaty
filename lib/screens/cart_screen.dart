import 'package:ecart/providers/cart.dart';
import 'package:ecart/screens/main_screen.dart';
import 'package:ecart/widgets/cart_object.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
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
                          .pushReplacementNamed(
                              AppBottomNavigationBarController.routeName),
                      child: Text(
                        'Back to menu',
                        style: TextStyle(
                          color: Color.fromARGB(255, 232, 232, 232),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor,
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
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(
                      start: 1,
                      end: 1,
                      top: 1,
                    ),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white12,
                          Colors.transparent,
                        ],
                        stops: [0.4, 0.45, 1.0],
                        tileMode: TileMode.clamp,
                        begin: Alignment(-4.0, -4),
                        end: Alignment(4, 4),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Disacount',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                '400',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${cart.total.toStringAsFixed(0)} SP',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
