import 'package:assignment/data/item_model_adapter.dart';
import 'package:assignment/data/item_repository_impl.dart';
import 'package:assignment/data/local_data_source.dart';
import 'package:assignment/data/remote_data_source.dart';
import 'package:assignment/presentation/viewmodels/items_cubit.dart';
import 'package:assignment/presentation/views/items_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ItemModelAdapter());

  final localDataSource = await LocalDataSourceImpl.create();


  final remoteDataSource = RemoteDataSourceImpl(client: http.Client());

  final repository = ItemRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  runApp(AssignmentApp(repository: repository));
}

class AssignmentApp extends StatelessWidget {
  final ItemRepositoryImpl repository;
  const AssignmentApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsCubit(itemRepository: repository),
      child: const MaterialApp(home: ItemsPage(),debugShowCheckedModeBanner: false,),
    );
  }
}
