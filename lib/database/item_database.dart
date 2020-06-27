import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DB {

    static Database self; //armazena instancia bd

    static int get _version => 1;

    static Future<void> init() async { // função que vai ser executada quando app iniciar 
        if (self != null) { return; }

        try { //tenta executar os codigos seguinte, caso tenha algum erro sera exibido no "catch"
            String _path = await getDatabasesPath() + 'dbmkt'; //url do db sendo _path aonde vai ser armazenado lugar escolhido por padrao no tel+ nome do msm 
            self = await openDatabase(_path, version: _version, onCreate: onCreate); //abrindo conexao com banco de dados2
        }
        catch(ex) { 
            print(ex);
        }
    }

    static void onCreate(Database self, int version) async { //definindo funcao oncreate
      await self.execute('''CREATE TABLE itenslist (
        id INTEGER PRIMARY KEY NOT NULL, 
        title TEXT NOT NULL,
        done INTEGER NOT NULL,
        quanty TEXT NOT NULL)'''); // usa syntax sql , criando uma tabela definindo o ID como Int = INTEGER e outros atributos da lista
    }
}

class ItenModel{

    int id;
    String title;
    int done;
    String quanty;

    ItenModel({ this.id, this.title, this.done, this.quanty }); // quando modelo for criado tem que passar esses 3 argumentos

    Map<String, dynamic> toMap() { //função que retorna map
        Map<String, dynamic> map = { //cria var tipo map
            'title': title,
            'done': done,
            'quanty': quanty,
        };
        if (id != null) { 
          map['id'] = id; 
          }
        return map;
    }

    static Future<List<ItenModel>> readAll() async { //ler a lista do bd
      var results = await DB.self.query('itenslist'); 
      return results.map((item) => ItenModel(
        id: item['id'],
        title: item['title'],
        quanty: item['quanty'],
        done: item['done'],
      )).toList();
    }

    Future<int> insert() async =>  //inserir valores no banco
        await DB.self.insert('itenslist', this.toMap());

    Future<int> update() async => // atualizar o valor
        await DB.self.update('itenslist', this.toMap(), where: 'id = ?', whereArgs: [this.id]);

    Future<int> delete() async { //deletar o valor

      return  await DB.self.delete('itenslist', where: 'id = ?', whereArgs: [this.id]);

    }
  }