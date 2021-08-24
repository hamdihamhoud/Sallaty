import 'package:ecart/models/product.dart';
import 'package:ecart/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

enum FilterType {
  all_products,
  orders,
  shiped,
  sold,
}

class FilterProductsScreen extends StatelessWidget {
  static const routeName = 'filter-products-screen';

  @override
  Widget build(BuildContext context) {
    final filterType = ModalRoute.of(context).settings.arguments as FilterType;

    String title;
    if (filterType == FilterType.all_products)
      title = 'All Products';
    else if (filterType == FilterType.orders)
      title = 'Orders';
    else if (filterType == FilterType.shiped)
      title = 'Shiped';
    else
      title = 'Sold';

    List<Product> products = [];

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: filterType == FilterType.all_products
            ? FutureBuilder(
                future:
                    Provider.of<ProductsProvider>(context,listen: false).premiumAllProducts(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  products = snapshot.data;
                  return GridView.builder(
                    itemCount: products.length,
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
                        isSeller: true,
                      ),
                    ),
                  );
                })
            : Container());
  }
}
