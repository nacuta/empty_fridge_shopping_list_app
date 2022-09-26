part of 'auth_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AppStatus status;
  final UserModel user;

  const AuthState._({
    required this.status,
    this.user = UserModel.empthy,
  });

  const AuthState.authenticated(UserModel user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
