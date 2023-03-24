import 'package:flutter/material.dart';

class OrderSummary {
  DateTime timeIn;
  DateTime date;

  OrderSummary({
    required this.timeIn,
    required this.date,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(

      timeIn: json['timeIn'],
      date: DateTime.parse(json['date']),
    );
  }

  Map toJson() {
    return {

      'timeIn': timeIn,
      'date': date.toIso8601String(),
    };
  }
}