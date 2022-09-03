part of 'database_bloc.dart';

enum DatabaseStateStatus { initial, loading, success, failure }

class DatabaseState extends Equatable {
  const DatabaseState.failure() : this._(status: DatabaseStateStatus.failure);

  const DatabaseState.success(List<ShoppingModel> items)
      : this._(status: DatabaseStateStatus.success, listOfShoppingItems: items);

  const DatabaseState.loading() : this._();
  const DatabaseState._({
    this.status = DatabaseStateStatus.loading,
    this.listOfShoppingItems = const <ShoppingModel>[],
  });

  final DatabaseStateStatus status;
  final List<ShoppingModel> listOfShoppingItems;

  @override
  List<Object?> get props => [status, listOfShoppingItems];
}
