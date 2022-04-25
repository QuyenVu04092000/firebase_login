import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class LoginEventEmailChanged extends LoginEvent{
  final String email;
  const LoginEventEmailChanged({this.email});
  @override
  // TODO: implement props
  List<Object> get props => [email];
  @override
  String toString() {
    // TODO: implement toString
    return 'Email Changed: $email';
  }
}
class LoginEventPasswordChanged extends LoginEvent{
  final String password;
  const LoginEventPasswordChanged({this.password});
  @override
  // TODO: implement props
  List<Object> get props => [password];
  @override
  String toString() {
    // TODO: implement toString
    return 'Password Changed: $password';
  }
}
//press sign in with google
class LoginEventWithGooglePressed extends LoginEvent{}
class LoginEventWithEmailAndPasswordPressed extends LoginEvent{
  final String email;
  final String password;
  const LoginEventWithEmailAndPasswordPressed({
    @required this.email,
    @required this.password
  });
  @override
  // TODO: implement props
  List<Object> get props => [email,password];
  @override
  String toString() {
    // TODO: implement toString
    return 'LoginEventWithEmailAndPasswordPressed, email = $email, password = $password';
  }
}
