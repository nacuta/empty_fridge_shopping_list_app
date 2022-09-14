import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance
    // Apple and Android
    ..settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    )
    // Web
    ..enablePersistence(const PersistenceSettings(synchronizeTabs: true));

  //collection declared
  final String collectionPath = 'shoppings';

// get from database all tha documents
  Future<List<ShoppingModel>> retrieveListData() async {
    final snapshot = await _db.collection(collectionPath).get();
    return snapshot.docs.map(ShoppingModel.fromDocumentSnapshot).toList();
  }

// writes the item provided to database
  Future<void> saveAddedShoppingData(ShoppingModel item) async {
    await _db.collection(collectionPath).doc(item.id).set(item.toJson());
  }

  //connects to database and delete item provided
  Future<void> deleteShoppingData(ShoppingModel item) async {
    await _db.collection(collectionPath).doc(item.id).delete();
  }
}
