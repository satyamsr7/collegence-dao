import 'package:hive/hive.dart';
part 'address.g.dart';

@HiveType(typeId: 1)
class Address {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String address;

  Address({
    required this.name,
    required this.address,
  });
}
