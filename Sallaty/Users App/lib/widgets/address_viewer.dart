import 'package:ecart/providers/addresses.dart';
import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class AddressesViewer extends StatelessWidget {
  final double total;
  final double coponDiscount;
  AddressesViewer({this.total, this.coponDiscount});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    final theme = Theme.of(context);
    final mediaquery = MediaQuery.of(context);
    final addressesProvider = Provider.of<AddressesProvider>(context);
    List<String> addresses = [];
    return FutureBuilder(
        future: addressesProvider.addresses,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          addresses = snapshot.data;
          return addresses != null
              ? Expanded(
                  child: addresses.length > 0
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    border: Border.all(
                                      width: 2,
                                      color: theme.accentColor,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        addresses[index],
                                        style: TextStyle(
                                          fontSize: 21,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Container(
                                          width: mediaquery.size.width,
                                          child: TextButton(
                                            onPressed: () async {
                                              try {
                                                await Provider.of<Orders>(
                                                        context,
                                                        listen: false)
                                                    .addOrder(
                                                  cartProvider.items.values
                                                      .toList(),
                                                  total,
                                                  addresses[index],
                                                  coponDiscount,
                                                );
                                                Navigator.pop(context);
                                                cartProvider.clearCart();
                                                Provider.of<ProductsProvider>(
                                                        context,listen: false)
                                                    .clearProducts();
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Container(
                                                        height: 110,
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                bottom: 10,
                                                              ),
                                                              child: Text(
                                                                "Order Received",
                                                                style:
                                                                    TextStyle(
                                                                  color: theme
                                                                      .primaryColor,
                                                                  fontSize: 21,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                bottom: 5,
                                                              ),
                                                              child: Text(
                                                                "Our customer service will contact you in 48 hours",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF828282),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                            Text(
                                                              "You can always track your orders in the \"Orders History\" section in your drawer",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF828282),
                                                                fontSize: 12,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                      ),
                                                      actions: [
                                                        Container(
                                                          width: mediaquery
                                                              .size.width,
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              backgroundColor: theme
                                                                  .primaryColor,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'OK',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 21,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                      title: ClipRect(
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        child: Container(
                                                          width: 50,
                                                          height: 100,
                                                          child: Image.asset(
                                                            'assets/images/order_success.png',
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } catch (error) {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                          content: Text(
                                                              'An error occured please try again later'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text('Ok'),
                                                            )
                                                          ],
                                                        ));
                                              }
                                            },
                                            child: Text(
                                              'Select Address',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  theme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/no_address_found.png"),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(
                                "No Address Added Yet",
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 20,
                                right: 20,
                              ),
                              child: Text(
                                "Tap 'Add a new Address' button below to add your first Address and start shopping!",
                                style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 19,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                )
              : Center(child: Text('No addresses yet start adding one'));
        });
  }
}
