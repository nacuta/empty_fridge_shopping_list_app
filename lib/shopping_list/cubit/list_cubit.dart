import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final initialList = state.shoppingItemsList..removeAt(index);
    // initialList.removeAt(index);
    final list = initialList;
    try {
      emit(
        state.copyWith(
          shoppingItemsList: list,
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
