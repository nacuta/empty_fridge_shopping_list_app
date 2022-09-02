part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {}

class DatabaseFetched extends DatabaseEvent {
  @override
  List<Object?> get props => [];
}

class DatabaseChanged extends DatabaseEvent {
  DatabaseChanged();

  @override
  List<Object?> get props => [];
}

class DatabaseWrite extends DatabaseEvent {
  DatabaseWrite({required this.newData});

  final ShoppingModel newData;
  @override
  List<Object?> get props => [newData];
}

class DatabaseRemoveAll extends DatabaseEvent {
  DatabaseRemoveAll({required this.listToDelete});

  final List<ShoppingModel> listToDelete;
  @override
  List<Object?> get props => [listToDelete];
}

class DatabaseUncheckAll extends DatabaseEvent {
  DatabaseUncheckAll({required this.listToUncheck});

  final List<ShoppingModel> listToUncheck;
  @override
  List<Object?> get props => [listToUncheck];
}

class DatabaseChangedCompletionToggled extends DatabaseEvent {
  DatabaseChangedCompletionToggled({
    required this.shopItem,
    required this.isCompleted,
  });

  final ShoppingModel shopItem;
  final bool isCompleted;
  @override
  List<Object?> get props => [shopItem, isCompleted];
}