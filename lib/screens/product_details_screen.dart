import 'package:ecart/providers/cart.dart';
import 'package:ecart/widgets/alert_dialog.dart';
import 'package:ecart/widgets/colors_circule.dart';
import 'package:ecart/widgets/favorite_icon.dart';
import 'package:ecart/widgets/read_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_button/menu_button.dart';
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
  int amount = 1;
  void setAmount(int a) => amount = a;
  Color selectedvalue;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ProducDetailsScreenArgs;
    final String productId = args.id;
    isSeller = args.isSeller;
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final Product product = productProvider.findId(productId);
    final cart = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);
    final colorsNumber = product.colorsAndQuantityAndSizes.keys.length;
    final List<int> quantity = [];
    for (int i = 0; i < colorsNumber; i++) {
      for (int j = 0;
          j <
              product.colorsAndQuantityAndSizes.entries
                  .elementAt(i)
                  .value
                  .values
                  .length;
          j++) {
        if (j == 0)
          quantity.insert(
              i,
              product.colorsAndQuantityAndSizes.entries
                  .elementAt(i)
                  .value
                  .values
                  .elementAt(j)
                  .toInt());
        else
          quantity[i] += product.colorsAndQuantityAndSizes.entries
              .elementAt(i)
              .value
              .values
              .elementAt(j)
              .toInt();
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                bottom: PreferredSize(
                  child: Container(),
                  preferredSize: Size(0, 20),
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Color(0xFF333333),
                            ),
                          )
                        : IconButton(
                            icon: FaIcon(FontAwesomeIcons.edit),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                AddProductScreen.routeName,
                                arguments: product.id,
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
                      return Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          '${product.title}',
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          productProvider.findSeller().name,
                                          style: TextStyle(
                                            color: Color(0xFF828282),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            if (product.discountPercentage == 0)
                                              Text(
                                                '${product.price.toInt()} S.P',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            if (product.discountPercentage > 0)
                                              Text(
                                                '${product.price.toInt()} S.P',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            if (product.discountPercentage > 0)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                child: Text(
                                                  '${(product.price - product.price * product.discountPercentage / 100)} S.P',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                          left: 0,
                                        ),
                                        child: RatingBarIndicator(
                                          rating: product.rating,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star_rounded,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showAlertDialog(
                                          context: context,
                                          colorsAndQuantityAndSizes:
                                              product.colorsAndQuantityAndSizes,
                                          quantity: quantity);
                                    },
                                    child: Column(
                                      children: [
                                        if (colorsNumber <= 3)
                                          for (int i = 0; i < colorsNumber; i++)
                                            ColorCircule(
                                              product.colorsAndQuantityAndSizes
                                                  .keys
                                                  .elementAt(i),
                                            ),
                                        if (colorsNumber > 3)
                                          for (int i = 0; i < 3; i++)
                                            ColorCircule(
                                              product.colorsAndQuantityAndSizes
                                                  .keys
                                                  .elementAt(i),
                                            ),
                                        if (colorsNumber > 3)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 3,
                                            ),
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(25),
                                                ),
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 3,
                                                ),
                                                color: Colors.black12,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "+${colorsNumber - 3}",
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Text(
                                  'Descreption',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: ReadMoreText(
                                  '${product.description} ',
                                  style: TextStyle(
                                    color: Color(0xFF828282),
                                    fontSize: 16,
                                  ),
                                  colorClickableText: Color(0xFF333333),
                                ),
                              ),
                              (product.specs.length != 0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        'Item details',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 0,
                                      ),
                                    ),
                              ...product.specs.keys.map((e) {
                                if (product.specs.length != 0)
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 7,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$e:  ",
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          product.specs[e],
                                          style: TextStyle(
                                            color: Color(0xFF828282),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                              }).toList(),
                              (product.specs.length != 0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                        top: 3,
                                      ),
                                      child: Text(
                                        'Returns & Replacement',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        'Returns & Replacement',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Return',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: product.returning.period != 0
                                          ? Text(
                                              '${product.returning.period} ' +
                                                  product.returning.type
                                                      .toString()
                                                      .split('.')
                                                      .last,
                                              style: TextStyle(
                                                color: Color(0xFF828282),
                                                fontSize: 16,
                                              ),
                                            )
                                          : Text(
                                              'X',
                                              style: TextStyle(
                                                color: Color(0xFF828282),
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 7,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Replace',
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: product.replacement.period != 0
                                          ? Text(
                                              '${product.replacement.period} ' +
                                                  product.replacement.type
                                                      .toString()
                                                      .split('.')
                                                      .last,
                                              style: TextStyle(
                                                color: Color(0xFF828282),
                                                fontSize: 16,
                                              ),
                                            )
                                          : Text(
                                              'X',
                                              style: TextStyle(
                                                color: Color(0xFF828282),
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 85,
                                width: mediaQuery.size.width,
                              )
                            ],
                          ),
                        ),
                      );
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
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      barrierColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                      context: context,
                      builder: (context) => BottomSheetContent(product));
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
      ),
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  final Product product;
  BottomSheetContent(this.product);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final List<String> sizes = [];
  Color selectedvalue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Choose your Color",
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                ),
              ),
              DropdownButton(
                value: selectedvalue,
                onChanged: (newvalue) {
                  selectedvalue = newvalue;
                  setState(() {});
                  // for (int j = 0;
                  //     j <
                  //         product.colorsAndQuantityAndSizes
                  //             .entries
                  //             .firstWhere((element) =>
                  //                 element.key ==
                  //                 selectedvalue)
                  //             .value
                  //             .length;
                  //     j++) {
                  //     sizes.insert(
                  //       j,
                  //       product.colorsAndQuantityAndSizes
                  //           .entries
                  //           .firstWhere((element) =>
                  //               element.key ==
                  //               selectedvalue)
                  //           .value
                  //           .keys
                  //           .elementAt(j));
                },
                items: widget.product.colorsAndQuantityAndSizes.keys
                    .map(
                      (e) => DropdownMenuItem(
                        child: Container(
                          decoration: BoxDecoration(
                              color: e,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              )),
                          width: MediaQuery.of(context).size.width * 0.33,
                          height: 30,
                        ),
                        value: e,
                      ),
                    )
                    .toList(),
                hint: Text('Colors'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Choose your Size",
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                ),
              ),
              DropdownButton(
                items: sizes
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          if (widget.product.colorsAndQuantityAndSizes.entries
                  .elementAt(0)
                  .value
                  .keys
                  .elementAt(0) !=
              '0')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Discard'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Add'),
                ),
              ],
            )
        ],
      ),
    );
  }
}
