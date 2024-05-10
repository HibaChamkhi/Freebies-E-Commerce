part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountEvent extends RegisterEvent {
  final UserEntity userEntity;

  const CreateAccountEvent({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

class GetCurrencyEvent extends RegisterEvent {}
