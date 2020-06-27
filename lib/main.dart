
import 'package:flutter/material.dart';
import 'colors/pallets_colors.dart';
import 'controllers/switchtheme_controller.dart';
import 'database/item_database.dart';
import 'pages/home.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //fazer o db funcionar
  await DB.init(); // inicializando o banco
  runApp(App());
}

class App extends StatelessWidget { //stateless quando for para  para pagina estatica
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.instance.themeSwitch,
      builder: (context, isDark, child) {
        return MaterialApp( 
        title: "Don'T forgot",
        debugShowCheckedModeBanner: false, // desabilitar o icon debug
        theme: ThemeData(
          fontFamily: 'Comfortaa',
          primarySwatch: begecustom,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
        home: HomePage(),
      );
    },
   );
  }
}
