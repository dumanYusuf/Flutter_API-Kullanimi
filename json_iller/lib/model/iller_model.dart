// To parse this JSON data, do
//
//     final iller = illerFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Iller illerFromMap(String str) => Iller.fromMap(json.decode(str));

String illerToMap(Iller data) => json.encode(data.toMap());

class Iller {
  final int id;
  final String ilAdi;
  final String plakaKodu;

  Iller({
    required this.id,
    required this.ilAdi,
    required this.plakaKodu,
  });

  factory Iller.fromMap(Map<String, dynamic> json) => Iller(
    id: json["id"],
    ilAdi: json["il_adi"],
    plakaKodu: json["plaka_kodu"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "il_adi": ilAdi,
    "plaka_kodu": plakaKodu,
  };
}
