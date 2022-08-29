import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(ShoppingInitial());
  FirebaseFirestore _firestore;

  void addShoppingsToList() {
    _firestore
        .collection('shoppings')
        .doc('docList')
        .set(<String, dynamic>{'Title': 'Ceva bun'});
  }

  void getShoppingsToList() {
    _firestore.collection('shoppings').doc('docList').get().then(
          (DocumentSnapshot doc) => doc.data() as Map<String, dynamic>,
          onError: (e) => print("Error completing: $e"),
        );
  }
}
