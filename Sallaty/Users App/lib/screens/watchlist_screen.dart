import 'package:ecart/models/product.dart';
import 'package:ecart/providers/products.dart';
import 'package:ecart/screens/main_screen.dart';
import 'package:ecart/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawer_screen.dart';

class WatchlistScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  WatchlistScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    List<Product> favorites = [];
    return Scaffold(
        body: FutureBuilder(
            future: Provider.of<ProductsProvider>(context).getFavorites(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              favorites = snapshot.data;
              return favorites == null || favorites.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: mediaQuery.size.height * 0.3,
                          width: mediaQuery.size.width * 0.5,
                          child: Image.asset(
                            'assets/images/empty_favoraite_screen.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Text(
                            "Collect Love!",
                            style: TextStyle(
                              color: Colors.red[300],
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
                            'Save your favoraite products, you will find theme collect here waiting for you!',
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
                                  primary: Colors.red[200],
                                  onPrimary: Theme.of(context).accentColor,
                                )),
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      itemCount: favorites.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: (mediaQuery.size.width * 0.6) + 95,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: favorites[i],
                        child: FavoriteItem(
                          i: i,
                          isGridView: true,
                        ),
                      ),
                    );
            }));
  }
}
