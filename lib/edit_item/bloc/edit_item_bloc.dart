import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';

part 'edit_item_event.dart';
part 'edit_item_state.dart';

/// [EditItemBloc] that holds the state for [EditItemEvent] implementations
class EditItemBloc extends Bloc<EditItemEvent, EditItemState> {
  EditItemBloc({
    required this.databaseRepository,
    required ShoppingModel? initialItem,
  }) : super(
          EditItemState(
            initialShopItem: initialItem,
            quantity: initialItem?.quantity ?? 1,
            title: initialItem?.title ?? '',
          ),
        ) {
    on<EditItemTitleChanged>(_onTitleChanged);
    on<EditItemQuantityIncrement>(_onQuantityIncrement);
    on<EditItemQuantityDecrement>(_onQuantityDecrement);
    on<EditItemSubmitted>(_onSubmitted);
    on<EditItemQuantityInput>(_onQuantityInput);
  }
  final DatabaseRepositoryImpl databaseRepository;

  FutureOr<void> _onTitleChanged(
    EditItemTitleChanged event,
    Emitter<EditItemState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _onQuantityIncrement(
    EditItemQuantityIncrement event,
    Emitter<EditItemState> emit,
  ) {
    var newInt = event.quantityIncremented;
    newInt++;
    emit(state.copyWith(quantity: newInt));
  }

  FutureOr<void> _onQuantityDecrement(
    EditItemQuantityDecrement event,
    Emitter<EditItemState> emit,
  ) {
    var newInt = event.quantityDecremented;
    print('in minus $newInt');
    newInt--;
    emit(state.copyWith(quantity: newInt));
  }

  Future<FutureOr<void>> _onSubmitted(
    EditItemSubmitted event,
    Emitter<EditItemState> emit,
  ) async {
    emit(state.copyWith(status: EditItemStatus.loading));
    final changedItem =
        (state.initialShopItem ?? ShoppingModel(title: '')).copyWith(
      title: state.title,
      quantity: state.quantity,
    );

    try {
      await databaseRepository.saveItemData(changedItem);
      emit(state.copyWith(status: EditItemStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditItemStatus.failure));
    }
  }

  FutureOr<void> _onQuantityInput(
    EditItemQuantityInput event,
    Emitter<EditItemState> emit,
  ) {
    var newInt = event.quantityInput;
    emit(state.copyWith(quantity: newInt));
  }
}
