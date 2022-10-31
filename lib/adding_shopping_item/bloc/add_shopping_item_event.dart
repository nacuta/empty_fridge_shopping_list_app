part of 'add_shopping_item_bloc.dart';

@immutable
abstract class AddShoppingItemEvent extends Equatable {}

class AddShoppingFormChanged extends AddShoppingItemEvent {
  AddShoppingFormChanged(this.changedValue);

  final String changedValue;
  @override
  List<Object?> get props => [changedValue];
}

class AddShoppingFormSubmitted extends AddShoppingItemEvent {
  AddShoppingFormSubmitted();
  @override
  List<Object?> get props => [];
}

class AddListName extends AddShoppingItemEvent {
  AddListName(this.listName);

  final String listName;
  @override
  List<Object?> get props => [];
}
