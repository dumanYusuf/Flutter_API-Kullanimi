// To parse this JSON data, do
//
//     final kur = kurFromMap(jsonString);

import 'dart:convert';

Kur kurFromMap(String str) => Kur.fromMap(json.decode(str));

String kurToMap(Kur data) => json.encode(data.toMap());

class Kur {
  final bool success;
  final int timestamp;
  final String base;
  final DateTime date;
  final Map<String, double> rates;

  Kur({
    required this.success,
    required this.timestamp,
    required this.base,
    required this.date,
    required this.rates,
  });

  factory Kur.fromMap(Map<String, dynamic> json) => Kur(
    success: json["success"],
    timestamp: json["timestamp"],
    base: json["base"],
    date: DateTime.parse(json["date"]),
    rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "timestamp": timestamp,
    "base": base,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
