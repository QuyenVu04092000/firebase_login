import 'package:firebase_login/blocs/authentication_bloc.dart';
import 'package:firebase_login/events/authentication_event.dart';
import 'package:firebase_login/events/register_event.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import '../blocs/register_bloc.dart';
import '../states/register_state.dart';
import 'buttons/register_button.dart';

class RegisterPage extends StatefulWidget{
  final UserRepository _userRepository;
  //constructor
  RegisterPage({Key key, @required UserRepository userRepository}):
        assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}
class _RegisterPage extends State<RegisterPage>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterBloc _registerBloc;
  UserRepository get _userRepository => widget._userRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(() {
      //email changed will call this
      _registerBloc.add(RegisterEventEmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      //password changed will call this
      _registerBloc.add(RegisterEventPasswordChanged(password: _passwordController.text));
    });
  }
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isRegisterButtonEnabled(RegisterState registerState) =>
      registerState.isValidEmailAndPassword & isPopulated && !registerState.isSubmitting;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, registerState){
                if(registerState.isFailure){
                  print('Registration failed');
                } else if(registerState.isSubmitting){
                  print('Registration in progress...');
                } else if(registerState.isSuccess){
                  BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggedIn());
                }
                return Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: 'Enter your email'
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.always,
                          autocorrect: false,
                          validator: (_){
                            return !registerState.isValidEmail ? null : 'Invalid email format';
                          },
                        ),
                        TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Enter password'
                            ),
                            obscureText: true,
                            autovalidateMode: AutovalidateMode.always,
                            autocorrect: false,
                            validator: (_){
                              return  !registerState.isValidPassword ? null : 'Invalid password';
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: RegisterButton(
                            onPressed: (){
                              if(isRegisterButtonEnabled(registerState)){
                                _registerBloc.add(
                                  RegisterEventPressed(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                );
                              }
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      )
    );
  }
}