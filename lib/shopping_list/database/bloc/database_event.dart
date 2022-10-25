part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {}

class DatabaseFetchData extends DatabaseEvent {
  DatabaseFetchData(this.docId);

  final String docId;
  @override
  List<Object?> get props => [docId];
}

class DatabaseChanged extends DatabaseEvent {
  DatabaseChanged(this.list);

  final List<ShoppingModel> list;
  @override
  List<Object?> get props => [list];
}

class DatabaseWrite extends DatabaseEvent {
  DatabaseWrite({
    required this.newData,
    required this.listId,
  });

  final ShoppingModel newData;
  final String listId;
  @override
  List<Object?> get props => [newData, listId];
}

class DatabaseRemoveAll extends DatabaseEvent {
  DatabaseRemoveAll({required this.listToDelete});

  final List<ShoppingModel> listToDelete;
  @override
  List<Object?> get props => [listToDelete];
}

class DatabaseUncheckAll extends DatabaseEvent {
  DatabaseUncheckAll(this.listId);
  final String listId;

  @override
  List<Object?> get props => [listId];
}

class DatabaseChangedCompletionToggled extends DatabaseEvent {
  DatabaseChangedCompletionToggled({
    required this.shopItem,
    required this.isCompleted,
    required this.listId,
  });

  final ShoppingModel shopItem;
  final bool isCompleted;
  final String listId;
  @override
  List<Object?> get props => [listId, shopItem, isCompleted];
}

class DatabaseRemoveOne extends DatabaseEvent {
  DatabaseRemoveOne({
    required this.listId,
    required this.shopItemToDelete,
  });

  final ShoppingModel shopItemToDelete;
  final String listId;
  @override
  List<Object?> get props => [listId, shopItemToDelete];
}

class DatabaseEditItem extends DatabaseEvent {
  DatabaseEditItem({
    required this.itemToEdit,
    required this.listId,
  });

  final ShoppingModel itemToEdit;
  final String listId;
  @override
  List<Object?> get props => [listId, itemToEdit];
}
