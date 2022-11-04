import 'package:empty_fridge_shopping_list_app/shopping_list/cubit/list_cubit.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/database/database_repository_impl.dart';
import 'package:empty_fridge_shopping_list_app/shopping_list/view/add_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewList extends StatelessWidget {
  const NewList({super.key});

  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const NewList(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit(DatabaseRepositoryImpl()),
      child: const NewListForm(),
    );
  }
}

class NewListForm extends StatefulWidget {
  const NewListForm({super.key});

  @override
  State<NewListForm> createState() => _NewListFormState();
}

class _NewListFormState extends State<NewListForm> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            style: const TextStyle(color: Colors.black),
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'New List',
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   AddList.route(
              //     _textEditingController.text,
              //     [],
              //   ),
              // );
            },
            child: const Text('Submit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('return'),
          )
        ],
      ),
    );
  }
}
