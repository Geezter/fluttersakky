import "package:flutter/material.dart";

class MyMaterialStateColor extends MaterialStateColor {
  MyMaterialStateColor(int defaultValue) : super(defaultValue);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.red; // Change to the desired color for the pressed state
    }
    return Color.fromARGB(255, 51, 51, 51); // Default color for other states
  }
}

MyMaterialStateColor myButtonBackgroundColor = MyMaterialStateColor(
  Color.fromARGB(255, 51, 51, 51).value,
);