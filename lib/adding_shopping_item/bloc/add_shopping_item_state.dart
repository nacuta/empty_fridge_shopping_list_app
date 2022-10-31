part of 'add_shopping_item_bloc.dart';

class AddShoppingItemState extends Equatable {
  const AddShoppingItemState({
    this.status = FormzStatus.pure,
    this.changedValue = const AddFormModel.pure(),
    this.listName = 'New List',
  });

  AddShoppingItemState copyWith({
    FormzStatus? status,
    AddFormModel? changedValue,
    String? listName,
  }) {
    return AddShoppingItemState(
      status: status ?? this.status,
      changedValue: changedValue ?? this.changedValue,
      listName: listName ?? this.listName,
    );
  }

  final FormzStatus status;
  final AddFormModel changedValue;
  final String listName;

  @override
  List<Object?> get props => [listName, status, changedValue];
}
