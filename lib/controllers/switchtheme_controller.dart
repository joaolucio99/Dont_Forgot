
import 'package:Dont_Forgot/database/theme_sharedpreferences.dart';
import 'package:Dont_Forgot/interfaces/sharedpreferences_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


  class ThemeController {

    static final ThemeController instance = ThemeController._();

    ThemeController._() {
      storage.get('isDark').then((value){
        if (value != null) themeSwitch.value = value;
      });
    } 

    final themeSwitch = ValueNotifier<bool>(false);

    final ISharedPreference storage = ThemeLocalStorage();

    changeTheme(bool value){
      themeSwitch.value = value;
      storage.put('isDark', value);
    }
  
}