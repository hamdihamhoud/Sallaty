import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import 'auth_verification_screen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: deviceSize.width * 0.75,
                      margin: const EdgeInsets.only(bottom: 15.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/gray-logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'username': '',
    'number': '',
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _phoneAndUsernameController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _fadeAnimtaion;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -2), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _fadeAnimtaion = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    } else if (int.tryParse(s) != null) {
      return true;
    } else
      return false;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        if (_authData['email'] == '')
          await Provider.of<AuthProvider>(context, listen: false)
              .signInWithNumber(
            _authData['number'],
            _authData['password'],
          );
        else
          await Provider.of<AuthProvider>(context, listen: false)
              .signInWithEmail(
            _authData['email'],
            _authData['password'],
          );
      } else {
        // Sign user up
        await Provider.of<AuthProvider>(context, listen: false).signUp(
          _authData['username'],
          _authData['number'],
          _authData['email'],
          _authData['password'],
        );
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () async {
                          final code = await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .generateCode();
                          Navigator.pushNamed(
                              context, VerificationScreen.routeName,
                              arguments: code);
                        },
                        child: Text('Ok')),
                  ],
                  content:
                      Text('A confirmation code will be sent to your email'),
                ));
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      } else if (error.toString().contains('UsernameTaken')) {
        errorMessage = 'Username Taken.';
      } else if (error.toString().contains('UserEmailTaken')) {
        errorMessage = 'User Email Taken.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _phoneAndUsernameController.clear();
        _passwordController.clear();
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _phoneAndUsernameController.clear();
        _passwordController.clear();
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 448 : 268,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 448 : 268),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _phoneAndUsernameController,
                  decoration: _authMode == AuthMode.Signup
                      ? const InputDecoration(labelText: 'Username')
                      : const InputDecoration(
                          labelText: 'Email or Phone Number'),
                  validator: (value) {
                    if (value.isEmpty) return "This can't be empty!";
                    if (_authMode == AuthMode.Signup && isNumeric(value))
                      return "This can't be a number!";
                    return null;
                  },
                  onSaved: (value) {
                    _authMode == AuthMode.Signup
                        ? _authData['username'] = value
                        : !isNumeric(value)
                            ? _authData['email'] = value
                            : _authData['number'] = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5)
                      return 'Password is too short!';
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      maxHeight: _authMode == AuthMode.Signup ? 360 : 0,
                      minHeight: _authMode == AuthMode.Signup ? 180 : 0),
                  child: FadeTransition(
                    opacity: _fadeAnimtaion,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              enabled: _authMode == AuthMode.Signup,
                              decoration: const InputDecoration(
                                  labelText: 'Confirm Password'),
                              obscureText: true,
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value != _passwordController.text)
                                        return 'Passwords do not match!';
                                      return null;
                                    }
                                  : null,
                            ),
                            TextFormField(
                              enabled: _authMode == AuthMode.Signup,
                              decoration:
                                  const InputDecoration(labelText: 'E-Mail'),
                              keyboardType: TextInputType.emailAddress,
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value.isEmpty || !value.contains('@'))
                                        return 'Invalid email!';
                                      return null;
                                    }
                                  : null,
                              onSaved: (value) {
                                if(_authMode == AuthMode.Signup)
                                _authData['email'] = value;
                              },
                            ),
                            TextFormField(
                              enabled: _authMode == AuthMode.Signup,
                              decoration: const InputDecoration(
                                prefix: Text('09'),
                                labelText: 'Phone Number',
                              ),
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value.isEmpty)
                                        return "This can't be empty!";
                                      if (value.length != 8 ||
                                          !isNumeric(value))
                                        return "Invalid Phone Number";
                                      return null;
                                    }
                                  : null,
                              onSaved: (value) {
                                if (_authMode == AuthMode.Signup) {
                                  _authData['number'] = '09' + value;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                else
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0)),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: Text(
                      _authMode == AuthMode.Login ? 'Log In' : 'Sign Up',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.button.color),
                    ),
                    onPressed: _submit,
                  ),
                const SizedBox(
                  height: 8,
                ),
                OutlinedButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'Sign Up' : 'Log In'}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: _switchAuthMode,
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(color: Theme.of(context).primaryColor)),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
