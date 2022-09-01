import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<List<ShoppingModel>> retrieveItemsData() => service.retrieveListData();

  @override
  Future<void> saveItemData(ShoppingModel item) =>
      service.saveAddedShoppingData(item);

  @override
  Future<void> deleteItemData(ShoppingModel item) =>
      service.deleteShoppingData(item);
}
