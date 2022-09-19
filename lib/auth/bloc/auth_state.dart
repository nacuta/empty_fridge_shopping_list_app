part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AnonAuthenticated extends AuthState {
  AnonAuthenticated(this.user);

  final UserModel user;
  @override
  List<Object?> get props => [user];
}

class EmailAndPasswordAuthenticated extends AuthState {
  EmailAndPasswordAuthenticated(this.user);

  final UserModel user;
  @override
  List<Object?> get props => [user];
}
