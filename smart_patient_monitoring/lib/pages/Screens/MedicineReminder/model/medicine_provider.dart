import 'package:flutter/material.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_model.dart';
import 'package:smart_patient_monitoring/service/med_reminder_api.dart';

class MedicineProvider extends ChangeNotifier {
  List<MedicineModel> _models = [];

  List<MedicineModel> get medicineModels => _models;

  void addMedicineModel(MedicineModel? model) {
    MedicineReminderAPI.createMedicineModel(model);
    notifyListeners();
  }

  void setModels(List<MedicineModel> _models) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      this._models = _models;
      notifyListeners();
    });
  }

  void updateModel(MedicineModel? model) {
    MedicineReminderAPI.updateMedicineModel(model);
    notifyListeners();
  }

  void deleteModel(MedicineModel? model) {
    MedicineReminderAPI.deleteMedicineModel(model);
    notifyListeners();
  }
}
