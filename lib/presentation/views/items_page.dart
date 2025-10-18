import 'package:assignment/core/utils/helper_methods.dart';
import 'package:assignment/presentation/viewmodels/items_cubit.dart';
import 'package:assignment/presentation/viewmodels/items_state.dart';
import 'package:assignment/presentation/widgets/bottom_loader.dart';
import 'package:assignment/presentation/widgets/empty_view.dart';
import 'package:assignment/presentation/widgets/error_view.dart';
import 'package:assignment/presentation/widgets/item_card_widget.dart';
import 'package:assignment/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ItemsCubit>().loadInitialItems();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ItemsCubit>().loadMoreItems();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Items',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black87,
      ),
      body: BlocConsumer<ItemsCubit, ItemsState>(
        listener: (context, state) {
          if (state.status == ItemsStatus.success && state.currentPage==1) {
            customToastification(
              context: context,
              type:ToastificationType.success,
              title: "Successfully",
              description: 'Data has den updated successfully',
              seconds: 3,
            );
          }
        },
        builder: (context, state) {
          // Initial loading state
          if (state.status == ItemsStatus.initial ||
              (state.status == ItemsStatus.loading && state.items.isEmpty)) {
            return const LoadingView();
          }

          // Error state with empty items
          if (state.status == ItemsStatus.failure && state.items.isEmpty) {
            return ErrorView(
              message: state.errorMessage,
              onRetry: () => context.read<ItemsCubit>().loadInitialItems(),
            );
          }

          // Empty state after a successful fetch returns nothing
          if (state.items.isEmpty) {
            return const EmptyView();
          }

          // Success state with items
          return RefreshIndicator(
            onRefresh: () => context.read<ItemsCubit>().refreshItems(),
            color: Theme.of(context).primaryColor,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.items.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return state.status == ItemsStatus.loadingMore
                      ? const BottomLoader()
                      : const SizedBox(height: 16);
                }
                final item = state.items[index];
                return ItemCard(item: item);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
