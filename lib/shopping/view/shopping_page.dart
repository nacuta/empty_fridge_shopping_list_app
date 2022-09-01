// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/cubit/shopping_cubit.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/shopping_item.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/utils/utils.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/view/add_to_list_screen.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/view/multiple_selection.dart';

// class ShoppingPage extends StatelessWidget {
//   const ShoppingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ShoppingCubit(),
//       child: const ShoppingView(),
//     );
//   }
// }

// class ShoppingView extends StatefulWidget {
//   const ShoppingView({super.key});

//   @override
//   State<ShoppingView> createState() => _ShoppingViewState();
// }

// class _ShoppingViewState extends State<ShoppingView> {
//   late Iterable<Map<String, dynamic>> iterableDocumentsMap;
//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(l10n.shoppingAppBarTitle),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             // color: Colors.red,
//             child: StreamBuilder<QuerySnapshot>(
//               stream: context.read<ShoppingCubit>().readShoppingList(),
//               builder: (
//                 BuildContext context,
//                 AsyncSnapshot<QuerySnapshot> snapshot,
//               ) {
//                 if (snapshot.hasError) {
//                   return const Text('Something went wrong');
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else {
//                   iterableDocumentsMap =
//                       snapshot.data!.docs.map((DocumentSnapshot document) {
//                     final data = document.data()! as Map<String, dynamic>;
//                     return data;
//                   });

//                   return MultipleSelectItems(
//                     shoppingList: iterableDocumentsMap,
//                   );
//                 }
//               },
//             ),
//           ),
//           Card(
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 minimumSize: MaterialStateProperty.all(const Size(400, 60)),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.add),
//                   Text('Add new Item'),
//                 ],
//               ),
//               onPressed: () async {
//                 var x = await showDialog(
//                   context: context,
//                   builder: (context) {
//                     return const AddToListScreen();
//                   },
//                 );

//                 setState(() {
//                   // shoppingList.add(x.toString());
//                   context
//                       .read<ShoppingCubit>()
//                       .addShoppingsToList(x as ShoppingItem);
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MultipleSelectItems extends StatefulWidget {
//   const MultipleSelectItems({super.key, required this.shoppingList});
//   final Iterable<Map<String, dynamic>> shoppingList;

//   @override
//   MultipleSelectItemsState createState() => MultipleSelectItemsState();
// }

// class MultipleSelectItemsState extends State<MultipleSelectItems> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ...widget.shoppingList.isNotDone(),
//             if (widget.shoppingList.isDone().length != 1)
//               const Text(
//                 'Completed',
//                 style: TextStyle(fontSize: 22),
//               )
//             else
//               Container(),
//             ...widget.shoppingList.isDone(),
//           ],
//         ),
//       ),
//     );
//   }
// }
