import 'package:hive/hive.dart';
import 'item_model.dart';

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 1;

  @override
  ItemModel read(BinaryReader reader) {
    final id = reader.readInt();
    final title = reader.readString();
    final description = reader.readString();
    final dateTimeMillis = reader.readInt();
    return ItemModel(
      id: id,
      title: title,
      description: description,
      dateTime: DateTime.fromMillisecondsSinceEpoch(dateTimeMillis),
    );
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeInt(obj.dateTime.millisecondsSinceEpoch);
  }
}
