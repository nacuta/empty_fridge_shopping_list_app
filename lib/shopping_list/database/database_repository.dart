import 'package:mobi_lab_shopping_list_app/models/list.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

/// The interface for an API that provides
/// access to a list of shopping items.
abstract class DatabaseRepository {
  // save a new item or the changed one with the same id
  Future<void> saveItemData(String listId, ShoppingModel item);

  // delete the item with the id provided
  Future<void> deleteItemData(String listId, ShoppingModel item);

  // fetch all the documents from a specific collection
  Future<List<ShoppingModel>> retrieveItemsData();

  // fetch all the documents from a specific collection
  Future<List<ListModel>> retrieveLists();

  Future<void> writeCollectionDoc(String listName, ShoppingModel item);

  Future<List<ShoppingModel>> retriveDocumentItems(String docId);
}
