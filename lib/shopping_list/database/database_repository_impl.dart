import 'package:empty_fridge_shopping_list_app/models/list.dart';
import 'package:empty_fridge_shopping_list_app/models/shopping_model.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database_repository.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();
  // implementation tosave a new item or the changed one with the same id
  @override
  Future<List<ShoppingModel>> retrieveItemsData() => service.retrieveListData();

  // fetch all the documents from a specific collection
  @override
  Future<void> saveItemData(String listId, ShoppingModel item) =>
      service.saveAddedShoppingData(listId, item);

  // delete the item with the id provided
  @override
  Future<void> deleteItemData(String docId, ShoppingModel item) {
    return service.deleteShoppingData(docId, item);
  }

  @override
  Future<List<ListModel>> retrieveLists() {
    return service.getLists();
  }

  @override
  Future<void> writeCollectionDoc(String listName, ShoppingModel item) {
    return service.writeCollection(listName, item);
  }

  @override
  Future<List<ShoppingModel>> retriveDocumentItems(String docId) {
    return service.retriveDocumentItems(docId);
  }
}
