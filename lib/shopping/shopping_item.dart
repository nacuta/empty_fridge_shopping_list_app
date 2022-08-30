import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

@immutable
class ShoppingItem extends Equatable {
  ShoppingItem({
    this.quantity = 1,
    String? id,
    required this.title,
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  ShoppingItem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        quantity = json['quantity'] as int,
        isCompleted = json['isCompleted'] as bool;

  final String title;
  final int quantity;
  final String id;
  final bool? isCompleted;

  ShoppingItem copyWith({
    String? id,
    String? title,
    int? quantity,
    bool? isCompleted,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'quantity': quantity,
        'isCompleted': isCompleted,
      };

  @override
  List<Object?> get props => [title, quantity];
}
