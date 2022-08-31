part of 'shopping_cubit.dart';

@immutable
abstract class ShoppingState extends Equatable {}

class ShoppingInitial extends ShoppingState {
  @override
  List<Object?> get props => [];
}

class ShoppingIsLoading extends ShoppingState {
  @override
  List<Object?> get props => [];
}

class ShoppingIsLoaded extends ShoppingState {
  ShoppingIsLoaded(this.iterableMap);
  final Iterable<Map<String, dynamic>> iterableMap;
  @override
  List<Object?> get props => [iterableMap];
}
