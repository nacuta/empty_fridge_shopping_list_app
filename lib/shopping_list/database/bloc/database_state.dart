part of 'database_bloc.dart';

// @immutable
// abstract class DatabaseState extends Equatable {}

// class DatabaseInitial extends DatabaseState {
//   @override
//   List<Object?> get props => [];
// }

// class DatabaseSucces extends DatabaseState {
//   DatabaseSucces(this.listOfShoppingItems);

//   final List<ShoppingModel> listOfShoppingItems;
//   @override
//   List<Object?> get props => [listOfShoppingItems];
// }

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

// enum ListStatus { loading, success, failure }

// class ComplexListState extends Equatable {
//   const ComplexListState._({
//     this.status = ListStatus.loading,
//     this.items = const <ShoppingModel>[],
//   });

//   const ComplexListState.loading() : this._();

//   const ComplexListState.success(List<ShoppingModel> items)
//       : this._(status: ListStatus.success, items: items);

//   const ComplexListState.failure() : this._(status: ListStatus.failure);

//   final ListStatus status;
//   final List<ShoppingModel> items;

//   @override
//   List<Object> get props => [status, items];
// }
