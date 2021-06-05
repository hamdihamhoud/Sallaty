import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ecart/models/product.dart';
import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/orders.dart';
import 'package:ecart/widgets/product_item.dart';

import '../providers/products.dart';
import '../widgets/seller_filtering_row.dart';
import 'drawer_screen.dart';
import 'add_product_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  AccountScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isPremium = true; //false;
    List<CartItem> sellerOrders = [];
    void _refresh() {
      sellerOrders = Provider.of<Orders>(context).fetchSellerOreders();
    }

    Widget premiumBody() {
      _refresh();
      return ListView(
        children: [
          SellerFilteringRow(),
          RecentlyAdded(),
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
                        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                            value: sellerProducts[i],
                            child: ProductItem(
                              isSeller: true,
                            ))),
                  );
          }),
          RecentSoldItems(),
          sellerOrders.length == 0
              ? Center(
                  child: Text('No Orders Yet'),
                )
              : Column(
                  children: [
                    ...sellerOrders.map((e) => SellerItemTile(e)).toList()
                  ],
                ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          if (isPremium)
            PopupMenuButton(
              onSelected: (_) {
                print('hamdi');
              },
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text(
                      'Analytics',
                    ),
                    value: 'Analytics',
                  ),
                ];
              },
            )
        ],
      ),
      drawer: DrawerScreen(),
      body: isPremium ? premiumBody() : Container(),
      // bottomNavigationBar: BottomBar(4, context),
    );
  }
}

class RecentSoldItems extends StatelessWidget {
  const RecentSoldItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Sold Items',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class RecentlyAdded extends StatelessWidget {
  const RecentlyAdded({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SellerItemTile extends StatelessWidget {
  final CartItem e;
  const SellerItemTile(this.e);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.5,
      margin: const EdgeInsets.all(8),
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 55,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: e.imageUrl,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  e.title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  DateFormat.yMd().add_jm().format(DateTime.now()),
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.circle,
              color: e.status == Status.Ordered
                  ? Colors.red
                  : e.status == Status.Shiped
                      ? Colors.orange
                      : Colors.green,
              size: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Text('x${e.quantity}'),
            ),
          ],
        ),
      ),
    );
  }
}
