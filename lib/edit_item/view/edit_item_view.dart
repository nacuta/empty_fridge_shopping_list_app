import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/edit_item/bloc/edit_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';

class EditItemPage extends StatelessWidget {
  const EditItemPage({super.key});

  // Route with  stless widget to provide bloc of edit item
  static Route<void> route({required ShoppingModel? editShopping}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditItemBloc(
          initialItem: editShopping,
          databaseRepository: DatabaseRepositoryImpl(),
        ),
        child: const EditItemPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditItemBloc, EditItemState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditItemStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditItemView(),
    );
  }
}

class EditItemView extends StatelessWidget {
  const EditItemView({super.key});
  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditItemBloc>().state;
    final theme = Theme.of(context);
    final _titleController = TextEditingController();
    final _quantityController = TextEditingController()
      ..text = state.quantity.toString();
    _titleController.text = _titleController.text = state.title;
    final editItemBloc = context.read<EditItemBloc>();
    var textvalue = '';

    return BlocBuilder<EditItemBloc, EditItemState>(
      builder: (context, state) {
        int? value = context.watch<EditItemBloc>().state.quantity;
        return GestureDetector(
          onTap: () {
            textvalue = _titleController.text;
            final currentFocus = FocusScope.of(context);
            editItemBloc.add(EditItemTitleChanged(textvalue));
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    editItemBloc.add(const EditItemSubmitted());
                  },
                  icon: const Icon(Icons.save),
                )
              ],
              title: const Text('Edit Shopping'),
            ),
            // ignore: use_colored_box
            body: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    //TODO this onTapOutside it is not defined in TextField class
                    // onTapOutside: (event) {
                    //   textvalue = _titleController.text;
                    //   final currentFocus = FocusScope.of(context);
                    //   editItemBloc.add(EditItemTitleChanged(textvalue));
                    //   if (!currentFocus.hasPrimaryFocus) {
                    //     currentFocus.unfocus();
                    //   }
                    // },
                    autofocus: true,
                    onSubmitted: (value) {
                      editItemBloc.add(EditItemTitleChanged(value));
                    },
                    controller: _titleController,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Quantity',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: theme.primaryColor,
                          ),
                        ),
                        height: 40,
                        width: 60,
                        child: IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: theme.primaryColor,
                          ),
                          onPressed: () {
                            editItemBloc.add(EditItemQuantityDecrement(value));
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: theme.primaryColor,
                          ),
                        ),
                        height: 40,
                        width: 60,
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: theme.primaryColor,
                          ),
                          onPressed: () {
                            editItemBloc.add(EditItemQuantityIncrement(value));
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: TextField(
                          controller: _quantityController,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(color: Colors.black),
                          onSubmitted: (value) {
                            editItemBloc
                                .add(EditItemQuantityInput(int.parse(value)));
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'piece',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Note',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'No note yet',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
