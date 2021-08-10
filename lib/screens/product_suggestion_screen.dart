import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductSuggestionScreen extends StatelessWidget {
  static const routeName = '/product-suggestion';

  @override
  Widget build(BuildContext context) {
    final String type = ModalRoute.of(context).settings.arguments;
    List<Product> products = [];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            type,
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
            future: Provider.of<ProductsProvider>(context).fetchBy(type),
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
                  mainAxisExtent: 290,
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
