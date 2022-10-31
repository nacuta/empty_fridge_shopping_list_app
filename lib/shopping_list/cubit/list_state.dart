part of 'list_cubit.dart';

enum ListStateStatus { initial, succes, error }

class ListState extends Equatable {
  const ListState({
    // this.ids = 'NewList',
    this.status = ListStateStatus.initial,
    this.shoppingItemsList = const <ListModel>[],
  });

  // final String ids;
  final ListStateStatus status;
  final List<ListModel> shoppingItemsList;
  @override
  List<Object?> get props => [/* ids ,*/ status, shoppingItemsList];

  ListState copyWith({
    // String? ids,
    ListStateStatus? status,
    List<ListModel>? shoppingItemsList,
  }) {
    return ListState(
      // ids: ids ?? this.ids,
      status: status ?? this.status,
      shoppingItemsList: shoppingItemsList ?? this.shoppingItemsList,
    );
  }
}
