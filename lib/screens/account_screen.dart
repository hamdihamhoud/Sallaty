import 'package:ecart/models/product.dart';
import 'package:ecart/providers/orders.dart';
import 'package:ecart/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'drawer_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  AccountScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isPremium = true; //false;

    Widget premiumBody(BuildContext context){
      return  ListView(
              children: [
                Container(
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'All Products',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Orders',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Shiped',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Sold',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recently Added',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<ProductsProvider>(builder: (ctx, products, _) {
                  final List<Product> sellerProducts =
                      products.fetchBySellerRecents();
                  return sellerProducts.isEmpty
                      ? Container(
                          height: 100,
                          child: Center(
                            child: Text(
                              'No products yet start adding now',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: sellerProducts.length,
                              itemBuilder: (ctx, i) =>
                                  ChangeNotifierProvider.value(
                                      value: sellerProducts[i],
                                      child: ProductItem(
                                        isSeller: true,
                                      ))),
                        );
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recent Sold Items',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Consumer<Orders>(builder: (ctx,orders,_)=>),
              ],
            );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      drawer: DrawerScreen(),
      body: isPremium
          ? premiumBody(context)
          : Container(),
      bottomNavigationBar: BottomBar(4, context),
    );
  }
}
