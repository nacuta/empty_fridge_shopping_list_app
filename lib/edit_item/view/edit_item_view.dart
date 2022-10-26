import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/edit_item/bloc/edit_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';

/// The [EditItemPage] class is a shallow widget to pass the BlocProvider to the
/// EditItemView
class EditItemPage extends StatelessWidget {
  const EditItemPage({super.key, required this.listId});
  final String listId;

  // Route with  stless widget to provide bloc of edit item
  static Route<void> route({
    required ShoppingModel? editShopping,
    required String listId,
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditItemBloc(
          initialItem: editShopping,
          databaseRepository: DatabaseRepositoryImpl(),
        ),
        child: EditItemPage(
          listId: listId,
        ),
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
      child: EditItemView(
        listId: listId,
      ),
    );
  }
}

/// the class [EditItemView] contains the UI elements
/// for changing the model params
class EditItemView extends StatefulWidget {
  const EditItemView({super.key, required this.listId});
  final String listId;
  @override
  State<EditItemView> createState() => _EditItemViewState();
}

class _EditItemViewState extends State<EditItemView> {
  final _titleController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditItemBloc>().state;
    final theme = Theme.of(context);
    _quantityController.text = state.quantity.toString();
    _titleController.text = state.title;
    final editItemBloc = context.read<EditItemBloc>();
    // var textvalue = '';

    return BlocBuilder<EditItemBloc, EditItemState>(
      builder: (context, state) {
        final value = context.watch<EditItemBloc>().state.quantity;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  editItemBloc.add(EditItemSubmitted(widget.listId));
                  //For offline mode
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.save),
              )
            ],
            title: const Text('Edit Shopping'),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Textfield that handles the title
                TextField(
                  ///this [onTapOutside] works with
                  ///Flutter:3.4.0-19.0.pre.63
                  ///or just comment it and submit changes with keyboard enter.
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
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
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
                //Row with 2 buttons incrementand decrement the number
                //And TextFiled for quantity
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
                        // onTapOutside: (event) {
                        //   final currentFocus = FocusScope.of(context);
                        //   editItemBloc.add(
                        //     EditItemQuantityInput(
                        //       int.parse(_quantityController.text),
                        //     ),
                        //   );
                        //   if (!currentFocus.hasPrimaryFocus) {
                        //     currentFocus.unfocus();
                        //   }
                        // },
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
                //future improvement addding notes
                const Text(
                  'No note yet',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
