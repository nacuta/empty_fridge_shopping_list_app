part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, success, error }

class SignUpState extends Equatable {
  const SignUpState({
    required this.email,
    required this.password,
    required this.status,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      email: '',
      password: '',
      status: SignupStatus.initial,
    );
  }
  final String email;
  final String password;
  final SignupStatus status;

  SignUpState copyWith({
    String? email,
    String? password,
    SignupStatus? status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
