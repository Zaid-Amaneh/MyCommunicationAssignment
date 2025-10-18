import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;

  const ItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [id, title, description, dateTime];
}