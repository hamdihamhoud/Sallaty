import 'package:ecart/providers/orders.dart' show Orders;
import 'package:ecart/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawer_screen.dart';

class OrdersHistoryScreen extends StatelessWidget {
  static const routeName = '/orders';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: DrawerScreen(),
      body: Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    ),
              )
    );
  }
}
