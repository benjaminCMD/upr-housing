import 'package:flutter/material.dart';
class MyDropdown extends StatelessWidget {
  final String text;
  final List items;
  final Function(String?) selectedValue; // Function needs to be created on parent widget to access selected value

  const MyDropdown({
    super.key,
    required this.text,
    required this.items,
    required this.selectedValue
    });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownMenu(
        width: 150,
        hintText: text,
        dropdownMenuEntries: items.map((e) => DropdownMenuEntry(value: e, label: e),).toList(),
        onSelected: (value) {
          selectedValue(value);
        },
        ),
    );
  }
}