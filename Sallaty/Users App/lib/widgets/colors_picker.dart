import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../widgets/badge.dart';

class ColorsPicker extends StatefulWidget {
  final Function addColor;
  final bool hasSizes;
  ColorsPicker(this.addColor, this.hasSizes);
  @override
  _ColorsPickerState createState() => _ColorsPickerState();
}

class _ColorsPickerState extends State<ColorsPicker> {
  final _form = GlobalKey<FormState>();
  Color currentColor = Colors.white;
  void changeColor(Color color) => currentColor = color;
  Map<String, int> sizesAndQuantity = {};

  void addSizeAndQuantity(String size, int quantity, BuildContext ctx) {
    Navigator.of(ctx).pop();
    setState(() {
      if (sizesAndQuantity.containsKey(size))
        sizesAndQuantity.update(size, (value) => quantity);
      else
        sizesAndQuantity.putIfAbsent(size, () => quantity);
    });
  }

  void save() {
    if (widget.hasSizes && sizesAndQuantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incomplete Information !'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (!_form.currentState.validate()) return;
    !widget.hasSizes
        ? _form.currentState.save()
        : widget.addColor(currentColor, sizesAndQuantity);
    currentColor = Colors.white;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true, //!!!!!
                showLabel: true,
                paletteType: PaletteType.hsv,
                pickerAreaBorderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(2.0),
                  topRight: const Radius.circular(2.0),
                ),
              ),
              !widget.hasSizes
                  ? Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                              child: Text(
                            'quantity',
                          )),
                          Container(
                            width: 40,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              cursorColor: Color(0xFF333333),
                              validator: (value) {
                                value.trim();
                                if (value.isEmpty)
                                  return 'This can\'t be empty';
                                if (int.tryParse(value) == null)
                                  return 'This must be a number';
                                return null;
                              },
                              onSaved: (value) {
                                value.trim();
                                widget.addColor(currentColor, int.parse(value));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 60,
                      width: 280,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            if (sizesAndQuantity.length == 0)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Text('Add Sizes :'),
                              )
                            else
                              ...sizesAndQuantity.entries
                                  .map((e) => Badge(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                        child: Text(
                                          e.key,
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                          ),
                                        ),
                                      ),
                                      value: e.value.toString()))
                                  .toList(),
                            Container(
                              margin: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.add,
                                  color: Color(0xFF333333),
                                ),
                                onPressed: () {
                                  showAddSizeDialog(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              TextButton(
                onPressed: save,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showAddSizeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (ctx) {
          final _sizeForm = GlobalKey<FormState>();
          String _size;
          int _quantity;
          void _save() {
            if (!_sizeForm.currentState.validate()) return;
            _sizeForm.currentState.save();
            addSizeAndQuantity(_size, _quantity, context);
          }

          return Form(
            key: _sizeForm,
            child: AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      _save();
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Size'),
                    cursorColor: Color(0xFF333333),
                    validator: (value) {
                      value.trim();
                      if (value.isEmpty) return 'This can\'t be empty';
                      return null;
                    },
                    onSaved: (value) {
                      value.trim();
                      _size = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    cursorColor: Color(0xFF333333),
                    validator: (value) {
                      value.trim();
                      if (value.isEmpty) return 'This can\'t be empty';
                      if (int.tryParse(value) == null)
                        return 'This must be a number';
                      return null;
                    },
                    onSaved: (value) {
                      value.trim();
                      _quantity = int.parse(value);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
