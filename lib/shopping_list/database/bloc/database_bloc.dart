import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;
  DatabaseBloc(this._databaseRepository) : super(DatabaseState()) {
    on<DatabaseFetched>(_fetchData);
    on<DatabaseWrite>(_writeData);
  }

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

  // ignore: inference_failure_on_function_return_type
  _writeData(DatabaseWrite event, Emitter<DatabaseState> emit) async {
    try {
      await _databaseRepository.saveItemData(event.newData);
      print('data to write');
      List<ShoppingModel> listOfShoppings =
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
}
