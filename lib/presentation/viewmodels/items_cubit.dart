import 'package:assignment/data/item_repository_impl.dart';
import 'package:assignment/domain/item_repository.dart';
import 'package:assignment/presentation/viewmodels/items_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemRepository itemRepository;

  ItemsCubit({required this.itemRepository}) : super(const ItemsState());

  Future<void> loadInitialItems() async {
    try {
      final cachedItems = await (itemRepository as ItemRepositoryImpl).localDataSource.getCachedItems();
      if (cachedItems.isNotEmpty) {
        emit(state.copyWith(items: cachedItems, status: ItemsStatus.loadedFromLocal));
      }
    } catch (_) {} 

    try {
      if (state.items.isEmpty) {
         emit(state.copyWith(status: ItemsStatus.loading));
      }

      final newItems = await itemRepository.getItems(1);
      emit(state.copyWith(
        items: newItems,
        status: ItemsStatus.success,
        currentPage: 1,
      ));
    } catch (e) {
      if (state.items.isEmpty) {
         emit(state.copyWith(status: ItemsStatus.failure, errorMessage: e.toString()));
      }
    }
  }

  Future<void> refreshItems() async {
    try {
      final newItems = await itemRepository.getItems(1);
      emit(state.copyWith(
        items: newItems,
        status: ItemsStatus.success,
        currentPage: 1,
      ));
    } catch (e) {
       emit(state.copyWith(status: ItemsStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> loadMoreItems() async {
    if (state.status == ItemsStatus.loadingMore ) return;

    emit(state.copyWith(status: ItemsStatus.loadingMore));

    try {
      final nextPage = state.currentPage + 1;
      final newItems = await itemRepository.getItems(nextPage);
      
      if (newItems.isEmpty) {
        emit(state.copyWith(status: ItemsStatus.success));
      } else {
        emit(state.copyWith(
          items: List.of(state.items)..addAll(newItems),
          status: ItemsStatus.success,
          currentPage: nextPage,
        ));
      }
    } catch (e) {
       emit(state.copyWith(status: ItemsStatus.failure, errorMessage: e.toString()));
    }
  }
}