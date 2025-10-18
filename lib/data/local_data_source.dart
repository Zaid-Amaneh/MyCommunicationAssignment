import 'package:assignment/data/item_model.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  Future<List<ItemModel>> getCachedItems();
  Future<void> cacheItems(List<ItemModel> items);
  Future<void> clearCache();
}

class LocalDataSourceImpl implements LocalDataSource {
  static const String _boxName = 'items_box';
  static const String _cacheKeyFirstPage = 'cached_items_page_1';

  final Box _box;

  LocalDataSourceImpl._(this._box);

  static Future<LocalDataSourceImpl> create() async {
    final box = await Hive.openBox(_boxName);
    return LocalDataSourceImpl._(box);
  }

  @override
  Future<void> cacheItems(List<ItemModel> items) async {
    await _box.put(_cacheKeyFirstPage, items);
  }

  @override
  Future<void> clearCache() async {
    await _box.delete(_cacheKeyFirstPage);
  }

  @override
  Future<List<ItemModel>> getCachedItems() async {
    final stored = _box.get(_cacheKeyFirstPage);
    if (stored == null) return <ItemModel>[];
    final List<dynamic> raw = stored as List<dynamic>;
    final models = raw.whereType<ItemModel>().toList();
    return models;
  }
}