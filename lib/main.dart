import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_cubit/screens/splash_screen/splash_screen.dart';
import 'package:todo_app_cubit/shared/helper/bloc_observer.dart';
import 'package:todo_app_cubit/shared/local/cache_helper.dart';
import 'package:todo_app_cubit/shared/styles/styles.dart';

void main() {

  BlocOverrides.runZoned(
        () {
          WidgetsFlutterBinding.ensureInitialized();
          CachedHelper.init();
          Firebase.initializeApp();
          runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeManger.setLightTheme(),
    );
  }
}

