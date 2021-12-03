import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/medicine_form.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_provider.dart';

import 'model/medicine_model.dart';

class MedicineDialog extends StatefulWidget {
  const MedicineDialog({Key? key}) : super(key: key);

  @override
  _MedicineDialogState createState() => _MedicineDialogState();
}

class _MedicineDialogState extends State<MedicineDialog> {
  final _formKey = GlobalKey<FormState>();
  MedicineModel newModel = MedicineModel(
      medName: "", medType: "", ringTime: "", description: "", id: "");

  void addNewModel() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    final provider = Provider.of<MedicineProvider>(context, listen: false)
        .addMedicineModel(newModel);
    Navigator.of(context).pop();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amberAccent.withOpacity(0.9),
      content: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Medicine Reminder",
                style: GoogleFonts.inconsolata(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              MedicineForm(
                onChangeName: (name) => (newModel.medName = name),
                onChangeType: (type) => (newModel.medType = type),
                onChangeDesc: (desc) => (newModel.description = desc),
                onChangeTime: (time) => (newModel.ringTime = time),
                onSave: addNewModel,
              )
            ],
          ))),
    );
  }
}
