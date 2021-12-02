import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medicine_model.g.dart';

@JsonSerializable()
class MedicineModel {
  @JsonKey(name: "_id")
  String? id;
  String? medName;
  String? medType;
  String? description;
  String? ringTime;

  MedicineModel({
    @required this.ringTime,
    @required this.medName,
    @required this.medType,
    this.id,
    this.description = 'Lorem Ipsum',
  });

  @override
  String toString() {
    String res = "";
    res += "id: $id \n";
    res += "ringing Time : $ringTime \n";
    res += "Medicine Name : $medName \n";
    res += "Medicine Type : $medType \n";
    res += "Description : $description \n";
    return res;
  }

  factory MedicineModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineModelFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineModelToJson(this);
}
