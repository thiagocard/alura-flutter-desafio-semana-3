import 'package:uuid/uuid.dart';

class Band {
  final String uuid;
  final int categoryId;
  final String name;
  final String image;

  Band(this.uuid, this.categoryId, this.name, this.image);
}