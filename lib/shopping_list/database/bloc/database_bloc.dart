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
    // events that are beeing triggerd from UI.

    // initial load of the data, gets the firebase document
    on<DatabaseFetchData>(_fetchData);

    // initial load of the data, from list screen
    on<DatabaseChanged>(_onChangedData);

    // at every change it is used to write individual change
    on<DatabaseWrite>(_writeData);

    /// when [isComplete]  is toggled this event is triggerd with write event
    on<DatabaseChangedCompletionToggled>(_onDatabaseChangedCompletionToggled);

    // when remove all data use this
    on<DatabaseRemoveAll>(_onDatabaseRemoveAll);

    // when uncheck all use this
    on<DatabaseUncheckAll>(_onDatabaseUncheckAll);

    // when remove individual item
    on<DatabaseRemoveOne>(_onDatabaseRemoveOne);

    // when wdit an item
    on<DatabaseEditItem>(_onDatabaseEditItem);
  }
  final DatabaseRepository _databaseRepository;

  /// [_fetchData] gets from repository all the documents
  /// stored in Firebase
  /// and returns a  Future<List<ShoppingModel>>

  Future<void> _fetchData(
    DatabaseFetchData event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      // get the list with shopping items
      final listOfShoppings =
          await _databaseRepository.retriveDocumentItems(event.docId);

      // emit the state with the list
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
          listId: event.docId,
        ),
      );
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  ///[_writeData] write a single item using
  ///the ShoppingModel id to do that.
  Future<void> _writeData(
    DatabaseWrite event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      // save into database the new item
      await _databaseRepository.saveItemData(event.listId, event.newData);
      // store it alsi inte=o the list of shoppings allready
      final listOfShoppings = state.listOfShoppingItems..add(event.newData);

      // emit the state with the complete list
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  ///[_onDatabaseChangedCompletionToggled] changes with the help of [_writeData]
  /// method to change the isCompleted flag.

  Future<FutureOr<void>> _onDatabaseChangedCompletionToggled(
    DatabaseChangedCompletionToggled event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      //create a new ShoppingModel item with fleg changed.
      final newTodo = event.shopItem.copyWith(isCompleted: event.isCompleted);

      // replace into the list the new model with the old one
      final listOfShoppings = state.listOfShoppingItems.map((item) {
        return item.id == event.shopItem.id ? newTodo : item;
      }).toList();

      // emit the state with new list
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );

      // write it to the database
      await _databaseRepository.saveItemData(event.listId, newTodo);
    } catch (_) {
      // if the writting is failed send the failure state
      emit(const DatabaseState.failure());
    }
  }

  ///[_onDatabaseRemoveAll] will delete all the documents from the collection
  /// that are allready in the cart
  Future<void> _onDatabaseRemoveAll(
    DatabaseRemoveAll event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      // the list with all the items that are not in the cart
      final stillToBuyList = List.of(state.listOfShoppingItems)
        ..removeWhere((element) => element.isCompleted == true);

      // emit the state with remain items that needs to be bought
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: stillToBuyList,
        ),
      );
      // delete from database
      event.listToDelete.forEach(
        (element) {
          _databaseRepository.deleteItemData(event.listId, element);
        },
      );
    } catch (_) {
      // if the writting is failed send the failure state
      emit(const DatabaseState.failure());
    }
  }

  /// [_onDatabaseUncheckAll] modify the isCompleted flag
  /// from the list with items in cart to  the list
  ///  that needs to be shopped
  Future<FutureOr<void>> _onDatabaseUncheckAll(
    DatabaseUncheckAll event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      // create a new list with changed flag for all elements
      final list = state.listOfShoppingItems
          .where((element) => element.isCompleted!)
          .map(
            (e) => ShoppingModel(
              title: e.title,
              id: e.id,
            ),
          )
          .toList();
      // writes every item with the new flag
      // ignore: cascade_invocations
      list.forEach((element) {
        _databaseRepository.saveItemData(event.listId, element);
      });

      // replace into the list the new model with the old one
      var listOfShoppings = state.listOfShoppingItems.map((item) {
        return item.isCompleted == true
            ? item.copyWith(isCompleted: false)
            : item;
      }).toList();
      print(listOfShoppings);

      // list.addAll(state.listOfShoppingItems);
      // emit the state with all items
      emit(state.copyWith(
        status: DatabaseStateStatus.success,
        listOfShoppingItems: listOfShoppings,
      ));
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  /// [_onDatabaseRemoveOne] removes ony one item,
  /// the one that is passed with the event.
  FutureOr<void> _onDatabaseRemoveOne(
    DatabaseRemoveOne event,
    Emitter<DatabaseState> emit,
  ) {
    try {
      // delete the item from the list
      final listOfShoppings = List.of(state.listOfShoppingItems)
        ..removeWhere((element) => element.id == event.shopItemToDelete.id);
      // delete the item from the database
      _databaseRepository.deleteItemData(event.listId, event.shopItemToDelete);
      // emit the list without the item
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  ///[_onDatabaseEditItem] edit the elements of the item
  /// that is passed with the event
  Future<FutureOr<void>> _onDatabaseEditItem(
    DatabaseEditItem event,
    Emitter<DatabaseState> emit,
  ) async {
    try {
      // create a new item with changed elemets
      final editedItem = event.itemToEdit.copyWith(
        title: event.itemToEdit.title,
        quantity: event.itemToEdit.quantity,
      );
      // replace the item into list
      final listOfShoppings = state.listOfShoppingItems.map((item) {
        return item.id == event.itemToEdit.id ? editedItem : item;
      }).toList();

      // save item to database
      await _databaseRepository.saveItemData(event.listId, editedItem);

      // emit the changed list
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }

  FutureOr<void> _onChangedData(
    DatabaseChanged event,
    Emitter<DatabaseState> emit,
  ) {
    try {
      final listOfShoppings = event.list;

      // emit the changed list
      emit(
        state.copyWith(
          status: DatabaseStateStatus.success,
          listOfShoppingItems: listOfShoppings,
        ),
      );
    } catch (_) {
      emit(const DatabaseState.failure());
    }
  }
}
