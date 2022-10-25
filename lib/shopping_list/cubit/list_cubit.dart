import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_lab_shopping_list_app/models/list.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit(this._databaseRepository) : super(const ListState());
  final DatabaseRepository _databaseRepository;

  void listChanged(String value) {
    final listName = value;
    // emit(
    //   state.copyWith(
    //       // ids: listName,
    //       // status: ListStateStatus.succes,
    //       ),
    // );
    print(state);
  }

  Future<void> getLists() async {
    try {
      final list = await _databaseRepository.retrieveLists();
      print('list$list');

      emit(
        state.copyWith(shoppingItemsList: list, status: ListStateStatus.succes),
      );
    } catch (e) {
      print(e);
    }
  }

  // Future<void> createList(String listName, ShoppingModel item) async {
  //   try {
  //     await _databaseRepository.writeCollectionDoc(listName, item);
  //     final list = await _databaseRepository.retriveDocumentItems();

  //     emit(state.copyWith(ids: state.ids, status: ListStateStatus.succes));
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
