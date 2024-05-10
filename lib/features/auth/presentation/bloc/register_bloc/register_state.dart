part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final RegisterStatus registerStatus;
  final String messages;



  const RegisterState(
      {
        this.messages = "",
        this.registerStatus = RegisterStatus.loading
      });

  RegisterState copyWith({
    RegisterStatus? registerStatus,
    String? messages,

  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
    registerStatus,
    messages,
  ];
}

enum RegisterStatus {loading, success, error}