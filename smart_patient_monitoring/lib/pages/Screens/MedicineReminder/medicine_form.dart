import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/medicine_model.dart';

class MedicineForm extends StatefulWidget {
  final ValueChanged<String?> onChangeName;
  final ValueChanged<String?> onChangeType;
  final ValueChanged<String?> onChangeDesc;
  final ValueChanged<String?> onChangeTime;
  final VoidCallback? onSave;

  MedicineForm({
    Key? key,
    required this.onChangeName,
    required this.onChangeType,
    required this.onChangeDesc,
    required this.onChangeTime,
    this.onSave,
  }) : super(key: key);

  @override
  State<MedicineForm> createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  final _formStyle = const TextStyle(
    fontFamily: "Schyler",
    fontSize: 15,
    color: Colors.deepPurple,
    fontWeight: FontWeight.w700,
  );

  String? localvalue;
  final items = ["Anti-Bacterial", "Anti-Viral", "Other"];

  Widget _nameField() {
    return TextFormField(
      maxLines: 1,
      onChanged: widget.onChangeName,
      validator: (name) {
        if (name!.isEmpty) return 'Provide name';
        return null;
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Title',
        labelStyle:
            TextStyle(fontSize: 14, fontFamily: 'Sans', color: Colors.indigo),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: GoogleFonts.merriweather(fontSize: 14, color: Colors.brown),
        ),
      );

  Widget _typeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Type",
          style:
              TextStyle(fontSize: 14, fontFamily: 'Sans', color: Colors.indigo),
        ),
        DropdownButton(
          value: localvalue,
          items: items.map(buildMenuItem).toList(),
          onChanged: (String? value) {
            localvalue = value;
            print(localvalue);
            widget.onChangeType(localvalue);
            setState(() {});
          },
          style: const TextStyle(fontSize: 14.0),
          icon: const Icon(Icons.arrow_drop_down_circle,
              color: Colors.deepPurple),
        ),
      ],
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      maxLines: 3,
      onChanged: widget.onChangeDesc,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Description',
        labelStyle:
            TextStyle(fontSize: 14, fontFamily: 'Sans', color: Colors.indigo),
      ),
    );
  }

  Widget _ringTimeSelector(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 12, minute: 00),
        );
        String timeString = "${time!.hour}:${time.minute}";
        widget.onChangeTime(timeString);
      },
      backgroundColor: Colors.lightBlueAccent.withOpacity(0.6),
      child: const Center(
        child: Text(
          "Time",
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: "Consolas",
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        onPressed: widget.onSave,
        child: const Text(
          "Save",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Consolas",
            fontStyle: FontStyle.italic,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.teal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _nameField(),
        const SizedBox(height: 5),
        _descriptionField(),
        const SizedBox(height: 10),
        _typeField(),
        const SizedBox(height: 20),
        _ringTimeSelector(context),
        const SizedBox(height: 30),
        _saveButton(),
      ]),
    );
  }
}
