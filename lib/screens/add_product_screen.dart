import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/category.dart';
import '../models/period.dart';

import '../widgets/image_input.dart';
import '../widgets/colors_picker.dart';
import '../widgets/add_image_viewer.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _form = GlobalKey<FormState>();

  Map<Color, Map<String, int>> colorsAndQuantity = {};
  bool hasSizes = true;

  Period warranty = Period(
    type: TimeType.weeks,
  );
  Period replaceable = Period(
    type: TimeType.weeks,
  );
  Period returnable = Period(
    type: TimeType.weeks,
  );

  Category category;
  Type type;

  List<File> images = [];

  void saveForm() {}

  void setImage(File image) {
    setState(() {
      images.add(image);
    });
  }

  void addColor(Color color, int quantity) {
    setState(() {
      if (colorsAndQuantity.containsKey(color))
        colorsAndQuantity[color] = {'0': quantity};
      colorsAndQuantity.putIfAbsent(color, () => {'0': quantity});
      print(colorsAndQuantity);
    });
  }

  void addColorWithSizes(Color color, Map<String, int> sizesAndQuantity) {
    setState(() {
      if (colorsAndQuantity.containsKey(color))
        colorsAndQuantity[color] = sizesAndQuantity;
      colorsAndQuantity.putIfAbsent(color, () => sizesAndQuantity);
    });
    print(colorsAndQuantity);
  }

  Widget periodAddingBuilder(String title, Period period) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Text(title,style: Theme.of(context).textTheme.subtitle1,),
          Spacer(),
          DropdownButton(
            value: period.period,
            items: period
                .typeOptions()
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(
                      e.toString(),
                    ),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                period.period = value;
              });
            },
          ),
          SizedBox(
            width: 14,
          ),
          DropdownButton(
            value: period.type,
            items: TimeType.values
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(
                      e.toString().split('.').last,
                    ),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (period.type != value) {
                period.period = 0;
                setState(() {
                  period.type = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Product Details',
          ),
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.save),
              onPressed: saveForm,
            )
          ],
        ),
        body: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (images.length != 0) AddImageViewer(images),
                ImageInput(setImage),
                TextFormField(
                  initialValue: '', //_initValues['title'],
                  decoration: const InputDecoration(labelText: 'Title' ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) return "This can't be empty";
                    return null;
                  },
                  onSaved: (value) {},
                ),
                TextFormField(
                  initialValue: '', //_initValues['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) return "This can't be empty";
                    if (double.tryParse(value) == null)
                      return "Invalid input!!";
                    return null;
                  },
                  onSaved: (value) {},
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text('Multple Sizes'),
                  activeColor: Theme.of(context).primaryColor,
                  value: hasSizes,
                  onChanged: (value) {
                    setState(() {
                      hasSizes = value;
                    });
                  },
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text('COLORS LISTVIEW HERE '),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => !hasSizes
                                ? ColorsPicker(addColor, hasSizes)
                                : ColorsPicker(addColorWithSizes, hasSizes));
                      },
                      child: const Text('Add Color'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  // initialValue: ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  maxLines: 8,
                  validator: (value) {
                    if (value.isEmpty) return "This can't be empty";
                    return null;
                  },
                  onSaved: (value) {},
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Category',style: Theme.of(context).textTheme.subtitle1,),
                      DropdownButton(
                        value: category,
                        hint: Text('select a category'),
                        items: categories
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e.title),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (category != value) {
                            type = null;
                            setState(() {
                              category = value;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
                if (category != null && category.types.length != 0)
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Type',style: Theme.of(context).textTheme.subtitle1,),
                        DropdownButton(
                          value: type,
                          hint: Text('select a type'),
                          items: category.types
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e.title),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              type = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                periodAddingBuilder('Warranty', warranty),
                periodAddingBuilder('Replaceable', replaceable),
                periodAddingBuilder('Returnable', returnable),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text('Discount',style: Theme.of(context).textTheme.subtitle1,),
                      Spacer(),
                      Container(
                        width: 40,
                        height: 20,
                        child: TextFormField(
                          // initialValue: ,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) return "This can't be empty";
                            if (double.tryParse(value) == null)
                              return "This must be a number";
                            if (double.parse(value) > 100 ||
                                double.parse(value) < 0)
                              return "Invalid Input !";
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                      Text('%'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
