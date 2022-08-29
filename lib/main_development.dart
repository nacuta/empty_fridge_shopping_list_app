// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:mobi_lab_shopping_list_app/app/app.dart';
import 'package:mobi_lab_shopping_list_app/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options/firebase_options_staging.dart';

void main() {
  bootstrap(() => const App());
}
