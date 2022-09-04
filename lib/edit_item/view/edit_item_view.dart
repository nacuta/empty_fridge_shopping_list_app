import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/edit_item/bloc/edit_item_bloc.dart';
import 'package:mobi_lab_shopping_list_app/models/shopping_model.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/bloc/bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/database/database_repository_impl.dart';

class EditItemPage extends StatelessWidget {
  const EditItemPage({super.key});
  // final ShoppingModel editShopping;

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
    final status = context.select((EditItemBloc bloc) => bloc.state.status);
    final isNewShoppingItem = context.select(
      (EditItemBloc bloc) => bloc.state.isNewShoppingItem,
    );
    final state = context.watch<EditItemBloc>().state;
    final theme = Theme.of(context);
    var _titleController = TextEditingController();
    var _quantityController = TextEditingController()
      ..text = state.quantity.toString();
    _titleController.text = _titleController.text = state.title;

    return BlocBuilder<EditItemBloc, EditItemState>(
      builder: (context, state) {
        int? value = context.watch<EditItemBloc>().state.quantity;
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  context.read<EditItemBloc>().add(const EditItemSubmitted());
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
                  onSubmitted: (value) {
                    context
                        .read<EditItemBloc>()
                        .add(EditItemTitleChanged(value));
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
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                      height: 40,
                      width: 60,
                      child: IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          context
                              .read<EditItemBloc>()
                              .add(EditItemQuantityDecrement(value));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                      height: 40,
                      width: 60,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          context
                              .read<EditItemBloc>()
                              .add(EditItemQuantityIncrement(value));
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
                          context
                              .read<EditItemBloc>()
                              .add(EditItemQuantityInput(int.parse(value)));
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
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
        );
      },
    );
  }
}

class QuantityContainer extends StatelessWidget {
  const QuantityContainer({
    super.key,
    required this.iconProvided,
    required this.controller,
    required this.eventAdded,
  });
  final IconData iconProvided;
  final TextEditingController controller;
  final void eventAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
      ),
      height: 40,
      width: 60,
      child: IconButton(
        icon: Icon(
          iconProvided,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          eventAdded;
        },
      ),
    );
  }
}
