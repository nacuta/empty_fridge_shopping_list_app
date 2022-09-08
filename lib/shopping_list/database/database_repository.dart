import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

/// The interface for an API that provides
/// access to a list of shopping items.
abstract class DatabaseRepository {
  // save a new item or the changed one with the same id
  Future<void> saveItemData(ShoppingModel item);

  // delete the item with the id provided
  Future<void> deleteItemData(ShoppingModel item);

  // fetch all the documents from a specific collection
  Future<List<ShoppingModel>> retrieveItemsData();
}
