// // Copyright (c) 2022, Very Good Ventures
// // https://verygood.ventures
// //
// // Use of this source code is governed by an MIT-style
// // license that can be found in the LICENSE file or at
// // https://opensource.org/licenses/MIT.

// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:empty_fridge_shopping_list_app/counter/counter.dart';
// import 'package:empty_fridge_shopping_list_app/shopping/cubit/shopping_cubit.dart';

// void main() {
//   group('ShoppingCubit', () {
//     test('initial state is 0', () {
//       expect(ShoppingCubit().state, equals(0));
//     });

//     blocTest<CounterCubit, int>(
//       'emits [1] when increment is called',
//       build: CounterCubit.new,
//       act: (cubit) => cubit.increment(),
//       expect: () => [equals(1)],
//     );

//     blocTest<CounterCubit, int>(
//       'emits [-1] when decrement is called',
//       build: CounterCubit.new,
//       act: (cubit) => cubit.decrement(),
//       expect: () => [equals(-1)],
//     );
//   });
// }
