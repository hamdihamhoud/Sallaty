import 'package:ecart/providers/orders.dart';
import 'package:ecart/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_screen.dart';

class OrdersHistoryScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    List<Order> orders = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: DrawerScreen(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context).orders,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            orders = snapshot.data;
            return orders != null && orders.length != 0
                ? ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (ctx, i) => OrderItem(orders[i]),
                  )
                : Center(child: Text('No orders yet'));
          }),
    );
  }
}
