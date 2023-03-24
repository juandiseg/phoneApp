import 'package:mysql1/mysql1.dart';

import '../usermodels/customer.dart';
import 'db_connection.dart';

class CustomerRepository {
  Future<Customer?> findCustomerWithEmail(String email) async {

    final conn = await DatabaseConnection().getConnection();

    final results =
        await conn.query('SELECT * FROM customers WHERE email = ?', [email]);

    Customer? customer;

    for (var row in results) {
      customer = Customer.fromJson(row.fields);
      print(customer.toJson());
    }

    await conn.close();

    return customer;
  }

  Future<void> saveCustomer(Customer customer) async {
    // Create a connection to the database
    final conn = await DatabaseConnection().getConnection();

    try {
      // Execute the SQL statement to insert the new customer
      final result = await conn.query(
        'INSERT INTO customers (username, name, email, birthday, points) '
        'VALUES (?, ?, ?, ?, ?)',
        [
          customer.username,
          customer.name,
          customer.email,
          customer.birthday.toString(),
          customer.points,
        ],
      );

      // Print a success message
      print('Customer saved successfully');
    } catch (e) {
      // Print an error message and rethrow the exception
      print('Error saving customer: $e');
      rethrow;
    } finally {
      // Close the database connection
      await conn.close();
    }
  }

  Future<String?> getCustomerName(String email) async {
    final settings = ConnectionSettings(
      host: '172.20.10.12',
      port: 3306,
      user: 'burak',
      db: 'beatneat',
    );

    final conn = await MySqlConnection.connect(settings);

    try {
      final result = await conn
          .query('SELECT name FROM customers WHERE email = ?', [email]);

      if (result.isNotEmpty) {
        final row = result.first;
        return row['name'] as String?;
      } else {
        return null;
      }
    } finally {
      await conn.close();
    }
  }

  Future<void> updateCustomerDetails(Customer customer, String? email) async {
    final settings = ConnectionSettings(
      host: '172.20.10.12',
      port: 3306,
      user: 'burak',
      db: 'beatneat',
    );

    final conn = await MySqlConnection.connect(settings);

    try {
      await conn.query(
        'UPDATE customers SET name = ?, email = ?, birthday = ? WHERE email = ?',
        [
          customer.name,
          customer.email,
          customer.birthday.toIso8601String(),
          customer.email
        ],
      );
    } finally {
      await conn.close();
    }
  }
}
