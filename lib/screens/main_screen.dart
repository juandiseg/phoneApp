import 'package:eatnbeat/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'log_in_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen[50],
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        width: 500,
                        height: 500,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // the login button
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: Colors.black12),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green[200]!)),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      // creating the signup button
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => SignUp()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[200]),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
