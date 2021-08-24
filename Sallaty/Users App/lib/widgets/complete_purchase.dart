import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/orders.dart';
import 'package:ecart/widgets/add_new_address_button.dart';
import 'package:ecart/widgets/address_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletePurchase extends StatelessWidget {
  const CompletePurchase({
    Key key,
    @required this.cart,
  }) : super(key: key);
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    int deliveryCharge = 2000; // temp
    final ordersProvider = Provider.of<Orders>(context);
    double total = cart.total + deliveryCharge;
    final mediaquery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Container(
      height: 150,
      width: mediaquery.size.width,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
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
                  'Delivery Charge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                ),
                FutureBuilder(
                    future: ordersProvider.getOrderDeliveryCharge(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        );
                      deliveryCharge = snapshot.data;
                      return Text(
                        '${deliveryCharge.toStringAsFixed(0)} SP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      );
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: Text(
                    '${total.toStringAsFixed(0)} SP',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: mediaquery.size.width,
              height: 40,
              child: ElevatedButton(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 21,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: theme.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      barrierColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      context: context,
                      builder: (context) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AddressesViewer(total: total),
                                NewAddressButton(),
                              ],
                            ),
                          ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
