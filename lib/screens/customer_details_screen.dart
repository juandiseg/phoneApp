// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:eatnbeat/providers/customer_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../usermodels/customer.dart';
import 'home_screen.dart';
import 'package:intl/intl.dart';

class CustomerUserDetails extends StatefulWidget {
  final User user;

  const CustomerUserDetails({required this.user});

  @override
  _CustomerUserDetailsState createState() => _CustomerUserDetailsState();
}

class _CustomerUserDetailsState extends State<CustomerUserDetails> {
  late User _currentUser;
  CustomerRepository customerRepository = CustomerRepository();

  // id is auto generated, authId is provided by FirebaseAuth
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtSurname = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  late DateTime _selectedDate = DateTime(2000); // added for storing selected date


  final double fontSize = 18;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userUID = _currentUser.uid;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Welcome To EatNBeat',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtName,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtSurname,
                  decoration: InputDecoration(hintText: 'Username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextField(
                  controller: txtEmail,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Birthday',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    setState(() {
                      _selectedDate = selectedDate!;
                    });
                  },
                  controller: TextEditingController(
                    text: _selectedDate == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(_selectedDate),
                  ),
                ),
              ),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  minWidth: 360,
                  height: 60,
                  onPressed: () {
                    Customer customer = Customer(
                        name: txtName.text,
                        username: txtSurname.text,
                        email: txtEmail.text,
                        points: 0,
                      birthday: _selectedDate,);
                    customerRepository.saveCustomer(customer);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainPage(user: _currentUser),
                    ));
                  },
                  color: Colors.green[600],
                  child: const Text(
                    'Save and Proceed',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
