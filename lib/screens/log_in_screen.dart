import 'package:eatnbeat/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/fire_auth.dart';
import '../utilities/validator.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.lightGreen[50],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title:  Text('Sign In', style: TextStyle(color: Colors.green[600]) ,),
          backgroundColor: Colors.lightGreen[50],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: ListView(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 400,
                height: 400,
              ),
              SizedBox(
                height: 20
                ,
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10)),
              Form(
                key: _formKey,
                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        focusNode: _focusEmail,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Email',
                          helperText: '',
                          hintText: 'myEmail@hotmail.com',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        controller: passwordController,
                        focusNode: _focusPassword,
                        obscureText: hidePassword,
                        validator: (value) => Validator.validatePassword(
                          password: value!,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          helperText: '',
                          hintText: 'My Password',
                          suffixIcon: InkWell(
                            onTap: _passwordView,
                            child: hidePassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                        ),
                      ),
                    ),
                    _isProcessing
                        ? CircularProgressIndicator(color: Colors.green[200])
                        : Column(
                            children: <Widget>[
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _focusEmail.unfocus();
                                    _focusPassword.unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      User? user = await FireAuth
                                          .signInUsingEmailPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );

                                      setState(() {
                                        _isProcessing = false;
                                      });
                                      if (FireAuth.message ==
                                          'user-not-found') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('user not found')));
                                      }

                                      if (FireAuth.message ==
                                          'wrong-password') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('wrong password')));
                                      }

                                      checkUserLogIn(user, context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[200]),
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Don\'t have an account?'),
                                  TextButton(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.green[600]),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                    },
                                  )
                                ],
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUserLogIn(User? user, BuildContext context) {
    if (user != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage(user: user)));
    }
  }

  void _passwordView() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
}
