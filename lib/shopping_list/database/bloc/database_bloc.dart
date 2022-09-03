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
  ) : super(const DatabaseState()) {
    on<DatabaseFetched>(_fetchData);
    on<DatabaseWrite>(_writeData);
    on<DatabaseChanged>(_changedData);
    on<DatabaseChangedCompletionToggled>(_onDatabaseChangedCompletionToggled);
    on<DatabaseRemoveAll>(_onDatabaseRemoveAll);
    on<DatabaseUncheckAll>(_onDatabaseUncheckAll);
  }
  final DatabaseRepository _databaseRepository;

  Future<void> _fetchData(
      DatabaseFetched event, Emitter<DatabaseState> emit) async {
    try {
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DatabaseStateStatus.failure));
    }
  }

  Future<void> _writeData(
    DatabaseWrite event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      await _databaseRepository.saveItemData(event.newData);
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DatabaseStateStatus.failure));
    }
  }

  Future<void> _changedData(
      DatabaseChanged event, Emitter<DatabaseState> emit) async {
    try {
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DatabaseStateStatus.failure));
    }
  }

  Future<FutureOr<void>> _onDatabaseChangedCompletionToggled(
    DatabaseChangedCompletionToggled event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      final newTodo = event.shopItem.copyWith(isCompleted: event.isCompleted);
      await _databaseRepository.saveItemData(newTodo);
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DatabaseStateStatus.failure));
    }
  }

  Future<void> _onDatabaseRemoveAll(
    DatabaseRemoveAll event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      event.listToDelete.forEach(_databaseRepository.deleteItemData);
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DatabaseStateStatus.failure));
    }
  }

  Future<FutureOr<void>> _onDatabaseUncheckAll(
    DatabaseUncheckAll event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      event.listToUncheck.forEach(_databaseRepository.saveItemData);
      final listOfShoppings = await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: DatabaseStateStatus.failure));
    }
  }
}
