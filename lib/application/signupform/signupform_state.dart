part of 'signupform_bloc.dart';

class SignupformState {
  final bool isSubmitting;
  final bool isSuccess;
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;

  SignupformState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.authFailureOrSuccessOption,
  });

  SignupformState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
  }) {
    return SignupformState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      authFailureOrSuccessOption:
          authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }
}
