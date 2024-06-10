//attendy.db
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sql_database{
  //base de donnees
  static Database? _database;
  
  //le nom des etudiants + les seance

  
  Future<Database?> get db async {
    if (_database == null) {
      _database = await initialDatabase();
      return _database;
    } else {
      return _database;
    }
  }
  
  initialDatabase() async {
    String database_path = await getDatabasesPath();
    String path = join(database_path , "attendy.db");
    print(path);
    Database my_data = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return my_data;
  }

  _onUpgrade(Database db , int version , int new_version) {
    print("on upgrade ");
  }

  _onCreate(Database db , int version) async {
    await db.execute(' CREATE TABLE classes ( groupe TEXT , module TEXT , year TEXT , semester TEXT , table_name TEXT);');
    print("create database and table ");
  }
  
  //get my data
  read_data(String sql) async {
    Database? my_data = await db;
    List<Map> result = await my_data!.rawQuery(sql);
    return result;
  }

  //insert in database
  insert(String sql) async {
    Database? my_data = await db;
    int result = await my_data!.rawInsert(sql);
    return result;
  }

  //update
  update_data(String sql) async {
    Database? my_data = await db;
    int result = await my_data!.rawUpdate(sql);
    return result;
  }

  //delete
  delete_data(String sql) async {
    Database? my_data = await db;
    int response = await my_data!.rawDelete(sql);
    return response;
  }

  
  fetchData() async {
    final Database db = await initialDatabase();
    final List<Map<String,dynamic>> queryResult = await db.query("classes");
    inspect(queryResult);
  }

  //add table 
  
  Future<void> addTable( String table_name) async {
    final Database db = await initialDatabase();
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $table_name (student_name TEXT , star INTEGER , TD TEXT);"
    );
  }


  Future<void> create_note() async {
    final Database db = await initialDatabase();
    await db.execute(
      "CREATE TABLE IF NOT EXISTS Notes (note TEXT , comment TEXT);"
    );
  }


  
  Future<void> addColumn(String tableName , String time) async {
    final querySnapshot = await FirebaseFirestore.instance
    .collection('teacher')
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    final seance = querySnapshot.docs.first;
    if (!seance.data()['seance'].toString().contains(tableName + '/' + time + ' ')) {
      final seances = seance.data()['seance'] + tableName + '/' + time + ' ';
      await seance.reference.update({
        'seance' : seances,
      });
    }
    final database = await initialDatabase();
    await database.execute('ALTER TABLE $tableName ADD COLUMN $time TEXT ');
  }

  
  void deleteTable( String tableName) async {
    final querySnapshot = await FirebaseFirestore.instance
    .collection('teacher')
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    final seance = querySnapshot.docs.first;
    final seances = seance.data()['seance'].toString().split(' ');
    for (int i = 0 ; i < seances.length ; i++ ) {
      if (seances[i].contains(tableName)) {
        seances.remove(seances[i]);
      }
    }
    final variable = seances.join(' ');
    await seance.reference.update({
      'seance' : variable,
    });


    final database = await initialDatabase();
    await database.execute("DROP TABLE IF EXISTS $tableName");
  }

  Future<List<Map<String, dynamic>>> display_table(String table_name) async {
    final database = openDatabase(
      join(await getDatabasesPath(), "attendy.db"),
    );
    final db = await database;
    return db.query(table_name);
  }

  Future<void> insert_data_from_excel(List<dynamic> data , String table_name) async {
    final database = openDatabase(
      join( await getDatabasesPath() , "attendy.db"),
    );
    final db = await database;
    Batch batch = db.batch();
    for (var row in data) {
      batch.insert(
        table_name,
        {
          'student_name' : row[0].toString().toLowerCase().replaceAll(' ', '_'),
          
        }
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> read_and_insert (String table_name) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx' , 'xls'],
    );
    if (result != null) {
      String? file_path = result.files.single.path;
      var bytes = File(file_path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      final sheet = excel.tables.keys.first;
      final Database db = await initialDatabase();
      await db.execute("CREATE TABLE IF NOT EXISTS $table_name (student_name TEXT , star INTEGER , TD TEXT);");
      for (var row in excel.tables[sheet]!.rows.skip(1)) {
        await db.insert(
          table_name,
          {
            'student_name' : row[0]!.value.toString().toLowerCase().replaceAll(' ', '_'),
            'star' : 0,
            'TD' : '0',
          }
        );
      }
    }
  }

  Future<void> add_student(String student_name , String table_name) async {
    final database = await openDatabase("attendy.db");
    await database.insert(
      table_name,
      {
        'student_name' : student_name,
        'star' : 0,
      }
    );
  }
}