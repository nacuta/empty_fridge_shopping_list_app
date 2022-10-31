import 'package:flutter/material.dart';
import 'package:empty_fridge_shopping_list_app/authentification/auth/bloc/auth_bloc.dart';
import 'package:empty_fridge_shopping_list_app/authentification/auth/view/auth_page.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/view/shopping_page.dart';

List<MaterialPage<void>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [ShoppingPage.page()];
    case AppStatus.unauthenticated:
      return [AuthPage.page()];
  }
}
