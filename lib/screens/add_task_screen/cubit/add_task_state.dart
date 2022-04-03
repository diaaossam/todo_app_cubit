part of 'add_task_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}
class ChangeReminderValueState extends AddTaskState {}
class ChangeToggleState extends AddTaskState {}
class SetUpColorState extends AddTaskState {}
class UploadTaskToFireStoreSucess extends AddTaskState {}
class UploadTaskToFireStoreLoading extends AddTaskState {}
class UploadTaskToFireStoreFailure extends AddTaskState {
  String error;

  UploadTaskToFireStoreFailure(this.error);
}

class CreateDatabaseState extends AddTaskState{}
class InsertDatabaseState extends AddTaskState{}
class GetAllDatabaseSuccessState extends AddTaskState{}
class GetAllDatabaseLoadingState extends AddTaskState{}
