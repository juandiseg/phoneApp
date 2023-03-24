import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/email_verification.dart';
import '../auth/fire_auth.dart';
import '../utilities/validator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }

  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

  final double fontSize = 18;

  bool _isProcessing = false;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focusConfirmPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.lightGreen[50],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.green[600],
            ),
          ),
          backgroundColor: Colors.lightGreen[50],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'Welcome To Eat n Beat',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                    bottom: 10,
                  ),
                  child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: txtName,
                            focusNode: _focusName,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_outlined),
                              labelText: 'Name',
                              helperText: '',
                              hintText: 'Slim Shady',
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: txtEmail,
                            focusNode: _focusEmail,
                            validator: (value) => Validator.validateEmail(
                              email: value!,
                            ),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: 'Email',
                              helperText: '',
                              hintText: 'myEmail@hotmail.com',
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: txtPassword,
                            focusNode: _focusPassword,
                            obscureText: _hidePassword,
                            validator: (value) => Validator.validatePassword(
                              password: value!,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              helperText: '',
                              hintText: 'not123456pls',
                              suffixIcon: InkWell(
                                onTap: _passwordView,
                                child: _hidePassword
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: txtConfirmPassword,
                            focusNode: _focusConfirmPassword,
                            obscureText: _hideConfirmPassword,
                            validator: (value) =>
                                Validator.validateConfirmPassword(
                                    confirmPassword: value!,
                                    Password: txtPassword.text),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Confirm Password',
                              helperText: '',
                              hintText: 'Repeat Password',
                              suffixIcon: InkWell(
                                onTap: _confirmPasswordView,
                                child: _hideConfirmPassword
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          _isProcessing
                              ? CircularProgressIndicator(
                                  color: Colors.green[200])
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (_registerFormKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isProcessing = true;
                                            });
                                            User? user = await FireAuth
                                                .registerUsingEmailPassword(
                                              name: txtName.text,
                                              email: txtEmail.text,
                                              password: txtPassword.text,
                                            );

                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EmailVerification(
                                                          user: user),
                                                ),
                                                ModalRoute.withName('/'),
                                              );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green[600]),
                                        child: const Text(
                                          'Sign up',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _passwordView() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _confirmPasswordView() {
    setState(() {
      _hideConfirmPassword = !_hideConfirmPassword;
    });
  }
}
