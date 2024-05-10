import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:savane_vendeur/features/menu/settings/data/models/currency_model.dart';
import 'package:savane_vendeur/features/menu/settings/domain/useCases/get_currency_use_case.dart';

import '../../../../../core/domain/entity/user_entity.dart';
import '../../../../../core/utils/used_functions.dart';
import '../../../../menu/settings/domain/useCases/add_currency_use_case.dart';
import '../../../domain/useCases/create_account_use_case.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CreateAccountUseCase createAccount;
  final AddCurrencyUseCase addCurrencyUseCase;
  final GetCurrencyUseCase getCurrencyUseCase;

  RegisterBloc({
    required this.createAccount,
    required this.addCurrencyUseCase,
    required this.getCurrencyUseCase,
  }) : super(const RegisterState()) {
    on<RegisterEvent>((event, emit) async {
      void setCurrency() async {
        final currency =
            state.currency.where((element) => element.isoCode == "EUR").first;
        await addCurrencyUseCase(currency);
      }

      if (event is CreateAccountEvent) {
        emit(state.copyWith(isLoading: true, error: ""));

        final failureOrDoneMessage =
            await createAccount(userEntity: event.userEntity);
        failureOrDoneMessage.fold(
            (failure) => {
                  emit(state.copyWith(
                      isLoading: false,
                      message: mapFailureToMessage(failure),
                      error: failure.message))
                },
            (_) => {
                  setCurrency(),
                  emit(state.copyWith(
                      message: "User added successfully",
                      isLoading: false,
                      success: false))
                });
      }
      if (event is GetCurrencyEvent) {
        final failureOrDoneMessage = await getCurrencyUseCase();
        failureOrDoneMessage.fold(
          (_) {},
          (currency) {
            emit(state.copyWith(
                error: '', isLoading: false, currency: currency));
          },
        );
      }
    });
  }
}
