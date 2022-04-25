import 'package:firebase_login/blocs/simple_bloc_observer.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //test
    final userRepository = UserRepository();
    userRepository.createUserWithEmailAndPassword("quyenvu0409@gmail.com","123456789");
    return MaterialApp(
      title: 'Login with Firebase',
      home: Scaffold(
        body: Center( child: Text('Login with Firebase',style: TextStyle(fontSize: 20),),),
      ),
    );
  }
}

