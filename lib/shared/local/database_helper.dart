import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';

class DatabaseHelper {
  //named constuctor
  DatabaseHelper._internal();

  static final DatabaseHelper _instance =
  DatabaseHelper._internal(); // singleton
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      Directory documentDir = await getApplicationDocumentsDirectory();
      String path = join(documentDir.path, ConstantsManger.DATABASE_NAME);
      var database = openDatabase(
        path,
        version: ConstantsManger.DATABASE_VERSION,
        onCreate: (Database db , int version)async{
          await db.execute(ConstantsManger.CREATE_QUERY).then((value) {
            print('Table Created');
          });
        }

      );
      return database ;
    }
  }
}
