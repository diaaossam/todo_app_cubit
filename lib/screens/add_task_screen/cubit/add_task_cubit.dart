import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_cubit/models/note_model.dart';
import 'package:todo_app_cubit/models/reminder_model.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(BuildContext context) => BlocProvider.of(context);

  String reminderValue = "Time";

  List<ReminderModel> reminderList = [
    ReminderModel(time: "Time", value: 0),
    ReminderModel(time: "5 Min Earlier", value: 5),
    ReminderModel(time: "10 Min Earlier", value: 10),
    ReminderModel(time: "20 Min Earlier", value: 20),
    ReminderModel(time: "30 Min Earlier", value: 30),
  ];

  void changeReminderState(String newValue) {
    this.reminderValue = newValue;
    emit(ChangeReminderValueState());
  }

  List<bool> storeList = [true, false];

  void changeToggleState(int index) {
    if (index == 0) {
      storeList[0] = true;
      storeList[1] = false;
    } else {
      storeList[0] = false;
      storeList[1] = true;
    }
    emit(ChangeToggleState());
  }

  String defultSelectedColor = ConstantsManger.COLORS_RED;

  void setUpSelectedColor(String color) {
    if (color == ConstantsManger.COLORS_RED) {
      defultSelectedColor = ConstantsManger.COLORS_RED;
    }
    if (color == ConstantsManger.COLORS_BLUE) {
      defultSelectedColor = ConstantsManger.COLORS_BLUE;
    }
    if (color == ConstantsManger.COLORS_YELLOW) {
      defultSelectedColor = ConstantsManger.COLORS_YELLOW;
    }
    emit(SetUpColorState());
  }

  void uploadNoteToFireStore(NoteModel noteModel) {
    emit(UploadTaskToFireStoreLoading());
    FirebaseFirestore.instance
        .collection(ConstantsManger.TASKS)
        .doc(getCurrentUserUid())
        .collection(noteModel.noteDate ?? '')
        .add(noteModel.toMap())
        .then((value) {
      emit(UploadTaskToFireStoreSucess());
    }).catchError((error) {
      emit(UploadTaskToFireStoreFailure(error.toString()));
    });
  }

  late Database _database;

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
  void insertIntoLocalDateBase({required NoteModel noteModel}) async {
    await _database.transaction((txn) async{
      await txn.rawInsert('INSERT INTO ${ConstantsManger.TABLE_NAME} (title,noteDesc,noteDate,startTime,endtime,remind,color) VALUES ("${noteModel.title}", "${noteModel.noteDesc}" ,"${noteModel.noteDate}", "${noteModel.startTime}","${noteModel.endTime}","${noteModel.remind}","${noteModel.color}")').then((value) {
        print("$value inserted successfully");
        emit(InsertDatabaseState());
        getAllTasks(database: _database);
      }).catchError((error){
        print('Error Insert ${error.toString()}');
      });
    });
  }
  void getAllTasks({required Database database}){
    emit(GetAllDatabaseLoadingState());
    database.rawQuery(ConstantsManger.GET_ALL_TASKS).then((value){
      print('rows: ${value.length} $value');
      emit(GetAllDatabaseSuccessState());
    });
  }

  String getCurrentUserUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
