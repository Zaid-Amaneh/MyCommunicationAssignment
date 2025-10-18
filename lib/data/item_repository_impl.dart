import 'package:assignment/data/local_data_source.dart';
import 'package:assignment/data/remote_data_source.dart';
import 'package:assignment/domain/item_entity.dart';
import 'package:assignment/domain/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  ItemRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<ItemEntity>> getItems(int page) async {

    if (page == 1) {
      try {
        final remoteItems = await remoteDataSource.getItems(page);

        await localDataSource.clearCache();
        await localDataSource.cacheItems(remoteItems);

        return remoteItems;
      } catch (_) {
        final localItems = await localDataSource.getCachedItems();
        if (localItems.isNotEmpty) return localItems;

        rethrow; 
      }
    } else {
      return await remoteDataSource.getItems(page);
    }
  }
}