import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
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

  // Future<Iterable<Map<String, dynamic>>> readShoppingList() async {
  //   final ref = await FirebaseFirestore.instance.collection('shoppings').get();
  //   final val = ref.docs.map((doc) => doc.data());
  //   return val;
  // }
  Future<DocumentSnapshot<Map<String, dynamic>>> readShoppingList() async {
    var ref =
        await FirebaseFirestore.instance.collection('shoppings').doc().get();
    var _questions = ref.data();
    // ref.map((query)=>ShoppingItem(query));
    // .map(
    //   (question) => Question(
    //       id: question['id'],
    //       question: question['question'],
    //       options: question['options'],
    //       answer_index: question['answer_index']),
    // )
    // .toList();
    // var users = ShoppingItem.fromJson(_questions);
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
