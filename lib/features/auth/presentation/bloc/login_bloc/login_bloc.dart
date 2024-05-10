import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savane_vendeur/core/strings/failures.dart';
import '../../../../../../core/error/failures.dart';
import '../../../domain/useCases/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(
      {required this.loginUseCase,})
      : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(state.copyWith(isLoading: true, error: "", success: false));
        final failureOrDoneMessage =
            await loginUseCase(email: event.email, password: event.password);
        emit(await _eitherDoneMessageOrErrorState(
            failureOrDoneMessage));
      }
    });
  }

  Future<LoginState> _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either,) async {
    return either.fold(
      (failure) {
        return state.copyWith(
            error:"Veuillez vérifier votre e-mail ou votre mot de passe", isLoading: false,);
      },
      (_)  {
        return state.copyWith(
            error: '', isLoading: false, success: true);
      },
    );
  }

  String? mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, please try again later';
    }
  }
}
