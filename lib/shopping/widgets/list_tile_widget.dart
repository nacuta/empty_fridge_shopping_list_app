import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping/cubit/shopping_cubit.dart';
import 'package:mobi_lab_shopping_list_app/shopping/shopping_item.dart';
import 'package:mobi_lab_shopping_list_app/shopping/view/multiple_selection.dart';

class ListTileWidget extends StatefulWidget {
  const ListTileWidget({
    super.key,
    required this.tittle,
    required this.subtitle,
    required this.isChecked,
    required this.id,
  });
  final String tittle;
  final String subtitle;
  final bool isChecked;
  final String id;

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    var isCheck = widget.isChecked;
    final ceva = ShoppingItem(
      title: widget.tittle,
      quantity: int.parse(widget.subtitle),
      isCompleted: isCheck,
      id: widget.id,
    );

    Color getColor(Set<MaterialState> states) {
      const interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Card(
      child: ListTile(
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ShoppingCubit(),
                child: const MultipleSelectionPage(),
              ),
            ),
          );

          // context.read<ShoppingCubit>().deleteShoppingList(ceva);
        },
        leading: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isCheck,
          shape: const CircleBorder(),
          onChanged: (bool? value) {
            setState(() {
              isCheck = value!;
              context
                  .read<ShoppingCubit>()
                  .addShoppingsToList(ceva.copyWith(isCompleted: isCheck));
            });
          },
        ),
        title: isCheck
            ? Text(
                widget.tittle,
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              )
            : Text(
                widget.tittle,
              ),
        subtitle: Text(
          widget.subtitle,
        ),
        trailing: const Icon(Icons.edit),
      ),
    );
  }
}
