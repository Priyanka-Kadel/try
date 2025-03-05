import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String name;
  final String? image;
  final String quantity;
  final String price;

  const ProductEntity({
    required this.productId,
    this.image,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [productId, image, name, quantity, price];
}
