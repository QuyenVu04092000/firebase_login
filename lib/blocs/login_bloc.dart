import 'package:firebase_login/events/login_event.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/states/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../validators/validators.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  UserRepository _userRepository;
  LoginBloc({@required UserRepository userRepository}) :
      assert(userRepository != null),
      _userRepository = userRepository,
      super(LoginState.initial());
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
      Stream<LoginEvent> events,
      TransitionFunction<LoginEvent, LoginState> transitionFunction) {
    // TODO: implement transformEvents
    final debounceStream = events.where((event){
      return (event is LoginEventEmailChanged || event is LoginEventPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    final nonDebounceStream = events.where((event) {
      return (event is! LoginEventEmailChanged && event is! LoginEventPasswordChanged);
    });
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]),transitionFunction);
  }
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    // TODO: implement mapEventToState
    if (event is LoginEventEmailChanged){
      yield state.cloneAndUpdate(isValidEmail: Validators.isValidEmail(event.email));
    } else if (event is LoginEventPasswordChanged){
      yield state.cloneAndUpdate(isValidPassword: Validators.isValidPassword(event.password));
    } else if (event is LoginEventWithGooglePressed){
        try {
          await _userRepository.signInWithGoogle();
          yield LoginState.success();
        }catch (_){
          yield LoginState.failure();
        }
    } else if (event is LoginEventWithEmailAndPasswordPressed){
        try{
          await _userRepository.signInWithEmailAndPassword(event.email, event.password);
          yield LoginState.success();
        }catch(_){
          yield LoginState.failure();
        }
    }
  }
}