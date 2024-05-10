part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final String messages;


  const LoginState(
      {
        this.messages = "",
        this.loginStatus = LoginStatus.loading
      });

  LoginState copyWith({
    LoginStatus? loginStatus,
    String? messages,

  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    messages,
  ];
}

enum LoginStatus {loading, success, error}