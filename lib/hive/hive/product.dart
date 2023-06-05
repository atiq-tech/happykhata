import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class ProductDetails {
  @HiveField(0)
  String? category;

  @HiveField(1)
  final String? productName;

  @HiveField(2)
  int? quantity;

  @HiveField(3)
  double? saleRate;

  @HiveField(4)
  double? totalAmount;

  ProductDetails({
    required this.productName,
    required this.category,
    required this.quantity,
    required this.saleRate,
    required this.totalAmount,
  });
}
