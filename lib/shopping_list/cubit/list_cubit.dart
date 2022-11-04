import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:empty_fridge_shopping_list_app/models/list.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database_repository.dart';
import 'package:equatable/equatable.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit(this._databaseRepository) : super(const ListState());
  final DatabaseRepository _databaseRepository;

  Future<void> getLists() async {
    try {
      final list = await _databaseRepository.retrieveLists();
      // print('list$list');

      emit(
        state.copyWith(shoppingItemsList: list, status: ListStateStatus.succes),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ListStateStatus.error),
      );
    }
  }

  // remove list from database
  Future<void> removeList(String name, int index) async {
    try {
      final list = state.shoppingItemsList;
      final initialList = [...list]..removeAt(index);
      emit(
        state.copyWith(
          shoppingItemsList: initialList,
          status: ListStateStatus.succes,
        ),
      );
      await _databaseRepository.deleteList(name);
    } catch (e) {
      emit(
        state.copyWith(status: ListStateStatus.error),
      );
    }
  }
}
