import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/bloc/add_form_model.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';

part 'add_shopping_item_event.dart';
part 'add_shopping_item_state.dart';

class AddShoppingItemBloc
    extends Bloc<AddShoppingItemEvent, AddShoppingItemState> {
  AddShoppingItemBloc(this._databaseRepository)
      : super(const AddShoppingItemState()) {
    on<AddShoppingFormChanged>(_onTextFormChanged);
    on<AddShoppingFormSubmitted>(_onSubmitted);
    on<AddListName>(_onListName);
  }

  final DatabaseRepository _databaseRepository;

  void _onTextFormChanged(
    AddShoppingFormChanged event,
    Emitter<AddShoppingItemState> emit,
  ) {
    final changedText = AddFormModel.dirty(event.changedValue);
    emit(
      state.copyWith(
        changedValue: changedText,
        status: Formz.validate([changedText, state.changedValue]),
      ),
    );
  }

  Future<void> _onSubmitted(
    AddShoppingFormSubmitted event,
    Emitter<AddShoppingItemState> emit,
  ) async {
    if (state.status.isValidated) {
      // DatabaseChangedCompletionToggled
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
        await _databaseRepository.writeCollectionDoc(
          state.listName,
          ShoppingModel(title: state.changedValue.value),
        );
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  FutureOr<void> _onListName(
    AddListName event,
    Emitter<AddShoppingItemState> emit,
  ) {
    emit(state.copyWith(listName: event.listName));
  }
}
