import 'package:assignment/domain/item_entity.dart';
import 'package:equatable/equatable.dart';

enum ItemsStatus { initial, loading, success, failure, loadingMore, loadedFromLocal }

class ItemsState extends Equatable {
  final List<ItemEntity> items;
  final ItemsStatus status;
  final int currentPage;
  final String errorMessage;

  const ItemsState({
    this.items = const [],
    this.status = ItemsStatus.initial,
    this.currentPage = 1,
    this.errorMessage = '',
  });

  ItemsState copyWith({
    List<ItemEntity>? items,
    ItemsStatus? status,
    int? currentPage,
    String? errorMessage,
  }) {
    return ItemsState(
      items: items ?? this.items,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [items, status, currentPage, errorMessage];
}