import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'Bloc Observer/blocObserver.dart';
import 'Layout/mainMenuLayout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 25.0,
          ),
        ),
      ),
      home: const MainMenuLayout(),
    );
  }
}
