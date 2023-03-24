import 'package:eatnbeat/screens/loyalty_points_screen.dart';
import 'package:eatnbeat/screens/menu_screen.dart';
import 'package:eatnbeat/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main_screen.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({super.key, required this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late User _currentUser;
  late String _userUID;
  late String userName;

  @override
  void initState() {
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    userName = widget.user.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.lightGreen[50],
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 15),
              child: ListTile(
                title: Text(
                  'Welcome $userName !',
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Menu(user: _currentUser)));
                },
                child: SizedBox(
                  height: 60,
                  width: 250,
                  child: TextButton(
                    child: Text("Menu".toUpperCase(),
                        style: TextStyle(fontSize: 19)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.green)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Menu(user: _currentUser)));
                    },
                  ),
                ),

              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: Center(
              child: SizedBox(
                height: 60,
                width: 250,
                child: TextButton(
                  child: Text("View Loyalty Points".toUpperCase(),
                      style: TextStyle(fontSize: 19)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LoyaltyPoints(user: _currentUser)));
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: Center(
              child: SizedBox(
                height: 60,
                width: 250,
                child: TextButton(
                  child: Text("View Profile".toUpperCase(),
                      style: TextStyle(fontSize: 19)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Profile(user: _currentUser)));
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            child: Center(
              child: SizedBox(
                height: 50,
                width: 150,
                child: TextButton(
                  child: Text("Sign Out".toUpperCase(),
                      style: TextStyle(fontSize: 19)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HomePage()));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
