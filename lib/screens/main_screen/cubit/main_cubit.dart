import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_cubit/models/note_model.dart';
import 'package:todo_app_cubit/models/user_model.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import 'package:todo_app_cubit/shared/helper/methods.dart';

import '../../../shared/local/database_helper.dart';

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

  List<NoteModel> taskList = [];

  //code
  void getTaskFromFireStore() {
    FirebaseFirestore.instance
        .collection(ConstantsManger.TASKS)
        .doc(_getCurrentUserUid())
        .collection(formatDate(DateTime.now()))
        .snapshots()
        .listen((event) {
      taskList.clear();
      event.docs.forEach((element) {
        taskList.add(NoteModel.fromJson(element.data()));

      });
      emit(GetAllDatabaseFirebaseSuccessState());
    });
  }

  void deleteTaskFirebase(String uid){
    FirebaseFirestore.instance
        .collection(ConstantsManger.TASKS)
        .doc(_getCurrentUserUid())
        .collection(formatDate(DateTime.now()));
  }


/*List<NoteModel> listNoteModel = [];
  void getAllTasksFromDatabase()async{
    emit(GetAllDatabaseLoadingState());
    Database? database=  await DatabaseHelper().database;
    listNoteModel.clear();
    database!.rawQuery(ConstantsManger.GET_ALL_TASKS).then((value){
      value.forEach((element) {
       listNoteModel.add(NoteModel.fromJson(element));
        print(element);
      });
      print(listNoteModel.length);
      emit(GetAllDatabaseSuccessState());
    });
  }

  void getTodayTasks(){

  }*/
}
