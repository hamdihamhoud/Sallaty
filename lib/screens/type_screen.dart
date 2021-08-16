import 'package:ecart/models/category.dart';
import 'package:ecart/models/product.dart';
import 'package:ecart/providers/products.dart';
import 'package:ecart/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeScreen extends StatelessWidget {
  static const routeName = '/type';

  @override
  Widget build(BuildContext context) {
    final Type type = ModalRoute.of(context).settings.arguments as Type;
    List<Product> products = [];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            type.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(icon: Icon(Icons.filter_alt_rounded), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder(
            future:
                Provider.of<ProductsProvider>(context,listen: false).fetchByType(type.title),
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
            }));
  }
}
