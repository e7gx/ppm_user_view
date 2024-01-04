import 'package:flutter/material.dart';

Widget buildTextFieldText(
    TextEditingController controller, String label, String hint,
    {int maxLines = 1}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.grey[200],
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 31, 108, 232)),
      hintStyle: TextStyle(color: Colors.grey[400]),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 31, 108, 232), width: 4.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 31, 108, 232), width: 2.0),
      ),
    ),
    keyboardType: TextInputType.text,
  );
}

Widget buildTextFieldNum(
    TextEditingController controller, String label, String hint,
    {int maxLines = 1}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.grey[200],
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 31, 108, 232)),
      hintStyle: TextStyle(color: Colors.grey[400]),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 31, 108, 232), width: 4.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 31, 108, 232), width: 2.0),
      ),
    ),
    keyboardType: TextInputType.number,
  );
}
