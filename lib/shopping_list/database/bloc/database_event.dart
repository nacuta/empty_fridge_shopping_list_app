part of 'database_bloc.dart';

@immutable
abstract class DatabaseEvent extends Equatable {}

class DatabaseFetched extends DatabaseEvent {
  @override
  List<Object?> get props => [];
}

class DatabaseWrite extends DatabaseEvent {
  DatabaseWrite(this.newData);

  final ShoppingModel newData;
  @override
  List<Object?> get props => [newData];
}
