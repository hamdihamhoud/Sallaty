import 'package:ecart/models/product.dart';
import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/products.dart';
import 'package:ecart/widgets/alert_dialog.dart';
import 'package:ecart/widgets/not_available_container.dart';
import 'package:ecart/widgets/quantity_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddtoCart extends StatefulWidget {
  final Product product;
  const AddtoCart({this.product});
  @override
  _AddtoCartState createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {
  final List<String> sizes = [];
  bool colorSelected = false;
  bool sizeSelected = false;
  bool notAvailable = false;
  bool addButtonState = false;
  Color _selectedColor;
  String _selectedSize;
  int amount = 1;
  void setAmount(int a) => amount = a;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<Cart>(context);
    final mediaQuery = MediaQuery.of(context);
    bool hasSize = widget.product.colorsAndQuantityAndSizes.entries
                .elementAt(0)
                .value
                .keys
                .elementAt(0) !=
            '0'
        ? true
        : false;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose your Color",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 20,
                    ),
                  ),
                  DropdownButton<Color>(
                    value: _selectedColor,
                    items: widget.product.colorsAndQuantityAndSizes.keys.map(
                      (Color color) {
                        return DropdownMenuItem<Color>(
                          value: color,
                          child: new Container(
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                )),
                            width: mediaQuery.size.width * 0.25,
                            height: 30,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (newvalue) {
                      setState(
                        () {
                          notAvailable = false;
                          _selectedSize = null;
                          sizeSelected = false;
                          colorSelected = false;
                          setAmount(1);
                          sizes.clear();
                          _selectedColor = newvalue;
                          colorSelected = true;
                          if (hasSize) {
                            notAvailable = false;
                            for (int j = 0;
                                j <
                                    productProvider.products
                                        .firstWhere((element) =>
                                            element.id == widget.product.id)
                                        .colorsAndQuantityAndSizes
                                        .entries
                                        .firstWhere((element) =>
                                            element.key == _selectedColor)
                                        .value
                                        .length;
                                j++) {
                              sizes.insert(
                                  j,
                                  productProvider.products
                                      .firstWhere((element) =>
                                          element.id == widget.product.id)
                                      .colorsAndQuantityAndSizes
                                      .entries
                                      .firstWhere((element) =>
                                          element.key == _selectedColor)
                                      .value
                                      .keys
                                      .elementAt(j));
                            }
                          } else {
                            _selectedSize = '0';
                            if (productProvider.products
                                    .firstWhere((element) =>
                                        element.id == widget.product.id)
                                    .colorsAndQuantityAndSizes
                                    .entries
                                    .firstWhere((element) =>
                                        element.key == _selectedColor)
                                    .value
                                    .entries
                                    .firstWhere((element) =>
                                        element.key == _selectedSize)
                                    .value ==
                                0) {
                              notAvailable = true;
                            }
                          }
                        },
                      );
                    },
                    hint: Text('Colors'),
                  ),
                ],
              ),
              if (colorSelected && hasSize)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Choose your Size",
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 20,
                      ),
                    ),
                    DropdownButton<String>(
                      hint: Text("Sizes"),
                      value: _selectedSize,
                      onChanged: (newvalue) {
                        setState(
                          () {
                            notAvailable = false;
                            setAmount(1);
                            _selectedSize = newvalue;
                            sizeSelected = true;
                            if (productProvider.products
                                    .firstWhere((element) =>
                                        element.id == widget.product.id)
                                    .colorsAndQuantityAndSizes
                                    .entries
                                    .firstWhere((element) =>
                                        element.key == _selectedColor)
                                    .value
                                    .entries
                                    .firstWhere((element) =>
                                        element.key == _selectedSize)
                                    .value ==
                                0) notAvailable = true;
                          },
                        );
                      },
                      items: sizes.map(
                        (String size) {
                          return DropdownMenuItem<String>(
                            value: size,
                            child: new Container(
                              child: new Text(size),
                              width: mediaQuery.size.width * 0.25,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              if ((colorSelected && hasSize && sizeSelected) ||
                  (colorSelected && !hasSize))
                productProvider.products
                            .firstWhere(
                                (element) => element.id == widget.product.id)
                            .colorsAndQuantityAndSizes
                            .entries
                            .firstWhere(
                                (element) => element.key == _selectedColor)
                            .value
                            .entries
                            .firstWhere(
                                (element) => element.key == _selectedSize)
                            .value >
                        0
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: QuantityIcon(
                            amount: amount,
                            maxAmount: productProvider.getProductMaxAmount(
                              widget.product.id,
                              _selectedColor,
                              _selectedSize,
                            ),
                            setter: setAmount),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(
                          20,
                        ),
                        child: NotAvailable(
                          hasSize: hasSize,
                        ),
                      ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  onEnd: () {
                    setState(() {
                      addButtonState = !addButtonState;
                    });
                  },
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.ease,
                  height: 42,
                  width: notAvailable
                      ? mediaQuery.size.width * 0.89
                      : mediaQuery.size.width * 0.42,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 19,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Color(0xFF333333),
                      backgroundColor: Colors.black12,
                    ),
                  ),
                ),
                if (!notAvailable && !addButtonState)
                  Container(
                    height: 42,
                    width: mediaQuery.size.width * 0.42,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if ((colorSelected && hasSize && sizeSelected) ||
                            (colorSelected && !hasSize)) {
                          if (!notAvailable) {
                            productProvider.removeFromList(
                              id: widget.product.id,
                              color: _selectedColor,
                              amount: amount,
                              size: _selectedSize,
                            );
                            cartProvider.addItem(
                              keys: widget.product.id.toString() +
                                  _selectedColor.value.toString() +
                                  _selectedSize.toString(),
                              productId: widget.product.id,
                              price: widget.product.discountPercentage != 0
                                  ? (widget.product.price -
                                      widget.product.price *
                                          widget.product.discountPercentage /
                                          100)
                                  : widget.product.price,
                              title: widget.product.title,
                              quantity: amount,
                              color: _selectedColor,
                              imageUrl: widget.product.imageUrls[0],
                              size: _selectedSize,
                            );
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: amount == 1
                                    ? Text(
                                        '$amount item added to your cart',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    : Text(
                                        '$amount items added to your cart',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                backgroundColor: Theme.of(context).primaryColor,
                                duration: Duration(
                                  milliseconds: 1500,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          hasSize
                              ? showAlertDialog(
                                  context: context,
                                  content: colorSelected
                                      ? 'You must select a size!'
                                      : 'You must select a color!',
                                )
                              : showAlertDialog(
                                  context: context,
                                  content: "You must select a color!",
                                );
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
