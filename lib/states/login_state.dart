import 'package:meta/meta.dart';

@immutable
class LoginState{
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;
  LoginState({
    @required this.isFailure,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isValidEmail,
    @required this.isValidPassword
  });
  factory LoginState.initial(){
    return LoginState(
        isFailure: false,
        isSubmitting: false,
        isSuccess: false,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  factory LoginState.loading(){
    return LoginState(
        isFailure: false,
        isSubmitting: true,
        isSuccess: false,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  factory LoginState.failure(){
    return LoginState(
        isFailure: true,
        isSubmitting: false,
        isSuccess: false,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  factory LoginState.success(){
    return LoginState(
        isFailure: false,
        isSubmitting: false,
        isSuccess: true,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  LoginState CloneWith({
    bool isValidEmail,
    bool isValidPassword,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }){
    return LoginState(
        isFailure: isFailure ?? this.isFailure,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isValidPassword: isValidPassword ?? this.isValidPassword
    );
  }
  LoginState CloneAndUpdate({
    bool isValidEmail,
    bool isValidPassword,
  }){
    return CloneWith(
      isValidEmail: isValidEmail,
      isValidPassword: isValidPassword
    );
  }
}