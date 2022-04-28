import 'package:firebase_login/events/login_event.dart';
import 'package:firebase_login/pages/buttons/login_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../blocs/login_bloc.dart';

class GoogleLoginButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ButtonTheme(
        height: 45,
        child: RaisedButton.icon(
            onPressed: (){
              BlocProvider.of<LoginBloc>(context).add(LoginEventWithGooglePressed());
            },
            icon: Icon(FontAwesomeIcons.google, color: Colors.white,size: 17,),
            label: Text(
              'Signin with Google',
              style: TextStyle(color: Colors.white),
            ))
    );
  }
}