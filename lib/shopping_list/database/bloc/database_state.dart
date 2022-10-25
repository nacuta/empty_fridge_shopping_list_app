part of 'database_bloc.dart';

enum DatabaseStateStatus { initial, loading, success, failure }

class DatabaseState extends Equatable {
  const DatabaseState({
    this.status = DatabaseStateStatus.loading,
    this.listOfShoppingItems = const <ShoppingModel>[],
    this.listId = '',
  });
  const DatabaseState.failure() : this(status: DatabaseStateStatus.failure);

  // const DatabaseState.success(List<ShoppingModel> items)
  //     : this._(status: DatabaseStateStatus.success, listOfShoppingItems: items);

  const DatabaseState.loading() : this();

  final DatabaseStateStatus status;
  final List<ShoppingModel> listOfShoppingItems;
  final String listId;

  @override
  List<Object?> get props => [listId, status, listOfShoppingItems];

  DatabaseState copyWith({
    DatabaseStateStatus? status,
    List<ShoppingModel>? listOfShoppingItems,
    String? listId,
  }) {
    return DatabaseState(
      status: status ?? this.status,
      listOfShoppingItems: listOfShoppingItems ?? this.listOfShoppingItems,
      listId: listId ?? this.listId,
    );
  }
}
