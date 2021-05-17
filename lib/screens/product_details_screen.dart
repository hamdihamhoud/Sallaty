import 'package:ecart/providers/cart.dart';
import 'package:ecart/widgets/colors_circule.dart';
import 'package:ecart/widgets/read_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/product_images_carousel.dart';

// ignore: must_be_immutable
class ProductDetailsSceen extends StatelessWidget {
  static const routeName = '/product-details';
  int amount = 1;
  void setAmount(int a) => amount = a;
  int cartItemId = 0;
  double price = 0;
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final Product product = productProvider.findId(productId);
    final cart = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);
    if (product.hasDiscount)
      price =
          (product.price - product.price * product.discountPercentage / 100);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black87,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  automaticallyImplyLeading: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Colors.white,
                        child: CarouselWithIndicator(product.imageUrls),
                      ),
                      title: SABT(
                        child: Text(
                          product.title,
                        ),
                      )),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 25,
                        left: 25,
                        top: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: Center(
                              child: Divider(
                                endIndent: 125,
                                indent: 125,
                                color: Theme.of(context).accentColor,
                                thickness: 3.5,
                              ),
                            ),
                          ),
                          Text(
                            '${product.title}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 31, 52, 76),
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              bottom: 10,
                            ),
                            child: Text(
                              productProvider.findSeller().name,
                              style: TextStyle(
                                color: Color.fromARGB(255, 180, 180, 180),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    if (!product.hasDiscount)
                                      Text(
                                        '${product.price.toInt()} S.P',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    if (product.hasDiscount)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          '${product.price.toInt()} S.P',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    if (product.hasDiscount)
                                      Text(
                                        '${price.toInt()} S.P',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Should be List view
                                    ColorCircule(Colors.black),
                                    ColorCircule(Colors.red),
                                    ColorCircule(Colors.orange),
                                    ColorCircule(Colors.blue),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: RatingBarIndicator(
                              rating: product.rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Text(
                              'Descreption',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: ReadMoreText(
                              '${product.description} ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 200, 200, 200),
                                fontSize: 15,
                              ),
                              colorClickableText: Colors.white,
                              trimCollapsedText: ' ... read more',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Text(
                              'Item details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          ...product.specs.keys.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 7,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "$e:  ",
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    product.specs[e],
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 200, 200, 200),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                              top: 8,
                            ),
                            child: Text(
                              'Returns & Replacement',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Return',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 200, 200, 200),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: product.isReturnable
                                      ? Text('${product.returningPeriod} day')
                                      : Text(
                                          'X',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Replace',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 200, 200, 200),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: product.isReturnable
                                      ? Text('${product.replacementPeriod} day')
                                      : Text(
                                          'X',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /* Positioned(
                    right: 30,
                    top: 70,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(255, 255, 120, 117),
                      ),
                      child: Center(
                        child: FavoriteIcon(product: product),
                      ),
                    ),
                  ), */
                ])),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: mediaQuery.size.width,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 15,
                bottom: 15,
              ),
              child: (productProvider.checkIfAvailable(productId))
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  'Add quantity',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              scrollable: true,
                              titlePadding: EdgeInsets.only(
                                bottom: 20,
                                top: 20,
                              ),
                              actionsPadding: EdgeInsets.all(0),
                              contentPadding: EdgeInsets.only(
                                left: 70,
                                right: 70,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    productProvider.removeFromList(
                                        productId, amount);
                                    cart.addItem(
                                      productId: product.id,
                                      quantity: amount,
                                      title: product.title,
                                      price: product.hasDiscount
                                          ? (product.price -
                                              product.price *
                                                  product.discountPercentage /
                                                  100)
                                          : product.price,
                                      imageUrls: product.imageUrls,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          amount > 1
                                              ? '$amount item\'s added to your cart'
                                              : '$amount item added to your cart',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).accentColor,
                                        duration: Duration(milliseconds: 700),
                                      ),
                                    );
                                    setAmount(1);
                                    cartItemId++;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              content: Center(
                                child: QuantityIcon(
                                  amount: amount,
                                  maxAmount: product.quantity,
                                  setter: setAmount,
                                ),
                              ),
                            );
                          },
                        ),
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 7,
                            ),
                            child: Text(
                              'ADD to Cart',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 100, 100),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Soldout',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 25,
      padding: const EdgeInsets.all(0),
      color: Colors.white,
      icon: widget.product.isFavorite
          ? Icon(Icons.favorite_rounded)
          : Icon(Icons.favorite_border_rounded),
      onPressed: () {
        setState(() {
          widget.product.toggleFav();
        });
      },
    );
  }
}

// ignore: must_be_immutable
class QuantityIcon extends StatefulWidget {
  QuantityIcon({
    Key key,
    @required this.amount,
    @required this.maxAmount,
    @required this.setter,
  }) : super(key: key);
  int amount;
  int maxAmount;
  Function setter;
  @override
  _QuantityIconState createState() => _QuantityIconState();
}

class _QuantityIconState extends State<QuantityIcon> {
  bool addButtonState = true;
  bool removeButtonState = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.amount == 1
                  ? Color.fromARGB(255, 66, 66, 66)
                  : Theme.of(context).accentColor,
            ),
            borderRadius: BorderRadius.circular(5),
            color: widget.amount == 1
                ? Color.fromARGB(255, 66, 66, 66)
                : Theme.of(context).accentColor,
          ),
          child: Center(
            child: IconButton(
              splashColor: removeButtonState
                  ? ThemeData().splashColor
                  : Colors.transparent,
              enableFeedback: removeButtonState,
              highlightColor: removeButtonState
                  ? ThemeData().highlightColor
                  : Colors.transparent,
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {
                if (widget.amount > 1) {
                  setState(() {
                    removeButtonState = true;
                    addButtonState = true;
                    widget.amount--;
                    widget.setter(widget.amount);
                  });
                  if (widget.amount == 1) {
                    setState(() {
                      removeButtonState = false;
                    });
                  }
                }
              },
            ),
          ),
        ),
        Text(
          widget.amount.toString(),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.amount == widget.maxAmount
                  ? Color.fromARGB(255, 66, 66, 66)
                  : Theme.of(context).accentColor,
            ),
            borderRadius: BorderRadius.circular(5),
            color: widget.amount == widget.maxAmount
                ? Color.fromARGB(255, 66, 66, 66)
                : Theme.of(context).accentColor,
          ),
          child: Center(
            child: IconButton(
              splashColor:
                  addButtonState ? ThemeData().splashColor : Colors.transparent,
              enableFeedback: addButtonState,
              highlightColor: addButtonState
                  ? ThemeData().highlightColor
                  : Colors.transparent,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {
                if (widget.amount < widget.maxAmount) {
                  setState(() {
                    removeButtonState = true;
                    widget.amount++;
                    widget.setter(widget.amount);
                  });
                  if (widget.amount == widget.maxAmount) {
                    setState(() {
                      addButtonState = false;
                    });
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SABT extends StatefulWidget {
  final Widget child;
  const SABT({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  _SABTState createState() {
    return new _SABTState();
  }
}

class _SABTState extends State<SABT> {
  ScrollPosition _position;
  bool _visible;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType();
    // print(settings.minExtent);
    bool visible =
        settings == null || settings.currentExtent > settings.minExtent + 10;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: _visible ? 0 : 1,
      child: widget.child,
    );
  }
}

/* Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black87,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  automaticallyImplyLeading: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: Colors.white,
                        child: CarouselWithIndicator(product.imageUrls),
                      ),
                      title: SABT(
                        child: Text(
                          product.title,
                        ),
                      )),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 155, 155, 155),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 25,
                            left: 25,
                            top: 25,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: Center(
                                  child: Divider(
                                    endIndent: 125,
                                    indent: 125,
                                    color: Color.fromARGB(255, 200, 200, 200),
                                    thickness: 3.5,
                                  ),
                                ),
                              ),
                              Text(
                                '${product.title}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 7,
                                  bottom: 15,
                                ),
                                child: Text(
                                  productProvider.findSeller().name,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 180, 180, 180),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        if (!product.hasDiscount)
                                          Text(
                                            '${product.price.toInt()} S.P',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        if (product.hasDiscount)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 2,
                                            ),
                                            child: Text(
                                              '${product.price.toInt()} S.P',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                        if (product.hasDiscount)
                                          Text(
                                            '${price.toInt()} S.P',
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // Should be List view
                                        ColorCircule(Colors.black),
                                        ColorCircule(Colors.red),
                                        ColorCircule(Colors.orange),
                                        ColorCircule(Colors.blue),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: RatingBarIndicator(
                                  rating: product.rating,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_rounded,
                                    color: Color.fromARGB(255, 254, 212, 145),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Text(
                                  'Descreption',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: ReadMoreText(
                                  '${product.description} ',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 200, 200, 200),
                                    fontSize: 15,
                                  ),
                                  colorClickableText: Colors.white,
                                  trimCollapsedText: ' ... read more',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: Text(
                                  'Item details',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              ...product.specs.keys.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 7,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$e:  ",
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        product.specs[e],
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 200, 200, 200),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10,
                                  top: 8,
                                ),
                                child: Text(
                                  'Returns & Replacement',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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
                                          color: Color.fromARGB(
                                              255, 200, 200, 200),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: product.isReturnable
                                          ? Text(
                                              '${product.returningPeriod} day')
                                          : Text(
                                              'X',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Replace',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 200, 200, 200),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: product.isReturnable
                                          ? Text(
                                              '${product.replacementPeriod} day')
                                          : Text(
                                              'X',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 70,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 255, 120, 117),
                          ),
                          child: Center(
                            child: FavoriteIcon(product: product),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: mediaQuery.size.width,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 15,
                bottom: 15,
              ),
              child: (productProvider.checkIfAvailable(productId))
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  'Add quantity',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              scrollable: true,
                              titlePadding: EdgeInsets.only(
                                bottom: 20,
                                top: 20,
                              ),
                              actionsPadding: EdgeInsets.all(0),
                              contentPadding: EdgeInsets.only(
                                left: 70,
                                right: 70,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    productProvider.removeFromList(
                                        productId, amount);
                                    cart.addItem(
                                      productId: product.id,
                                      quantity: amount,
                                      title: product.title,
                                      price: product.hasDiscount
                                          ? (product.price -
                                              product.price *
                                                  product.discountPercentage /
                                                  100)
                                          : product.price,
                                      imageUrls: product.imageUrls,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          amount > 1
                                              ? '$amount item\'s added to your cart'
                                              : '$amount item added to your cart',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).accentColor,
                                        duration: Duration(milliseconds: 700),
                                      ),
                                    );
                                    setAmount(1);
                                    cartItemId++;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              content: Center(
                                child: QuantityIcon(
                                  amount: amount,
                                  maxAmount: product.quantity,
                                  setter: setAmount,
                                ),
                              ),
                            );
                          },
                        ),
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 7,
                            ),
                            child: Text(
                              'ADD to Cart',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 100, 100),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Soldout',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ), */
