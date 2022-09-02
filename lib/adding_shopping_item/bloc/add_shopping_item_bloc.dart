import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:mobi_lab_shopping_list_app/adding_shopping_item/bloc/add_form_model.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';

part 'add_shopping_item_event.dart';
part 'add_shopping_item_state.dart';

class AddShoppingItemBloc
    extends Bloc<AddShoppingItemEvent, AddShoppingItemState> {
  AddShoppingItemBloc(this._databaseRepository, this.databaseBloc)
      : super(const AddShoppingItemState()) {
    on<AddShoppingFormChanged>(_onTextFormChanged);
    on<AddShoppingFormSubmitted>(_onSubmitted);

    late StreamSubscription dtabaseBlocStream;

    dtabaseBlocStream = databaseBloc.stream.listen((state) {
      if (state.status == DatabaseStateStatus.success) {
        databaseBloc.add(DatabaseFetched());
      }

// React to state changes here.
// Add events here to trigger changes in MyBloc.
    });
  }

  final DatabaseRepository _databaseRepository;
  final DatabaseBloc databaseBloc;

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
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _databaseRepository.saveItemData(
          ShoppingModel(title: state.changedValue.value),
        );

        // DatabaseChangedCompletionToggled
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
