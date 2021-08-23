import 'package:ecart/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/code-verification';
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final key = GlobalKey<FormState>();

  var code = '';
  var trueCode = '';
  var _isLoading = false;

  void _save() async {
    if (!key.currentState.validate()) return;
    key.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (code == trueCode) {
      await Provider.of<AuthProvider>(context, listen: false)
          .codeConfirming(code);
      Navigator.of(context).pushNamed('/');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    trueCode = ModalRoute.of(context).settings.arguments as String;
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
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
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
