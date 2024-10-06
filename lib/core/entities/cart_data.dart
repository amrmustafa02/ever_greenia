import 'package:plants_app/core/entities/cart_product_data.dart';

class CartData {
  num totalPrice;
  num deliveryFees;
  num quantity;
  List<CartProductData> products;

  CartData({
    required this.totalPrice,
    required this.quantity,
    required this.products,
    required this.deliveryFees,
  });
}
