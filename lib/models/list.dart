import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_fridge_shopping_list_app/models/shopping_model.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ListModel extends Equatable {
  ListModel({
    this.list,
    String? listName,
    String? listId,
  })  : listId = listId ?? const Uuid().v4(),
        listName = listName ?? 'New List';

  ListModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : listId = doc.id,
        listName = 'New List',
        list = doc.data()!.entries.map((e) {
          return ShoppingModel(
            id: e.value['id'] as String,
            title: e.value['title'] as String,
            quantity: e.value['quantity'] as int,
            isCompleted: e.value['isCompleted'] as bool,
          );
        }).toList();
  // ShoppingModel(
  //   id: doc.data()!['id'] as String,
  //   title: doc.data()!['title'] as String,
  //   quantity: doc.data()!['quantity'] as int,
  //   isCompleted: doc.data()!['isCompleted'] as bool,
  // );
  const ListModel.empty()
      : list = const [],
        listId = '',
        listName = '';

  final String listId;
  final List<ShoppingModel>? list;
  final String? listName;
  @override
  List<Object?> get props => [listId];
}
