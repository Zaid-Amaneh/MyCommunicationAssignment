import 'dart:math';
import 'package:assignment/data/item_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<ItemModel>> getItems(int page);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client; 

  RemoteDataSourceImpl({required this.client});

  static const int _pageSize = 15;

  @override
  Future<List<ItemModel>> getItems(int page) async {
    // simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate fake data for the requested page
    final random = Random();
    final startId = (page - 1) * _pageSize + 1;

    final List<ItemModel> items = List.generate(_pageSize, (index) {
      final id = startId + index;
      return ItemModel(
        id: id,
        title: 'Item $id',
        description: 'This is a fake description for item $id.',
        dateTime: DateTime.now().subtract(
          Duration(days: random.nextInt(30)),
        ),
      );
    });

    return items;
  }
}
