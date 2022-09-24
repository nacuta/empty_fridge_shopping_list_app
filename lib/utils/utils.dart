import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';

extension CapExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(' ').map((str) => str.capitalize).join(' ');
}

extension AcList on List<ShoppingModel> {
  List<ShoppingModel> isToShop() =>
      List.of(where((element) => element.isCompleted == false));
  List<ShoppingModel> isShop() =>
      List.of(where((element) => element.isCompleted == true));
}
