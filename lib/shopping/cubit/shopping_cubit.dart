import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobi_lab_shopping_list_app/shopping/shopping_item.dart';

import '../view/shopping_page.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(ShoppingInitial());
  FirebaseFirestore _firestore;

  Stream<QuerySnapshot<Map<String, dynamic>>> readShoppingList() {
    final ref = FirebaseFirestore.instance.collection('shoppings').snapshots();

    return ref;
  }

  Future<dynamic> addShoppingsToList(ShoppingItem newList) async {
    final docList = _firestore.collection('shoppings').doc(newList.id);

    final shop = ShoppingItem(
      title: newList.title,
    );
    final shoppingItem = shop.copyWith(
      id: docList.id,
      isCompleted: newList.isCompleted,
      quantity: newList.quantity,
    );
    final soppingData = shoppingItem.toJson();

    await docList.set(soppingData);
  }

  Future<void> deleteShoppingList(ShoppingItem newList) {
    final docList = _firestore
        .collection('shoppings')
        .doc(newList.id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));

    return docList;
  }
}
