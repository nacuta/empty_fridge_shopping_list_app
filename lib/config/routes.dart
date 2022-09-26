import 'package:flutter/widgets.dart';

import '../../shopping_list/view/home_screen.dart';
import '../auth/bloc/auth_bloc.dart';
import '../login/view/login_page.dart';

List<Page> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
