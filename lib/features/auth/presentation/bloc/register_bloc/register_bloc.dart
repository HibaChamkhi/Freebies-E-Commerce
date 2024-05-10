import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freebies_e_commerce/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/extensions/map_failure_to_message.dart';
import '../../../data/models/user.dart';

part 'register_event.dart';

part 'register_state.dart';
@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SignUpUseCase signUpUseCase;


  RegisterBloc({
    required this.signUpUseCase,
  }) : super(const RegisterState()) {
    on<RegisterEvent>((event, emit) async {
      if (event is CreateAccountEvent) {
        emit(state.copyWith(registerStatus:RegisterStatus.loading));

        final failureOrDoneMessage =
            await signUpUseCase(event.user,event.imageFile);
        failureOrDoneMessage.fold(
            (failure) => {
                  emit(state.copyWith(
                      registerStatus:RegisterStatus.error,
                      messages: mapFailureToMessage(failure),
                     ))
                },
            (_) => {
                  emit(state.copyWith(
                      messages: "User added successfully",
                      registerStatus:RegisterStatus.success))
                });
      }
    });
  }
}
