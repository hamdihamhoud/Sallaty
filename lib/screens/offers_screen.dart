import 'package:ecart/screens/main_screen.dart';
import 'package:ecart/screens/offer_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../models/product.dart';
import 'drawer_screen.dart';

class OffersScreen extends StatelessWidget {
  static const routeName = '/offers';
  OffersScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List <Product> products = [];
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
      ),
      drawer: DrawerScreen(),
      body: FutureBuilder(
          future: Provider.of<ProductsProvider>(context).getOffers(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            products = snapshot.data;
            return products.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: mediaQuery.size.height * 0.3,
                        width: mediaQuery.size.width * 0.5,
                        child: Image.asset(
                          'assets/images/empty_offers_screen.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text(
                          "No offers available",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 30,
                          right: 30,
                        ),
                        child: Text(
                          'WE\'RE SORRY, There are no offers available at this time, Please check back later for MORE',
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          child: ElevatedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacementNamed(
                                      AppBottomNavigationBarController
                                          .routeName),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Back to store',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Icon(
                                      Icons.store,
                                    ),
                                  )
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey,
                                onPrimary: Theme.of(context).accentColor,
                              )),
                        ),
                      ),
                    ],
                  )
                : GridView.builder(
                    itemCount: products.length,
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: (mediaQuery.size.width * 0.6) + 95,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: products[i],
                      child: OfferItem(
                        isGridView: true,
                      ),
                    ),
                  );
          }),
    );
  }
}
