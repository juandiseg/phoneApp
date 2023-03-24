import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:intl/intl.dart';

import '../usermodels/orders_summary.dart';
import 'db_connection.dart';

class OrderMenu {
  Future<void> placeOrderMenus(int? orderId, int menuId) async {
    final conn = await DatabaseConnection().getConnection();

    // Construct the query string
    final query = "INSERT INTO orders_menus VALUES ($orderId, $menuId, 1)";

    // Execute the query
    await conn.query(query);

    // Close the connection
    await conn.close();
  }

  Future<int> saveOrderSummary(
      BuildContext context, OrderSummary orderSummary) async {
    final conn = await DatabaseConnection().getConnection();

    try {
      // Get the latest order_id from the orders_summary table
      final res = await conn
          .query('SELECT MAX(order_id) AS max_order_id FROM orders_summary');
      int latestOrderId = res.first['max_order_id'] ?? 0;

      // Increment the latest order_id to get the next order_id
      int nextOrderId = latestOrderId + 1;
      // Format the time string using DateFormat class
      final timeFormatter = DateFormat('HH:mm:ss');
      final timeInString = timeFormatter.format(orderSummary.timeIn);

      // Insert record into orders_summary table
      final result = await conn.query(
        'INSERT INTO orders_summary (order_id, time_in, date) VALUES (?, ?, ?)',
        [nextOrderId, timeInString, orderSummary.date.toString()],
      );

      return nextOrderId;
    } catch (e) {
      print('Error saving order summary: $e');
      return 0;
    } finally {
      await conn.close();
    }
  }
}
