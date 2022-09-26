// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobi_lab_shopping_list_app/auth/auth_repository.dart';
import 'package:mobi_lab_shopping_list_app/auth/bloc/auth_bloc.dart';
import 'package:mobi_lab_shopping_list_app/auth/view/auth_delegate_page.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/utils/theme.dart';
import 'package:flow_builder/flow_builder.dart';

import '../../config/routes.dart';

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
      home: FlowBuilder<AppStatus>(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
