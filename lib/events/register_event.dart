import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class RegisterEventEmailChanged extends RegisterEvent{
  final String email;
  const RegisterEventEmailChanged({this.email});
  @override
  // TODO: implement props
  List<Object> get props => [email];
  @override
  String toString() {
    // TODO: implement toString
    return 'RegisterEventEmailChanged { email :$email}';
  }
}
class RegisterEventPasswordChanged extends RegisterEvent{
  final String password;
  const RegisterEventPasswordChanged({this.password});
  @override
  // TODO: implement props
  List<Object> get props => [password];
  @override
  String toString() {
    // TODO: implement toString
    return 'RegisterEventPasswordChanged { password :$password}';
  }
}

class RegisterEventPressed extends RegisterEvent{
  final String email;
  final String password;
  const RegisterEventPressed({
    @required this.email,
    @required this.password
  });
  @override
  // TODO: implement props
  List<Object> get props => [email,password];
  @override
  String toString() {
    // TODO: implement toString
    return 'Submitted { email: $email, password: $password }';
  }
}
