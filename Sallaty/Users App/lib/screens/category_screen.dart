import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../models/product.dart';
import '../models/category.dart';
import '../widgets/product_item.dart';
import '../widgets/types_row.dart';
import 'type_screen.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context).settings.arguments as Category;
    List<Product> products = [];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            category.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: category.types.length == 0
            ? FutureBuilder(
                future: Provider.of<ProductsProvider>(context, listen: false)
                    .fetchByCategory(category.title),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  products = snapshot.data;
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: products[i],
                      child: ProductItem(
                        isGridView: true,
                      ),
                    ),
                    itemCount: products.length,
                  );
                })
            : ListView(
                children: [
                  TypesRow(category.types),
                  SizedBox(
                    height: 10,
                  ),
                  ...category.types
                      .map((e) => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      TypeScreen.routeName,
                                      arguments: e);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.arrow_forward_rounded),
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              TypeScreen.routeName,
                                              arguments: e);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  height: 290,
                                  child: FutureBuilder(
                                    future: Provider.of<ProductsProvider>(
                                            context,
                                            listen: false)
                                        .fetchByType(e.title),
                                    builder: (ctx, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                        return Center(
                                            child: CircularProgressIndicator());
                                      List<Product> typeProducts = [];
                                        typeProducts = snapshot.data;
                                      return typeProducts == null || typeProducts.length == 0
                                          ? Center(
                                              child: Text('No products yet'),
                                            )
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: typeProducts.length,
                                              itemBuilder: (ctx, index) =>
                                                  ChangeNotifierProvider.value(
                                                      value:
                                                          typeProducts[index],
                                                      child: ProductItem()));
                                    },
                                  )),
                            ],
                          ))
                      .toList()
                ],
              ));
  }
}
