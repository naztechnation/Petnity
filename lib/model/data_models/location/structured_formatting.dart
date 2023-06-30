import 'dart:convert';

import 'package:equatable/equatable.dart';

class StructuredFormatting extends Equatable {
  const StructuredFormatting({
    required this.mainText,
    required this.secondaryText,
  });

  final String mainText;
  final String secondaryText;

  StructuredFormatting copyWith({
    String? mainText,
    String? secondaryText,
  }) =>
      StructuredFormatting(
        mainText: mainText ?? this.mainText,
        secondaryText: secondaryText ?? this.secondaryText,
      );

  factory StructuredFormatting.fromJson(String str) =>
      StructuredFormatting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StructuredFormatting.fromMap(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["main_text"],
        secondaryText: json["secondary_text"],
      );

  Map<String, dynamic> toMap() => {
        "main_text": mainText,
        "secondary_text": secondaryText,
      };

  @override
  List<Object?> get props => [mainText, secondaryText];
}
