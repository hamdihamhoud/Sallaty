import 'package:ecart/providers/cart.dart';
import 'package:ecart/screens/cart_screen.dart';
import 'package:ecart/widgets/add_to_cart.dart';
import 'package:ecart/widgets/badge.dart';
import 'package:ecart/widgets/favorite_icon.dart';
import 'package:ecart/widgets/product_details_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/product_images_carousel.dart';
import '../models/product_details_screen_args.dart';
import 'add_product_screen.dart';

class ProductDetailsSceen extends StatefulWidget {
  static const routeName = '/product-details';
  @override
  _ProductDetailsSceenState createState() => _ProductDetailsSceenState();
}

class _ProductDetailsSceenState extends State<ProductDetailsSceen> {
  bool isSeller = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ProducDetailsScreenArgs;
    final String productId = args.id;
    isSeller = args.isSeller;
    final productProvider = Provider.of<ProductsProvider>(context);
    Product product;
    final cart = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);
    int colorsNumber;
    final theme = Theme.of(context);
    bool hasSize;

    int quantity;
    return Scaffold(
      body: FutureBuilder(
          future: productProvider.findId(productId),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            product = snapshot.data;
            colorsNumber = product.colorsAndQuantityAndSizes.keys.length;
            hasSize = product.colorsAndQuantityAndSizes.entries
                        .elementAt(0)
                        .value
                        .entries
                        .elementAt(0)
                        .key ==
                    '0'
                ? false
                : true;
            quantity = productProvider.quantityCounter(
                colorsNumber: colorsNumber, product: product);
            return Stack(
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      bottom: PreferredSize(
                        child: Container(),
                        preferredSize: Size(0, 35),
                      ),
                      pinned: false,
                      expandedHeight: mediaQuery.size.height * 0.65,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: !isSeller
                              ? IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, CartScreen.routeName);
                                  },
                                  icon: Badge(
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Color(0xFF3333333),
                                      size: 30,
                                    ),
                                    value: cart.itemCount.toStringAsFixed(0),
                                    color: theme.primaryColor,
                                  ),
                                )
                              : IconButton(
                                  icon: FaIcon(FontAwesomeIcons.edit),
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      AddProductScreen.routeName,
                                      arguments: product,
                                    );
                                  },
                                ),
                        ),
                      ],
                      leading: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Color(0xFF333333),
                        ),
                      ),
                      flexibleSpace: Stack(
                        children: [
                          Positioned(
                              child: CarouselWithIndicator(product.imageUrls),
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0),
                          Positioned(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Divider(
                                  color: Color(0xFF828282),
                                  height: 20,
                                  thickness: 3,
                                  endIndent: 175,
                                  indent: 175,
                                ),
                              ),
                            ),
                            bottom: 0,
                            left: 0,
                            right: 0,
                          ),
                          Positioned(
                            bottom: 5,
                            right: 25,
                            child: FavoriteIcon(product: product),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        // ignore: missing_return
                        (BuildContext context, int index) {
                          if (index == 0) {
                            return ProductDetailsList(
                                product: product,
                                productProvider: productProvider,
                                theme: theme,
                                colorsNumber: colorsNumber,
                                hasSize: hasSize,
                                mediaQuery: mediaQuery);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                if (!isSeller)
                  Positioned(
                    bottom: 20,
                    right: 20,
                    left: 20,
                    child: quantity == 0
                        ? Container(
                            height: 60,
                            width: mediaQuery.size.width,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'This product is no longer available',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  barrierColor: Colors.black38,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) => Wrap(
                                        children: [
                                          AddtoCart(
                                            product: product,
                                          ),
                                        ],
                                      ));
                            },
                            child: Container(
                              height: 60,
                              width: mediaQuery.size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF333333),
                              onPrimary: Color(0xFF828282),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                  ),
              ],
            );
          }),
    );
  }
}
