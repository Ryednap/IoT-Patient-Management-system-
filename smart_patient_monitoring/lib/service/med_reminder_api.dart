// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_model.dart';
import 'package:http/http.dart' as http;

String url = "localhost:5000";

class MedicineReminderAPI {
  static void createMedicineModel(MedicineModel? model) async {
    final client = http.Client();
    try {
      print("Creating POST request to /medicine endPoint");
      print(model);
      print(model!.toJson());
      final response =
          await client.post(Uri.http(url, "/medicine/"), body: model.toJson());
      print(response.bodyBytes.runtimeType);
      print(response.statusCode.runtimeType);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  static void updateMedicineModel(MedicineModel? model) async {
    final client = http.Client();
    print("Updateing>....\n");
    print(model);
    try {
      final medicineId = model!.id;
      final response = await client
          .patch(Uri.http(url, "/medicine/$medicineId"), body: model.toJson());
      print(response.statusCode);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  static void deleteMedicineModel(MedicineModel? model) async {
    final client = http.Client();
    try {
      final medicineId = model!.id;
      final response =
          await client.delete(Uri.http(url, "/medicine/$medicineId"));
      print(response.statusCode);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  static Stream<List<MedicineModel>> getMedicineModel() {
    final client = http.Client();
    List<MedicineModel> models = [];
    try {
      client.get(Uri.http(url, "/medicine/")).then((response) {
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        print(decodedResponse["doc"].runtimeType);
        print(decodedResponse["doc"]);
        for (Map<String, dynamic> json in decodedResponse["doc"]) {
          models.add(MedicineModel.fromJson(json));
        }
      });
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
    print(models);
    final StreamController<List<MedicineModel>> controller =
        StreamController<List<MedicineModel>>();
    controller.add(models);
    return controller.stream;
  }
}
