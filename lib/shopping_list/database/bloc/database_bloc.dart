import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/bloc/add_shopping_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';
import 'package:formz/formz.dart';
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
  }
  final DatabaseRepository _databaseRepository;

  // ignore: always_declare_return_types, inference_failure_on_function_return_type
  _fetchData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
    try {
      // ignore: omit_local_variable_types, prefer_final_locals
      List<ShoppingModel> listOfShoppings =
          await _databaseRepository.retrieveItemsData();
      print('data retrived');
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: DatabaseStateStatus.failure, exception: e));
    }
  }

  // ignore: inference_failure_on_function_return_type, always_declare_return_types
  _writeData(DatabaseWrite event, Emitter<DatabaseState> emit) async {
    try {
      await _databaseRepository.saveItemData(event.newData);
      print('data to write');
      // ignore: omit_local_variable_types
      final List<ShoppingModel> listOfShoppings =
          await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: DatabaseStateStatus.failure, exception: e));
    }
  }

  void _changedData(DatabaseChanged event, Emitter<DatabaseState> emit) async {
    try {
      final List<ShoppingModel> listOfShoppings =
          await _databaseRepository.retrieveItemsData();
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
      final List<ShoppingModel> listOfShoppings =
          await _databaseRepository.retrieveItemsData();
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: DatabaseStateStatus.failure));
    }
  }
}
