import 'package:flutter/material.dart';
import 'package:mobi_lab_shopping_list_app/shopping/shopping.dart';

extension IsChecked<T> on Iterable<Map<String, dynamic>> {
  List<Widget> isNotDone() {
    List<Widget> _widget = [SizedBox(height: 20.0)];
    for (final map in this) {
      final isChecked = map['isCompleted'] as bool;
      if (!isChecked) {
        _widget.add(
          ListTileWidget(
            tittle: map['title'] as String,
            subtitle: map['quantity'].toString(),
            isChecked: isChecked,
            id: map['id'] as String,
          ),
        );
        _widget.add(SizedBox(height: 10.0));
      }
    }
    return _widget;
  }

  List<Widget> isDone() {
    List<Widget> _widget = [SizedBox(height: 20.0)];
    for (final map in this) {
      final isChecked = map['isCompleted'] as bool;
      if (isChecked) {
        _widget.add(
          ListTileWidget(
            tittle: map['title'] as String,
            subtitle: map['quantity'].toString(),
            isChecked: isChecked,
            id: map['id'] as String,
          ),
        );
        _widget.add(SizedBox(height: 10.0));
      }
    }
    return _widget;
  }
}
