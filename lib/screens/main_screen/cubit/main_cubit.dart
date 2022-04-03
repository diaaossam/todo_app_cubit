import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_cubit/models/user_model.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  late UserModel userModel;

  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  void getUserInfo() {
    emit(GetUserLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.USERS)
        .doc(_getCurrentUserUid())
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data() ?? {});
      emit(GetUserSucess());
    }).catchError((error) {
      emit(GetUserFailed(error.toString()));
    });
  }

  String _getCurrentUserUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  /*late Database _database;
  void createLocalDateBase() async {
    await openDatabase(
      ConstantsManger.DATABASE_NAME,
      version: ConstantsManger.DATABASE_VERSION,
      onCreate: (Database database, int version) {
        print('Database is Created');
        database.execute(ConstantsManger.CREATE_QUERY).then((value) {
          print('Table Created');
        });
      },
      onOpen: (Database database) {
        getAllTasks(database: database);
        print('Database Is Opened');
      },
    ).then((value) {
      _database = value;
      emit(CreateDatabaseState());
    });
  }
  void getAllTasks({required Database database}){
    emit(GetAllDatabaseLoadingState());
    database.rawQuery(ConstantsManger.GET_ALL_TASKS).then((value){
      print('rows: ${value.length} $value');
      emit(GetAllDatabaseSuccessState());
    });
  }*/
}
