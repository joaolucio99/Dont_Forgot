
import 'package:Dont_Forgot/colors/pallets_colors.dart';
import 'package:Dont_Forgot/components/custom_switch_widget.dart';
import 'package:Dont_Forgot/controllers/switchtheme_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database/item_database.dart';
import '../components/dialog_widget.dart';


class HomePage extends StatefulWidget { //stateful quando precisar de atualizacões
  
  
  HomePage();
   
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var itens = new List<ItenModel>();
  
  Future load() async{ //sempre que for leitura de dados nunca será em tempo real sempre asyncro e future e um parametro que vai chegar 
    List<ItenModel> result = await ItenModel.readAll(); //vai percorrer as listas criadas a partir do mmodelo feito em Models para itens  
      setState(() {
        itens = result;
      });
    }

  _HomePageState(){
    load();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.instance.themeSwitch,
      builder: (context, iconchange, child){
      return Scaffold( // scaffold sempre para estrutura de pagina
        appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 9),
          child: Text('Suas tarefas',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),  
        actions: <Widget>[
          IconButton(
          icon: iconchange ? Icon(FontAwesomeIcons.cloudMoon, color: Colors.white) : Icon(FontAwesomeIcons.cloudSun, color: Colors.black),
          iconSize: 35.0,
          onPressed: (null),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CustomSwitchWidget(),
          ),
      ]
    ),


      body: Container(
        child: displayList(context), //mostrar lista na tela
      ), 
        floatingActionButton: FloatingActionButton(
        child: Icon(
          FontAwesomeIcons.plus,
          size: 20,      
          ),
        backgroundColor: iconchange ? darkmodecolor : azulcustom,
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) => MyDialog()
          ).then((value) async { //quando executar dialog e acabar, roda a função
            await load();
            }); 
          },
        ),
      );
    },
   );
  }

  Widget displayList(BuildContext ctxt) {
      return ValueListenableBuilder<bool>(
        valueListenable: ThemeController.instance.themeSwitch,
        builder: (context, selecttheme, child){
          if(itens.length == 0) return Align(
          child: new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Suas tarefas\n acabaram por aqui',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700
                ),
                
              ),
            Text(
              ' ',
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 150),
              child: Icon(
                FontAwesomeIcons.optinMonster, 
                size: 55,
                ),
              )
            ]
          )
        );
        return ListView.builder( //mostrar lisviewrs na tela
        itemCount: itens.length, //necessario para ver a quantidade de itens da lista, depois acessando os itens e trazendo quantos itens tem
        itemBuilder: (BuildContext ctxt, int index){ //usador para renderizar os itens na tela definir os valores de como vai ser renderizado
          final iten = itens[index]; //acessa a list criada anteriormente
          return Dismissible( //dismissible e a funçao para arrastar itens na tela
            child: CheckboxListTile(  // Parametros necessarios; titulo definido no modelo de itens
              checkColor: selecttheme ? Colors.black : Colors.white,
              activeColor: selecttheme ? Colors.purple[300] : amarelocustom,
              title: Text(
                iten.title, 
                style: TextStyle(
                  fontSize:19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                iten.quanty,
                style: TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: iten.done==1, //valor boleano definido no models, true or false nas atividades do todo list
              onChanged: (value) async{
                  iten.done= value?1:0; //clicar, passa outro valor para model list
              await iten.update(); 
              await load();     
              },
            ),
          key: Key(iten.id.toString()), // indentificador unico desses itens, ideal que fosse o id deles
          background: Container(
            color: selecttheme ? Colors.red.withOpacity(0.2) : Colors.red.withOpacity(0.5),
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.centerStart,
            child: Icon(
              FontAwesomeIcons.trash,
            ),
          ),
          secondaryBackground: Container(
            color: selecttheme ? Colors.red.withOpacity(0.2) : Colors.red.withOpacity(0.5),
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(
              FontAwesomeIcons.trash,
            ),
          ),
          onDismissed: (direction) async { //quando acaba de arrastar
              await itens[index].delete(); //função remover da list
              await load();
          },
            ); 
          },
      );
        }
      );
    }
}