
import 'package:Dont_Forgot/colors/pallets_colors.dart';
import 'package:Dont_Forgot/controllers/switchtheme_controller.dart';
import 'package:Dont_Forgot/database/item_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyDialog extends StatefulWidget {
  MyDialog({Key key}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  var newTaskCtrl = TextEditingController(); // usado para controlar os texto como busca,apagar,ler,etc...
  var newTaskCtrl2 = TextEditingController();
  String dropdownValue = 'Unidade(s)';

  void add() async{ //criando função para adicionar no check list
    if(newTaskCtrl.text.isEmpty || newTaskCtrl2.text.isEmpty) return;
      ItenModel newiten = new ItenModel( //acessando o widget itens que esta na homepage,criado apartir do models; adicionando ao list pegando
          title: newTaskCtrl.text, // o title o valor do input com o controller 
          quanty: '${newTaskCtrl2.text} $dropdownValue', //montar uma string com vars caso tenha um composto use com chaves else usa sem somente assim '$dropdownValue'
          done: 0,
          ); 
      setState(() { 
        newTaskCtrl.text = "";
        newTaskCtrl2.text = ""; 
      });
      await newiten.insert(); // inserinndo o iten no banco de dados
  }


  @override
  Widget build(BuildContext context) { 
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.instance.themeSwitch,
      builder: (context, selecttheme, child){
              return SimpleDialog(
                title: Text('Nova Tarefa',
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                  fontSize: 23,
                ),
              ),
                  contentPadding: EdgeInsets.all(8),
                  children: <Widget>[

            TextFormField(
              controller: newTaskCtrl,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: selecttheme ? Colors.white54 : Colors.black,
                fontSize: 20
              ), 
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color:selecttheme ? Colors.white24 : begecustom,
                  )
                ),
                labelText: "Nome: ",
                labelStyle: TextStyle(
                  color: selecttheme ? Colors.white : Colors.black,
                )
              ),
            ),

            TextFormField(
              controller: newTaskCtrl2,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: selecttheme ? Colors.white54 : Colors.black,
                fontSize: 20
              ), 
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color:selecttheme ? Colors.white24 : begecustom,
                  )
                ),
                labelText: "Quantidade: ",
                labelStyle: TextStyle(
                  color: selecttheme ? Colors.white : Colors.black,
                )
              ),
            ),

            Container(
              child:Padding(
                padding: EdgeInsets.only(top: 9),
                child:DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(
                  FontAwesomeIcons.chevronDown,
                  size: 15,
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: selecttheme ? Colors.white : Colors.black,
                  fontSize: 20,
                  ),
                underline: Container(
                  height: 0,
                ),  
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Unidade(s)', 'Grama(s)', 'Kg(s)',]
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                        fontFamily: 'Comfortaa'
                      ),
                    )
                  );}).toList(),
                ),
              ),
            ),

            Container(
              child:Padding(
                padding: EdgeInsets.only(top:8) ,
                child:FlatButton (
                  child: Text(
                    "ADICIONAR TAREFA",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: selecttheme ? Colors.black : Colors.white,
                    ),
                  ),
                color: selecttheme ? darkmodecolor : azulcustom,
                padding: EdgeInsets.all(15),
                onPressed: () {
                  add(); 
                  Navigator.pop(context , false); 
                  }, 
                ),
              )
            )
          
          ],
        
        );
      }
    );
 }
}