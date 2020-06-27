
import 'package:Dont_Forgot/controllers/switchtheme_controller.dart';
import 'package:flutter/material.dart';


class CustomSwitchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: ThemeController.instance.themeSwitch.value, 
      onChanged: (value){
        ThemeController.instance.changeTheme(value);
      },
    );
  }
}