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
  const DatabaseState({
    this.status = DatabaseStateStatus.initial,
    this.listOfShoppingItems = const [],
    this.exception,
  });

  final DatabaseStateStatus status;
  final List<ShoppingModel> listOfShoppingItems;
  final Exception? exception;

  DatabaseState copyWith({
    DatabaseStateStatus? status,
    List<ShoppingModel>? listOfShoppingItems,
    Exception? exception,
  }) {
    return DatabaseState(
      status: status ?? this.status,
      listOfShoppingItems: listOfShoppingItems ?? this.listOfShoppingItems,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, listOfShoppingItems, exception];
}
