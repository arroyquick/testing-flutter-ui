import 'package:flutter/material.dart';
import 'package:quicket_ui_sample/constants.dart';
import 'package:quicket_ui_sample/widgets/form_field_layout.dart';

class Animal extends StatefulWidget {
  const Animal({Key? key}) : super(key: key);

  @override
  State<Animal> createState() => _AnimalState();
}

class _AnimalState extends State<Animal> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Animal",
            style: Theme.of(context).textTheme.headlineLarge,
            textDirection: TextDirection.ltr,
          ),
          const SizedBox(height: 40),
          FormFieldLayout(rowSpacing: 20, columnSpacing: 20, fields: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rabies Tag",
                  hintText: "Enter Rabies Tag"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This is a required field.";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Type",
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This is a required field.";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          FormFieldLayout(rowSpacing: 20, columnSpacing: 20, fields: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Breed",
                  hintText: "Enter Animal Breed"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This is a required field.";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Color",
                  hintText: "Enter Animal Color"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This is a required field.";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            DropdownButtonFormField<String>(
              value: null,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sex",
                  hintText: "Enter Animal Sex"),
              isExpanded: true,
              items: sexList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newText) {},
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This is a required field.";
                }
                else if(!sexList.contains(value)){
                  return "Please select value from dropdown";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            )
          ]),
        ],
      );
  }
}
