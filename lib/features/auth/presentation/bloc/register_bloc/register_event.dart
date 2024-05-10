part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountEvent extends RegisterEvent {
  final UserModel user ;
 final File imageFile ;
  const CreateAccountEvent(this.imageFile, {required this.user});

  @override
  List<Object> get props => [user];
}

class GetCurrencyEvent extends RegisterEvent {}
