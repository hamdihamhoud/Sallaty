import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../providers/orders.dart' as oi;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class OrderItem extends StatefulWidget {
  final oi.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
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
            duration: Duration(milliseconds: 500),
            constraints: BoxConstraints(
              maxHeight:
                  _expanded ? widget.order.products.length * 60.0 + 10 : 0,
              minHeight: _expanded ? 30 : 0,
            ),
            color: Colors.grey[200],
            //    height: min(widget.order.products.length * 25.0 + 10, 100),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.order.products.length,
              itemBuilder: (ctx, i) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rate this product'),
                        RatingBar.builder(
                          tapOnlyMode: true,
                          itemSize: 25,
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text('Confirm your rating'),
                                      content: RatingBarIndicator(
                                        rating: rating,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 40,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<ProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .updateRating(
                                              widget.order.products[i].id,
                                              rating,
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                        ),
                      ],
                    )
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
