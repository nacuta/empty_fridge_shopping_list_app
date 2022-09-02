// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
// import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/database_bloc.dart';
// import 'package:mobi_lab_shopping_list_app/utils/constants.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   final _shoppingItemController = TextEditingController();

//   late String text;
//   @override
//   void initState() {
//     super.initState();
//     _shoppingItemController.addListener(_isTextEditingNotEmpthy);
//   }

//   @override
//   void dispose() {
//     _shoppingItemController.dispose();
//     super.dispose();
//   }

//   bool _isTextEditingNotEmpthy() {
//     setState(() {});
//     return _shoppingItemController.text.isNotEmpty;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: Container(
//         // padding: const EdgeInsets.all( 8),
//         margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
//         width: Responsive.width(90, context),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: const Offset(0, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8),
//           child: TextField(
//             controller: _shoppingItemController,
//             decoration: InputDecoration(
//               suffixIcon: Container(
//                 width: 80,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         _shoppingItemController.text = '';
//                       },
//                     ),
//                     if (_isTextEditingNotEmpthy())
//                       IconButton(
//                         icon: const Icon(Icons.check_box),
//                         onPressed: () {
//                           if (_isTextEditingNotEmpthy()) {
//                             ShoppingModel(
//                               title: _shoppingItemController.text,
//                             );

//                             context.read<DatabaseBloc>().add(
//                                   DatabaseWrite(
//                                     ShoppingModel(
//                                       title: _shoppingItemController.text,
//                                     ),
//                                   ),
//                                 );
//                           }
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//               hintText: 'Add item',
//               border: InputBorder.none,
//             ),
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.done,
//             minLines: 1,
//             maxLines: 1000,
//           ),
//         ),
//       ),
//     );
//   }
// }
