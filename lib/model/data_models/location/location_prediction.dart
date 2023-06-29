import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:petnity/model/data_models/location/structured_formatting.dart';

class LocationPrediction extends Equatable {
  const LocationPrediction(
      {required this.description,
      required this.placeId,
      required this.reference,
      required this.structuredFormatting});

  final String description;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;

  LocationPrediction copyWith(
          {String? description,
          String? placeId,
          String? reference,
          StructuredFormatting? structuredFormatting}) =>
      LocationPrediction(
          description: description ?? this.description,
          placeId: placeId ?? this.placeId,
          reference: reference ?? this.reference,
          structuredFormatting:
              structuredFormatting ?? this.structuredFormatting);

  factory LocationPrediction.fromJson(String str) =>
      LocationPrediction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationPrediction.fromMap(Map<String, dynamic> json) =>
      LocationPrediction(
          description: json["description"],
          placeId: json["place_id"],
          reference: json["reference"],
          structuredFormatting:
              StructuredFormatting.fromMap(json["structured_formatting"]));

  Map<String, dynamic> toMap() => {
        "description": description,
        "place_id": placeId,
        "reference": reference,
        "structured_formatting": structuredFormatting.toMap(),
      };

  @override
  List<Object?> get props =>
      [description, placeId, reference, structuredFormatting];
}
