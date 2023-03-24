import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/customer_repository.dart';
import '../usermodels/customer.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({super.key, required this.user});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CustomerRepository customerRepository = CustomerRepository();
  late User _currentUser;
  late String _userUID;
  late String userName = '';
  late String name = '';
  late String email = '';
  late String city;
  final List<String> allergens = ['nuts', 'soja', 'milk'];
  List<bool?> allergenValues = [false, false, false];
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  late DateTime _selectedDate =
      DateTime(2000); // added for storing selected date
  late Customer customer;

  @override
  void initState() {
    _currentUser = widget.user;
    _userUID = _currentUser.uid;
    userName = widget.user.displayName ?? '';

    customerRepository
        .findCustomerWithEmail(_currentUser.email!)
        .then((foundCustomer) {
      setState(() {
        customer = foundCustomer!;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    userNameController.dispose();
    super.dispose();
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
            'Profile',
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
      body: FutureBuilder<Customer?>(
        future: customerRepository.findCustomerWithEmail(_currentUser.email!),
        builder: (BuildContext context, AsyncSnapshot<Customer?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            customer = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Current Value: ${customer.name}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Current Value: ${customer.username}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Current Value: ${customer.email}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                    MaterialButton(
                      minWidth: 200,
                      height: 60,
                      onPressed: () {
                        Customer customer = Customer(
                            username: userNameController.text,
                            name: nameController.text,
                            email: emailController.text,
                            points: 0,
                            birthday: _selectedDate);

                        customerRepository.updateCustomerDetails(
                            customer, _currentUser.email);
                      },
                      color: Colors.green[600],
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
