import 'package:firebase_login/blocs/authentication_bloc.dart';
import 'package:firebase_login/blocs/login_bloc.dart';
import 'package:firebase_login/events/authentication_event.dart';
import 'package:firebase_login/events/login_event.dart';
import 'package:firebase_login/pages/buttons/google_login_button.dart';
import 'package:firebase_login/pages/buttons/login_button.dart';
import 'package:firebase_login/pages/buttons/register_user_button.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  final UserRepository _userRepository;
  //constructor
  LoginPage({Key key, @required UserRepository userRepository}):
      assert(userRepository != null),
      _userRepository = userRepository,
      super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  UserRepository get _userRepository => widget._userRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(() {
      //email changed will call this
      _loginBloc.add(LoginEventEmailChanged(email: _emailController.text));
    });
    _passwordController.addListener(() {
      //password changed will call this
      _loginBloc.add(LoginEventPasswordChanged(password: _passwordController.text));
    });
  }
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState loginState) =>
      loginState.isValidEmailAndPassword & isPopulated && !loginState.isSubmitting;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, loginState){
            if(loginState.isFailure){
              print('Login failed');
            } else if(loginState.isSubmitting){
              print('Logging in');
            } else if(loginState.isSuccess){
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
                        return loginState.isValidEmail ? null : 'Invalid email format';
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
                        return loginState.isValidPassword ? null : 'Invalid password';
                      }),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: LoginButton(
                        onPressed: isLoginButtonEnabled(loginState)?
                                  _onLoginEmailAndPassword : null,
                        ),
                      ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    GoogleLoginButton(),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    RegisterUserButton(userRepository: _userRepository)
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
  void _onLoginEmailAndPassword(){
    _loginBloc.add(LoginEventWithEmailAndPasswordPressed(
        email: _emailController.text,
        password: _passwordController.text
    ));
  }
}