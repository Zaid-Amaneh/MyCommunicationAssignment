import 'package:assignment/domain/item_entity.dart';

abstract class ItemRepository {
  Future<List<ItemEntity>> getItems(int page);
}