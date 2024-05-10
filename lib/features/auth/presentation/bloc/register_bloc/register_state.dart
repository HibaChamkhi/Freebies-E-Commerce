part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String message;

  final bool isLoading;
  final String error;
  final bool success;
  final List<CurrencyModel> currency;

  const RegisterState({
    this.message = "",
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.currency = const [],
  });

  RegisterState copyWith({
    String? message,
    bool? isLoading,
    String? error,
    bool? success,
    List<CurrencyModel>? currency,
  }) {
    return RegisterState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [
        message,
        isLoading,
        error,
        success,
        currency,
      ];
}
