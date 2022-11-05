// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:empty_fridge_shopping_list_app/adding_shopping_item/bloc/bloc.dart';
import 'package:empty_fridge_shopping_list_app/authentification/auth/auth_repository.dart';
import 'package:empty_fridge_shopping_list_app/authentification/auth/bloc/auth_bloc.dart';
import 'package:empty_fridge_shopping_list_app/config/routes.dart';
import 'package:empty_fridge_shopping_list_app/l10n/l10n.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/cubit/list_cubit.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database.dart';
import 'package:empty_fridge_shopping_list_app/utils/theme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(
          authRepository: _authRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DatabaseBloc(
              DatabaseRepositoryImpl(),
            ),
          ),
          BlocProvider(
            create: (context) => ListCubit(
              DatabaseRepositoryImpl(),
            ),
          ),
          BlocProvider(
            create: (context) => AddShoppingItemBloc(
              DatabaseRepositoryImpl(),
            ),
          ),
        ],
        child: FlowBuilder<AppStatus>(
          state: context.select((AuthBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
  }
}
