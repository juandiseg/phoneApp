import 'package:eatnbeat/providers/customer_repository.dart';
import 'package:flutter/material.dart';

class LoyaltyRectangle extends StatefulWidget {
  final String email;

  const LoyaltyRectangle({Key? key, required this.email}) : super(key: key);

  @override
  _LoyaltyRectangleState createState() => _LoyaltyRectangleState();
}

class _LoyaltyRectangleState extends State<LoyaltyRectangle> {
  int points = 0;
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadCustomer();
  }

  Future<void> _loadCustomer() async {
    final customerProvider = CustomerRepository();
    final customer = await customerProvider.findCustomerWithEmail(widget.email);
    if (customer != null) {
      setState(() {
        points = customer.points;
        email = customer.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Email address',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  email,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Points',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Text(
                      points.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer grade',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Silver',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
