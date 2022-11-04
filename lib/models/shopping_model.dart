import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ShoppingModel extends Equatable {
  const ShoppingModel({
    this.quantity = 1,
    this.id = '',
    required this.title,
    this.isCompleted = false,
  });
  const ShoppingModel.empty()
      : title = '',
        id = '',
        quantity = 0,
        isCompleted = false;

  ShoppingModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!['title'] as String,
        quantity = doc.data()!['quantity'] as int,
        isCompleted = doc.data()!['isCompleted'] as bool;

  ShoppingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        quantity = json['quantity'] as int,
        isCompleted = json['isCompleted'] as bool;

  final String title;
  final int quantity;
  final String id;
  final bool? isCompleted;

  ShoppingModel copyWith({
    String? id,
    String? title,
    int? quantity,
    bool? isCompleted,
  }) {
    return ShoppingModel(
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
  List<Object?> get props => [title, quantity, isCompleted, id];
}
