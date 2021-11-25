import 'package:flutter/cupertino.dart';

class MedicineModel {
  DateTime? ringTime;
  String? id;
  String? medName;
  String? medType;
  String? description;

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

}