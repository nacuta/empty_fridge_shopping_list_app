part of 'auth_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AuthState.authenticated(UserModel user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  const AuthState._({
    required this.status,
    this.user = UserModel.empthy,
  });
  final AppStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}
