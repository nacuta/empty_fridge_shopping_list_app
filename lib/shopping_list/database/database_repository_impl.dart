import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();
  // implementation tosave a new item or the changed one with the same id
  @override
  Future<List<ShoppingModel>> retrieveItemsData() => service.retrieveListData();

  // fetch all the documents from a specific collection
  @override
  Future<void> saveItemData(ShoppingModel item) =>
      service.saveAddedShoppingData(item);

  // delete the item with the id provided
  @override
  Future<void> deleteItemData(ShoppingModel item) {
    return service.deleteShoppingData(item);
  }
}
