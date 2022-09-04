part of 'edit_item_bloc.dart';

enum EditItemStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditItemStatus {
  bool get isLoadingOrSuccess => [
        EditItemStatus.loading,
        EditItemStatus.success,
      ].contains(this);
}

class EditItemState extends Equatable {
  const EditItemState({
    this.status = EditItemStatus.initial,
    this.initialShopItem,
    this.title = '',
    this.quantity = 1,
  });

  final EditItemStatus status;
  final ShoppingModel? initialShopItem;
  final String title;
  final int quantity;

  bool get isNewShoppingItem => initialShopItem == null;

  EditItemState copyWith({
    EditItemStatus? status,
    ShoppingModel? initialShopItem,
    String? title,
    int? quantity,
  }) {
    return EditItemState(
      status: status ?? this.status,
      initialShopItem: initialShopItem ?? this.initialShopItem,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [status, initialShopItem, title, quantity];
}
