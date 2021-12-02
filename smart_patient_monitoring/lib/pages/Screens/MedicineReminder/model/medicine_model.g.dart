// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineModel _$MedicineModelFromJson(Map<String, dynamic> json) =>
    MedicineModel(
      ringTime: json['ringTime'] as String?,
      medName: json['name'] as String?,
      medType: json['type'] as String?,
      id: json['_id'] as String?,
      description: json['description'] as String? ?? 'Lorem Ipsum',
    );

Map<String, dynamic> _$MedicineModelToJson(MedicineModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'medName': instance.medName,
      'medType': instance.medType,
      'description': instance.description,
      'ringTime': instance.ringTime,
    };
