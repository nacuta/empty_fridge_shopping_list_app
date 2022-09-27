import 'package:flutter/widgets.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/shopping_page.dart';

import '../../shopping_list/view/home_screen.dart';
import '../auth/bloc/auth_bloc.dart';
import '../login/view/login_page.dart';

List<Page> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [ShoppingPage.page()];
    case AppStatus.unauthenticated:
      // return [LoginScreen.page()];
      return [LoginScreen.page()];
  }
}
