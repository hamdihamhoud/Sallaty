import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/orders.dart' as oi;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final oi.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem>{
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Total : \$${widget.order.amount}',
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded
                  ? Icons.expand_less_rounded
                  : Icons.expand_more_rounded),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          //     if (_expanded)
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            constraints: BoxConstraints(
              maxHeight: _expanded
                  ? min(widget.order.products.length * 25.0 + 10, 100)
                  : 0,
              minHeight: _expanded ? 30 : 0,
            ),
            color: Colors.grey[200],
            //    height: min(widget.order.products.length * 25.0 + 10, 100),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.order.products.length,
                  itemBuilder: (ctx, i) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.order.products[i].title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.order.products[i].quantity} x  \$${widget.order.amount}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
