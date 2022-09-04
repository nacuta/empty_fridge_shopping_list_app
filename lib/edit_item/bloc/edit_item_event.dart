part of 'edit_item_bloc.dart';

abstract class EditItemEvent extends Equatable {
  const EditItemEvent();

  @override
  List<Object> get props => [];
}

class EditItemTitleChanged extends EditItemEvent {
  const EditItemTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class EditItemQuantityIncrement extends EditItemEvent {
  const EditItemQuantityIncrement(this.quantityIncremented);

  final int quantityIncremented;

  @override
  List<Object> get props => [quantityIncremented];
}

class EditItemQuantityDecrement extends EditItemEvent {
  const EditItemQuantityDecrement(this.quantityDecremented);

  final int quantityDecremented;

  @override
  List<Object> get props => [quantityDecremented];
}

class EditItemQuantityInput extends EditItemEvent {
  const EditItemQuantityInput(this.quantityInput);

  final int quantityInput;

  @override
  List<Object> get props => [quantityInput];
}

class EditItemSubmitted extends EditItemEvent {
  const EditItemSubmitted();
}
