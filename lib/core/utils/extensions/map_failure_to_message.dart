import '../error/failures.dart';

String? mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) {
    return failure.message;
  } else if (failure is OfflineFailure) {
    return failure.message;
  } else if (failure is UnknownFailure) {
    return failure.message;
  } else {
    return "Unexpected Error , Please try again later .";
  }
}
