import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_model.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_provider.dart';

class MedicineEditPage extends StatefulWidget {
  MedicineModel? model;
  final VoidCallback foo;
  MedicineEditPage({
    Key? key,
    this.model,
    required this.foo,
  }) : super(key: key);

  @override
  _MedicineEditPageState createState() => _MedicineEditPageState();
}

class _MedicineEditPageState extends State<MedicineEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _formStyle = const TextStyle(
    fontFamily: "Schyler",
    fontSize: 15,
    color: Colors.deepPurple,
    fontWeight: FontWeight.w700,
  );
  int _radioValue = -1;
  MedicineModel? model;

  ListTile listTile(String text, Widget title) {
    return ListTile(
      focusColor: Colors.lightGreenAccent,
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.purple),
            image: const DecorationImage(
              image: AssetImage("assets/images/hero_bcg.jpg"),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: "Peralta",
            ),
          ),
        ),
      ),
      title: title,
    );
  }

  Widget _nameField() {
    return TextFormField(
      initialValue: model!.medName,
      maxLines: 1,
      validator: (value) {
        if (value!.isEmpty) return 'Name can be empty';
        return null;
      },
      onChanged: (name) => (model!.medName = name),
      decoration: const InputDecoration(border: UnderlineInputBorder()),
      style: _formStyle,
    );
  }

  Widget _typeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("B", style: _formStyle),
        Radio(
          value: 0,
          groupValue: _radioValue,
          onChanged: (int? value) {
            setState(() {
              _radioValue = value!;
            });
          },
          fillColor: MaterialStateColor.resolveWith(
              (states) => Colors.deepOrangeAccent),
        ),
        Text("V", style: _formStyle),
        Radio(
          value: 1,
          groupValue: _radioValue,
          onChanged: (int? value) {
            setState(() {
              _radioValue = value!;
            });
          },
          fillColor: MaterialStateColor.resolveWith(
            (states) => Colors.brown,
          ),
        ),
        Text("O", style: _formStyle),
        Radio(
          value: 2,
          groupValue: _radioValue,
          onChanged: (int? value) {
            setState(() {
              _radioValue = value!;
            });
          },
          fillColor:
              MaterialStateColor.resolveWith((states) => Colors.indigoAccent),
        ),
      ],
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      initialValue: model!.description,
      maxLines: 3,
      validator: (value) => null,
      onChanged: (desc) => (model!.description = desc),
      //  decoration: const InputDecoration(border: UnderlineInputBorder()),
      style: GoogleFonts.satisfy(fontSize: 18.0, letterSpacing: 1.2),
      keyboardType: TextInputType.multiline,
    );
  }

  Widget _ringTimeField() {
    return FloatingActionButton(
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 12, minute: 00),
        );
        String timeString = "${time!.hour}:${time.minute}";
        model!.ringTime = timeString;
      },
      backgroundColor: Colors.tealAccent.withOpacity(0.5),
      child: const Center(
        child: Text(
          "Time",
          style: TextStyle(
              fontSize: 14.0, fontFamily: "Lobster", color: Colors.deepPurple),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          switch (_radioValue) {
            case 0:
              model!.medType = "Anti-bacterial";
              break;
            case 1:
              model!.medType = "Anti-Viral";
              break;
            default:
              model!.medType = "Other";
          }
          Provider.of<MedicineProvider>(context, listen: false)
              .updateModel(model);
          widget.foo();
          Navigator.of(context).pop();
          _formKey.currentState?.validate();
        },
        child: const Text(
          "Save",
          style: TextStyle(
            fontFamily: "Consolas",
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber.shade400),
        ),
      ),
    );
  }

  @override
  void initState() {
    model = widget.model;
    switch (model!.medType) {
      case "Anti-bacterial":
        _radioValue = 0;
        break;
      case "Anti-Viral":
        _radioValue = 1;
        break;
      default:
        _radioValue = 2;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/edit_page_bcg.png"),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            height: 500,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent.withOpacity(0.4),
                  blurRadius: 8.0,
                  spreadRadius: 15.0,
                  offset: const Offset(2, 4),
                ),
              ],
              image: const DecorationImage(
                  image: AssetImage("assets/images/card_background.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  listTile("Name", _nameField()),
                  const SizedBox(height: 5),
                  listTile("Type", _typeField()),
                  listTile("Desc", _descriptionField()),
                  Center(child: _ringTimeField()),
                  Center(child: _saveButton()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
