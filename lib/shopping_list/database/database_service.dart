import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_fridge_shopping_list_app/models/list.dart';
import 'package:empty_fridge_shopping_list_app/models/shopping_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // // Apple and Android
  // ..settings = const Settings(
  //   persistenceEnabled: true,
  //   cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  // )
  // Web
  // ..enablePersistence(const PersistenceSettings(synchronizeTabs: true));

  //collection declared
  static String collectionPath = 'shoppings';

// get from database all tha documents
  Future<List<ShoppingModel>> retrieveListData() async {
    final snapshot = await _db.collection(collectionPath).get();
    return snapshot.docs.map(ShoppingModel.fromDocumentSnapshot).toList();
  }

// writes the item provided to database
  Future<void> saveAddedShoppingData(String listId, ShoppingModel item) async {
    await _db.collection(collectionPath).doc(listId).update(
      {item.id: item.toJson()},
    );
  }

  //connects to database and delete item provided
  Future<void> deleteShoppingData(String docId, ShoppingModel item) async {
    await _db
        .collection(collectionPath)
        .doc(docId)
        .update({item.id: FieldValue.delete()});
  }

  //connects to database and delete item provided
  Future<List<ListModel>> getLists() async {
    final snapshot = await _db.collection(collectionPath).get();
    return snapshot.docs.map(ListModel.fromDocumentSnapshot).toList();
  }

  Future<List<ShoppingModel>> retriveDocumentItems(String docId) async {
    final shot = await _db.collection(collectionPath).doc(docId).get();
    // print(shot);
    // ignore: omit_local_variable_types
    final List<ShoppingModel> list = [];
    shot.data()!.forEach((key, value) {
      final doc = value as Map<String, dynamic>;
      final listElements = ShoppingModel.fromJson(doc);
      // final x = ShoppingModel(
      //   title: doc['title'] as String,
      //   id: doc['id'] as String,
      //   quantity: doc['quantity'] as int,
      //   isCompleted: doc['isCompleted'] as bool,
      // );
      list.add(listElements);
    });
    return list;
  }

  Future<void> writeCollection(String listName, ShoppingModel item) async {
    await _db.collection(collectionPath).doc(listName).set(
      {item.id: item.toJson()},
      SetOptions(merge: true),
    );
  }

  //delete a document from the collection with all items
  Future<void> deleteDocument(String docId) async {
    await _db.collection(collectionPath).doc(docId).delete();
  }
}
