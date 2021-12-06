import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/medicine_card.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_provider.dart';

class MedicineCardWrapper extends StatelessWidget {
  final VoidCallback foo;
  const MedicineCardWrapper({
    Key? key,
    required this.foo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedicineProvider>(context); // We want to listen for change here
    final models = provider.medicineModels;
    if (models.isEmpty) {
      return const Center(
        child: Text(
          "No Models",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(10.0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (content, index) {
          return MedicineCard(model: models[index], foo: foo);
        },
        separatorBuilder: (content, index) {
          return const SizedBox(height: 12);
        },
        itemCount: models.length,
      );
    }
  }
}
