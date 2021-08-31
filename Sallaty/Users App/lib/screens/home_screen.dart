import 'package:ecart/models/category.dart';
import 'package:ecart/models/product.dart';
import 'package:ecart/models/product_details_screen_args.dart';
import 'package:ecart/widgets/categories_item.dart';
import 'package:flutter/material.dart';
import '../widgets/home_suggestion_item.dart';
import '../screens/product_details_screen.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentState = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 66,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => CategoriesItem(index),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const HomeSuggestionItem('Most Recent'),
                const HomeSuggestionItem('Highest Rated'),
                const HomeSuggestionItem('Best Seller'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchItem extends SearchDelegate<SearchItem> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> products = [];
    return FutureBuilder(
        future:
            Provider.of<ProductsProvider>(context).search(query),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          products = snapshot.data;
          return products == null || products.length == 0
              ? Center(child: Text('no matching product'))
              : Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 2,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 290,
                    ),
                    itemCount: products.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: products[i],
                      child: ProductItem(
                        isGridView: true,
                      ),
                    ),
                  ),
                );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = [];
    return FutureBuilder(
        future:
            Provider.of<ProductsProvider>(context, listen: false).search(query),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          suggestions = snapshot.data;
          return suggestions == null || suggestions.length == 0
              ? Center(child: Text('no matching product'))
              : ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (ctx, i) => ListTile(
                        title: Text(suggestions[i].title),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ProductDetailsSceen.routeName,
                              arguments: ProducDetailsScreenArgs(
                                  id: suggestions[i].id));
                        },
                      ));
        });
  }
}
