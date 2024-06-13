import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/utils/error/failures.dart';
import '../../../domain/use_cases/sign_in_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUseCase signInUseCase;
  final LogOutUseCase logOutUseCase;

  LoginBloc(
      {required this.signInUseCase,required this.logOutUseCase, })
      : super(const LoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(state.copyWith(loginStatus: LoginStatus.loading));
        final failureOrDoneMessage = await signInUseCase( event.email, event.password);
        emit(await _eitherDoneMessageOrErrorState(
            failureOrDoneMessage));
      }
      if (event is LogoutEvent) {
        emit(state.copyWith(loginStatus: LoginStatus.loading));
        final failureOrDoneMessage = await logOutUseCase();
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
            messages:"Please check your email or password", loginStatus: LoginStatus.error);
      },
      (_)  {
        return state.copyWith(
            messages: '',loginStatus: LoginStatus.success);
      },
    );
  }

  String? mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message;
      // case OfflineFailure:
      //   return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, please try again later';
    }
  }
}
