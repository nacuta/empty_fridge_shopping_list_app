part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AuthAnonEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class UnAuthEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
