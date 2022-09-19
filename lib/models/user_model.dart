import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    this.name,
    this.email,
    required this.id,
    this.isAnonymous,
  });

  final String? email;
  final String id;
  final String? name;
  final bool? isAnonymous;

  static const empthy = UserModel(id: '');

  bool get isEmpty => this == UserModel.empthy;
  bool get isNotEmpty => this != UserModel.empthy;

  @override
  List<Object?> get props => [email, id, name];
}
