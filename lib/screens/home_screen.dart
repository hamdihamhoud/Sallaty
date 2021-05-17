import 'package:flutter/material.dart';

import '../widgets/categories_row.dart';
import '../widgets/home_suggestion_item.dart';
import '../widgets/bottom_navigation_bar.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Discover',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 2.0,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchItem());
              })
        ],
      ),
      drawer: DrawerScreen(),
      body: ListView(
        children: [
          // const CategoriesRow(),
          const SizedBox(
            height: 10,
          ),
          const HomeSuggestionItem('Most Recent'),
          const HomeSuggestionItem('Highest Rated'),
          const HomeSuggestionItem('Best Seller'),
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
    var products =
        Provider.of<ProductsProvider>(context, listen: false).search(query);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestions =
        Provider.of<ProductsProvider>(context, listen: false).search(query);
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (ctx, i) => ListTile(
              title: Text(suggestions[i].title),
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailsSceen.routeName,
                    arguments: suggestions[i].id);
              },
            ));
  }
}
