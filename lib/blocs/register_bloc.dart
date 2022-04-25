import 'package:firebase_login/events/register_event.dart';
import 'package:firebase_login/repositories/user_repository.dart';
import 'package:firebase_login/states/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../validators/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  UserRepository _userRepository;
  RegisterBloc({@required UserRepository userRepository}) :
        assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.initial());
  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
      Stream<RegisterEvent> events,
      TransitionFunction<RegisterEvent, RegisterState> transitionFunction) {
    // TODO: implement transformEvents
    final debounceStream = events.where((event){
      return (event is RegisterEventEmailChanged || event is RegisterEventPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    final nonDebounceStream = events.where((event) {
      return (event is! RegisterEventEmailChanged && event is! RegisterEventPasswordChanged);
    });
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]),transitionFunction);
  }
  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    // TODO: implement mapEventToState
    if (event is RegisterEventEmailChanged){
      yield state.cloneAndUpdate(isValidEmail: Validators.isValidEmail(event.email));
    } else if (event is RegisterEventPasswordChanged){
      yield state.cloneAndUpdate(isValidPassword: Validators.isValidPassword(event.password));
    } else if (event is RegisterEventPressed){
        yield RegisterState.loading();
        try {
          await _userRepository.createUserWithEmailAndPassword(event.email, event.password);
          yield RegisterState.success();
        }catch (exception){
          print(exception.toString());
          yield RegisterState.failure();
      }
    }
  }
}