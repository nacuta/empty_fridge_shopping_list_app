// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/cubit/shopping_cubit.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/shopping_item.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/utils/utils.dart';
// import 'package:mobi_lab_shopping_list_app/shopping/view/multiple_selection.dart';

// class MultipleSelectedListTileWidget extends StatefulWidget {
//   const MultipleSelectedListTileWidget({
//     super.key,
//     required this.tittle,
//     required this.subtitle,
//     required this.isChecked,
//     required this.id,
//   });
//   final String tittle;
//   final String subtitle;
//   final bool isChecked;
//   final String id;

//   @override
//   State<MultipleSelectedListTileWidget> createState() =>
//       _MultipleSelectedListTileWidgetState();
// }

// class _MultipleSelectedListTileWidgetState
//     extends State<MultipleSelectedListTileWidget> {
//   @override
//   Widget build(BuildContext context) {
//     var isCheck = widget.isChecked;
//     bool isSelected = false;
//     final ceva = ShoppingItem(
//       title: widget.tittle,
//       quantity: int.parse(widget.subtitle),
//       isCompleted: isCheck,
//       id: widget.id,
//     );

//     Color getColor(Set<MaterialState> states) {
//       const interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Colors.blue;
//       }
//       return Colors.red;
//     }

//     return Card(
//       color: Colors.grey,
//       child: ListTile(
//         title: isCheck
//             ? Text(
//                 widget.tittle,
//                 style: const TextStyle(decoration: TextDecoration.lineThrough),
//               )
//             : Text(
//                 widget.tittle,
//               ),
//         subtitle: Text(
//           widget.subtitle,
//         ),
//         trailing: Checkbox(
//           checkColor: Colors.white,
//           fillColor: MaterialStateProperty.resolveWith(getColor),
//           value: isSelected,
//           shape: const CircleBorder(),
//           onChanged: (value) {
//             setState(() {
//               isSelected = value!;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

// class MultipleSelectItems2 extends StatefulWidget {
//   const MultipleSelectItems2({super.key, required this.shoppingList});
//   final Iterable<Map<String, dynamic>> shoppingList;

//   @override
//   MultipleSelectItems2State createState() => MultipleSelectItems2State();
// }

// class MultipleSelectItems2State extends State<MultipleSelectItems2> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ...widget.shoppingList.areNotDone(),
//             if (widget.shoppingList.multipleAreDone().length != 1)
//               const Text(
//                 'Completed',
//                 style: TextStyle(fontSize: 22),
//               )
//             else
//               Container(),
//             ...widget.shoppingList.multipleAreDone(),
//           ],
//         ),
//       ),
//     );
//   }
// }
