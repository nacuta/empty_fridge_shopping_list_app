import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc(
    this._databaseRepository,
  ) : super(const DatabaseState.loading()) {
    on<DatabaseFetched>(_fetchData);
    on<DatabaseWrite>(_writeData);
    on<DatabaseChanged>(_changedData);
    on<DatabaseChangedCompletionToggled>(_onDatabaseChangedCompletionToggled);
    on<DatabaseRemoveAll>(_onDatabaseRemoveAll);
    on<DatabaseUncheckAll>(_onDatabaseUncheckAll);
    on<DatabaseRemoveOne>(_onDatabaseRemoveOne);
  }
  final DatabaseRepository _databaseRepository;

  Future<void> _fetchData(
    DatabaseFetched event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(DatabaseState.success(listOfShoppings));
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  Future<void> _writeData(
    DatabaseWrite event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      await _databaseRepository.saveItemData(event.newData);
      final listOfShoppings = state.listOfShoppingItems..add(event.newData);

      emit(DatabaseState.success(listOfShoppings));
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  Future<void> _changedData(
      DatabaseChanged event, Emitter<DatabaseState> emit) async {
    try {
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(DatabaseState.success(listOfShoppings));
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  Future<FutureOr<void>> _onDatabaseChangedCompletionToggled(
    DatabaseChangedCompletionToggled event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      final newTodo = event.shopItem.copyWith(isCompleted: event.isCompleted);
      await _databaseRepository.saveItemData(newTodo);

      final listOfShoppings = state.listOfShoppingItems.map((item) {
        return item.id == event.shopItem.id
            ? item.copyWith(isCompleted: event.isCompleted)
            : item;
      }).toList();

      emit(DatabaseState.success(listOfShoppings));
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  Future<void> _onDatabaseRemoveAll(
    DatabaseRemoveAll event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      final listOfShoppings = List.of(state.listOfShoppingItems)
        ..removeWhere((element) => element.isCompleted == true);
      emit(DatabaseState.success(listOfShoppings));

      event.listToDelete.forEach(_databaseRepository.deleteItemData);
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  Future<FutureOr<void>> _onDatabaseUncheckAll(
    DatabaseUncheckAll event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      final list = state.listOfShoppingItems
          .where((element) => element.isCompleted!)
          .map(
            (e) => ShoppingModel(
              title: e.title,
              id: e.id,
            ),
          )
          .toList();
      // ignore: cascade_invocations
      list.forEach(_databaseRepository.saveItemData);

      emit(
        DatabaseState.success(list),
      );
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  // Future<void> deleteItem(String id) async {
  //   final deleteInProgress = state.listOfShoppingItems.map((item) {
  //     return item.id == id ? item.copyWith(isDeleting: true) : item;
  //   }).toList();

  //   emit(DatabaseState.success(deleteInProgress));

  //   unawaited(
  //     _databaseRepository.deleteItemData(id).then((_) {
  //       final deleteSuccess = List.of(state.items)
  //         ..removeWhere((element) => element.id == id);
  //       emit(ComplexListState.success(deleteSuccess));
  //     }),
  //   );
  // }

  FutureOr<void> _onDatabaseRemoveOne(
    DatabaseRemoveOne event,
    Emitter<DatabaseState> emit,
  ) {
    try {
      final listOfShoppings = List.of(state.listOfShoppingItems)
        ..removeWhere((element) => element.id == event.shopItemToDelete.id);
      _databaseRepository.deleteItemData(event.shopItemToDelete);

      emit(DatabaseState.success(listOfShoppings));
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }
}
