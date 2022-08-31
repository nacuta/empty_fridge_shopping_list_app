import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/l10n/l10n.dart';
import 'package:mobi_lab_shopping_list_app/shopping/cubit/shopping_cubit.dart';
import 'package:mobi_lab_shopping_list_app/shopping/shopping_item.dart';
import 'package:mobi_lab_shopping_list_app/shopping/utils/utils.dart';
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
  // @override
  // Widget build(BuildContext context) {
  //   final l10n = context.l10n;

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(l10n.shoppingAppBarTitle),
  //       centerTitle: true,
  //     ),
  //     body: Column(
  //       children: [
  //         FutureBuilder(
  //           future: context.read<ShoppingCubit>().readShoppingList(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return CircularProgressIndicator();
  //             } else if (snapshot.hasData) {
  //               return Text(snapshot.data.toString());
  //             } else {
  //               var xx = snapshot.data;

  //               return Text('error');
  //             }
  //             // var yy =
  //           },
  //         ),

  //

  //       ],
  //     ),
  //   );
  // }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('shoppings').snapshots();

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
          Expanded(
            // color: Colors.red,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final lista = <String, dynamic>{};
                  var iterableDocumentsMap =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    final data = document.data()! as Map<String, dynamic>;
                    print(data);
                    return data;
                  });

                  return MultipleSelectItems(
                    shoppingList: iterableDocumentsMap,
                  );
                }
              },
            ),
          ),
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
                var y = ShoppingItem(title: x.toString());
                setState(() {
                  // shoppingList.add(x.toString());
                  context.read<ShoppingCubit>().addShoppingsToList(y);
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
  final Iterable<Map<String, dynamic>> shoppingList;

  @override
  MultipleSelectItemsState createState() => MultipleSelectItemsState();
}

class MultipleSelectItemsState extends State<MultipleSelectItems> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Shopping list',
              style: TextStyle(fontSize: 22),
            ),
            ...widget.shoppingList.isNotDone(),
            const Text(
              'Completed',
              style: TextStyle(fontSize: 22),
            ),
            ...widget.shoppingList.isDone(),
          ],
        ),
      ),
    );
  }
}

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
          context.read<ShoppingCubit>().deleteShoppingList(ceva);
        },
        leading: Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isCheck,
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
