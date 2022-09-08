import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/shopping_page.dart';

extension CapExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(' ').map((str) => str.capitalize).join(' ');
}

extension aclist on List<ShoppingModel> {
  List<ShoppingModel> isToShop() =>
      List.of(where((element) => element.isCompleted == false));
  List<ShoppingModel> isShop() =>
      List.of(where((element) => element.isCompleted == true));
}
