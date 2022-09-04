// // Copyright (c) 2022, Very Good Ventures
// // https://verygood.ventures
// //
// // Use of this source code is governed by an MIT-style
// // license that can be found in the LICENSE file or at
// // https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_lab_shopping_list_app/app/app.dart';
import 'package:mobi_lab_shopping_list_app/shopping/view/shopping_page.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/shopping_page.dart';

void main() {
  group('App', () {
    testWidgets('renders Shopping Page', (tester) async {
      await tester.pumpWidget(const ShoppingView());

      // expect(find.byType(ShoppingPage, findsOneWidget);
    });
  });
}
