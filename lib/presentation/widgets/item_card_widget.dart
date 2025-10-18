import 'package:assignment/domain/item_entity.dart';
import 'package:assignment/presentation/widgets/compact_item_layout.dart';
import 'package:assignment/presentation/widgets/expanded_item_layout.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final ItemEntity item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.05),

            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Tapped: ${item.title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
            },
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              child: isSmallScreen
                  ? CompactItemLayout(item: item)
                  : ExpandedItemLayout(item: item),
            ),
          ),
        ),
      ),
    );
  }
}
