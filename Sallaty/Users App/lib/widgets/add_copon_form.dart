import 'package:ecart/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCoponForm extends StatefulWidget {
  final Function setCoponDiscount;
  AddCoponForm(this.setCoponDiscount);
  @override
  _AddCoponFormState createState() => _AddCoponFormState();
}

class _AddCoponFormState extends State<AddCoponForm> {
  final _key = GlobalKey<FormState>();
  String code;
  Future<void> _save() async {
    if (!_key.currentState.validate()) return;
    _key.currentState.save();
    final discount = await Provider.of<Orders>(context,listen: false).checkCopon(code);
    Navigator.of(context).pop();
    widget.setCoponDiscount(discount);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _key,
      child: AlertDialog(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF828282),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        _save();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Please insert copon code above:'),
                cursorColor: Color(0xFF333333),
                validator: (value) {
                  if (value.isEmpty) return 'This can\'t be empty';
                  return null;
                },
                onSaved: (value) {
                  code = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
