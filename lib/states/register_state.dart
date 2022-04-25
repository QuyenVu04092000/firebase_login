import 'package:meta/meta.dart';

@immutable
class RegisterState{
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;
  RegisterState({
    @required this.isFailure,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isValidEmail,
    @required this.isValidPassword
  });
  factory RegisterState.initial(){
    return RegisterState(
        isFailure: false,
        isSubmitting: false,
        isSuccess: false,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  factory RegisterState.loading(){
    return RegisterState(
        isFailure: false,
        isSubmitting: true,
        isSuccess: false,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  factory RegisterState.failure(){
    return RegisterState(
        isFailure: true,
        isSubmitting: false,
        isSuccess: false,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  factory RegisterState.success(){
    return RegisterState(
        isFailure: false,
        isSubmitting: false,
        isSuccess: true,
        isValidEmail: true,
        isValidPassword: true
    );
  }
  RegisterState CloneWith({
    bool isValidEmail,
    bool isValidPassword,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }){
    return RegisterState(
        isFailure: isFailure ?? this.isFailure,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isValidPassword: isValidPassword ?? this.isValidPassword
    );
  }
  RegisterState cloneAndUpdate({
    bool isValidEmail,
    bool isValidPassword,
  }){
    return CloneWith(
        isValidEmail: isValidEmail,
        isValidPassword: isValidPassword
    );
  }
}