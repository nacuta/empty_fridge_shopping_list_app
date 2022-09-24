part of 'add_shopping_item_bloc.dart';

class AddShoppingItemState extends Equatable {
  const AddShoppingItemState({
    this.status = FormzStatus.pure,
    this.changedValue = const AddFormModel.pure(),
  });

  AddShoppingItemState copyWith({
    FormzStatus? status,
    AddFormModel? changedValue,
  }) {
    return AddShoppingItemState(
      status: status ?? this.status,
      changedValue: changedValue ?? this.changedValue,
    );
  }

  final FormzStatus status;
  final AddFormModel changedValue;

  @override
  List<Object?> get props => [status, changedValue];
}
