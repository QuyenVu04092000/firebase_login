import 'package:firebase_login/events/authentication_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('This is Home Page'),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggedOut());
              },
              icon: Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: Center(
        child: Text('This is HomePage',style: TextStyle(fontSize: 22,color: Colors.green),),
      ),
    );
  }
}