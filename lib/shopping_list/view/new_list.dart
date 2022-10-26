import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/cubit/list_cubit.dart';
import 'package:mobi_lab_shopping_list_app/shopping_list/view/add_list.dart';

import '../database/database_repository_impl.dart';

class NewList extends StatelessWidget {
  const NewList({super.key});

  @override
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const NewList(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListCubit(DatabaseRepositoryImpl()),
      child: NewListForm(),
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
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: 'New List'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                AddList.route(
                  _textEditingController.text,
                  [],
                ),
              );
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
