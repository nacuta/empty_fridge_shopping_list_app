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

  Future addShoppingsToList(ShoppingItem newList) async {
    final docList = _firestore.collection('shoppings').doc(newList.id);

    var shop = new ShoppingItem(
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

  void getShoppingsToList() {
    _firestore.collection('shoppings').snapshots();
    // _firestore.collection('shoppings').doc('docList').get().then(
    //       (DocumentSnapshot doc) => doc.data() as Map<String, dynamic>,
    //       onError: (e) => print("Error completing: $e"),
    //     );
  }
}
