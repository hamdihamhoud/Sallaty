import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final key = GlobalKey<FormState>();

  var code = '';

  void _save() {
    if (!key.currentState.validate()) return;
    //save
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your code has been sent please enter the code below',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  value.trim();
                  if (value.isEmpty) return 'this can\'t be empty';
                  return null;
                },
                onSaved: (value) {
                  value.trim();
                  code = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: _save,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
