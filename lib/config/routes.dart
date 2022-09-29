import 'package:flutter/src/material/page.dart';
import 'package:flutter/widgets.dart';
import 'package:mobi_lab_shopping_list_app/auth/bloc/auth_bloc.dart';
import 'package:mobi_lab_shopping_list_app/auth/view/auth_page.dart';
import 'package:mobi_lab_shopping_list_app/login/view/login_page.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/home_screen.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/shopping_page.dart';

List<MaterialPage<void>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [AuthPage.page()];
    // return [LoginScreen.page()];
  }
}
