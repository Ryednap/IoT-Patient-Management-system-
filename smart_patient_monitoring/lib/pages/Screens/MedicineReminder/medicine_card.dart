import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/medicine_edit_page.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/medicine_reminder.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_model.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_provider.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/timer.dart';
import 'package:smart_patient_monitoring/service/med_reminder_api.dart';


class MedicineCard extends StatelessWidget {
  final MedicineModel? model;
  final VoidCallback foo;

   MedicineCard({
    Key? key,
    this.model,
    required this.foo,
  }) : super(key: key);

  String data = "Other";

  Widget medNameWidget() {
    return Text(
      model!.medName.toString(), // assigning String? to String is an error
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontFamily: "Schyler",
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget medDescriptionWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        model!.description.toString(),
        style: const TextStyle(
          color: Colors.blueGrey,
          fontFamily: "Peralta",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget medTypeHologramWidget() {
    String medType = "O";
    if (model!.medType!.compareTo("Anti-Bacterial") == 0) {
      medType = "B";
    } else if (model!.medType!.compareTo("Anti-Viral") == 0) {
      medType = "V";
    }

    return Container(
      height: 20.0,
      width: 20.0,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          medType,
          style: const TextStyle(
            fontFamily: "Times",
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget medImageWidget() {
    String imgLocation = "assets/images/otherPill.png";
    if (model!.medType!.compareTo("Anti-Bacterial") == 0) {
      imgLocation = "assets/images/AntiBacterial.png";
    } else if (model!.medType!.compareTo("Ant-Viral") == 0) {
      imgLocation = "assets/images/AntiViral.png";
    }
    return Container(
      height: 100.0,
      width: 100.0,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imgLocation)),
      ),
    );
  }


  Duration calculateDuration(BuildContext context) {
    String? s = model?.ringTime;
    TimeOfDay? time = TimeOfDay(
        hour: int.parse(s!.split(":")[0]), minute: int.parse(s.split(":")[1]));
    TimeOfDay now = TimeOfDay.now();
      
      if (model!.medType == "Anti-Bacterial") {
        data = "Bacterial";
      } else if (model!.medType == "Anti-Viral") {
        data = "Viral";
      }

    return Duration(
      hours: (time.hour - now.hour < 0 ? 0 : time.hour - now.hour),
      minutes: (time.minute - now.minute < 0 ? 0 : time.minute - now.minute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(55.0),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        actions: [
          IconSlideAction(
            icon: Icons.edit,
            color: Colors.green.shade400,
            caption: 'edit',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MedicineEditPage(model: model, foo: foo)));
            },
          ),
        ],
        secondaryActions: [
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.redAccent,
            caption: 'delete',
            onTap: () {
              final provider =
                  Provider.of<MedicineProvider>(context, listen: false);
              provider.deleteModel(model);
              foo();
            },
          ),
        ],
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.amberAccent.shade200],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: medNameWidget(),
              ),
              Row(
                children: [
                  TimerWidget(
                    duration: calculateDuration(context),
                    data: data,
                    model: model,
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(child: medDescriptionWidget()),
                  const SizedBox(width: 10.0),
                  medImageWidget(),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: medTypeHologramWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
