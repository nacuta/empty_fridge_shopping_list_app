import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/shopping/cubit/shopping_cubit.dart';
import 'package:mobi_lab_shopping_list_app/shopping/view/add_to_list_screen.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingCubit(),
      child: const ShoppingView(),
    );
  }
}

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  List<String> shoppingList = [
    'Apples',
    'Pears',
    'Citrus',
    'StrawBerries',
  ];
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shoppingAppBarTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: MultipleSelectItems(shoppingList: shoppingList)),
          Card(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(400, 60)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add),
                  Text('Add new Item'),
                ],
              ),
              onPressed: () async {
                final x = await showDialog(
                  context: context,
                  builder: (context) {
                    return const AddToListScreen();
                  },
                );
                setState(() {
                  // shoppingList.add(x.toString());
                  context.read<ShoppingCubit>().addShoppingsToList();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MultipleSelectItems extends StatefulWidget {
  const MultipleSelectItems({super.key, required this.shoppingList});
  final List<String> shoppingList;

  @override
  MultipleSelectItemsState createState() => MultipleSelectItemsState();
}

class MultipleSelectItemsState extends State<MultipleSelectItems> {
  List<Widget> get listTileWidgets {
    List<Widget> _widget = [SizedBox(height: 40.0)];
    List<String> subtitle = ['First', 'Second', 'Third', 'Fourth'];

    // ListTileWidget is defined below in another StatefulWidget
    widget.shoppingList.forEach((name) {
      _widget.add(ListTileWidget(
        tittle: name,
        subtitle: name,
      ));
      _widget.add(SizedBox(height: 10.0));
    });

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: this.listTileWidgets)));
  }
}

class ListTileWidget extends StatefulWidget {
  const ListTileWidget(
      {super.key, required this.tittle, required this.subtitle});
  final String tittle;
  final String subtitle;

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
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
        leading: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        title: isChecked
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
