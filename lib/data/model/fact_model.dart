import 'dart:convert';
import 'package:hive/hive.dart';

part 'fact_model.g.dart';

FactModel factModelFromJson(String str) => FactModel.fromJson(json.decode(str));

String factModelToJson(FactModel data) => json.encode(data.toJson());


@HiveType(typeId: 0)
class FactModel {
  FactModel({required this.fact, required this.length});

  @HiveField(0)
  String fact;
  @HiveField(1)
  int length;

  factory FactModel.fromJson(Map<String,dynamic> json) => FactModel(
      fact: json["fact"],
      length: json["length"],);

  Map<String,dynamic> toJson() =>{
    "length": length,
    "fact": fact,
  };
}