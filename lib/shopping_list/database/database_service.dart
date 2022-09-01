import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionPath = 'shoppings';

  Future<List<ShoppingModel>> retrieveListData() async {
    final snapshot = await _db.collection(collectionPath).get();
    return snapshot.docs.map(ShoppingModel.fromDocumentSnapshot).toList();
  }

  Future<void> saveAddedShoppingData(ShoppingModel item) async {
    await _db.collection(collectionPath).doc(item.id).set(item.toJson());
  }

  Future<void> deleteShoppingData(ShoppingModel item) async {
    await _db
        .collection(collectionPath)
        .doc(item.id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to delete user: $error'));
  }
}
