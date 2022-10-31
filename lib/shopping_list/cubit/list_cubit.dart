import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:empty_fridge_shopping_list_app/models/list.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database_repository.dart';

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
}
