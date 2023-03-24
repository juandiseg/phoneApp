import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loyalty_point_widget.dart';

class LoyaltyPoints extends StatefulWidget {
  final User user;

  const LoyaltyPoints({super.key, required this.user});

  @override
  _LoyaltyPointsState createState() => _LoyaltyPointsState();
}

class _LoyaltyPointsState extends State<LoyaltyPoints> {
  late User _currentUser;
  late String _userUID;
  late String userName;
  late String email;

  @override
  void initState() {
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    userName = widget.user.displayName!;
    email = widget.user.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.lightGreen[50],
          shadowColor: Colors.transparent,
          title: Text(
            'Loyalty Points',
            style: TextStyle(color: Colors.green[600]),
          ),
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
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoyaltyRectangle(email: email),
            ],
          ),
        ],
      ),
    );
  }
}
