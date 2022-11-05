part of 'add_shopping_item_bloc.dart';

class AddShoppingItemState extends Equatable {
  const AddShoppingItemState({
    this.newItem = const ShoppingModel.empty(),
    this.status = FormzStatus.pure,
    this.changedValue = const AddFormModel.pure(),
    this.listName = const ListModel.empty(),
  });

  AddShoppingItemState copyWith({
    FormzStatus? status,
    AddFormModel? changedValue,
    ListModel? listName,
    ShoppingModel? newItem,
  }) {
    return AddShoppingItemState(
      status: status ?? this.status,
      changedValue: changedValue ?? this.changedValue,
      listName: listName ?? this.listName,
      newItem: newItem ?? this.newItem,
    );
  }

  final FormzStatus status;
  final AddFormModel changedValue;
  final ListModel listName;
  final ShoppingModel newItem;

  @override
  List<Object?> get props => [listName, status, changedValue, newItem];
}
