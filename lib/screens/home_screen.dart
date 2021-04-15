import 'package:flutter/material.dart';

import '../widgets/categories_row.dart';
import '../widgets/home_suggestion_item.dart';
import '../widgets/bottom_navigation_bar.dart';

import '../widgets/search.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ecart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: ListView(
        children: [
          SearchBar(),
          CategoriesRow(),
          SizedBox(
            height: 10,
          ),
          HomeSuggestionItem('Most Recent'),
          HomeSuggestionItem('Highest Rated'),
          HomeSuggestionItem('Best Seller'),
        ],
      ),
      bottomNavigationBar: BottomBar(0, context),
    );
  }
}
