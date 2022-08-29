// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/app/app.dart';
import 'package:mobi_lab_shopping_list_app/bootstrap.dart';
import 'package:mobi_lab_shopping_list_app/firebase_options/firebase_options_staging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //This line is necessary
  );
  await bootstrap(() => const App());
}
