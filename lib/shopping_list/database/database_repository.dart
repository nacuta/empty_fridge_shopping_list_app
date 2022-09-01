import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

abstract class DatabaseRepository {
  Future<void> saveItemData(ShoppingModel item);
  Future<void> deleteItemData(ShoppingModel item);
  Future<List<ShoppingModel>> retrieveItemsData();
}
