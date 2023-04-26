class Cart {
  late final String? productId;
  late final String? productName;
  late final String? unitTag;
  late final String? image;
  late final int? id;
  late final int? initialPrice;
  late final int? productPrice;
  late final int? quantity;

  Cart({
    required this.productId,
    required this.productName,
    required this.unitTag,
    required this.image,
    required this.id,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
  });
  Cart.fromMap(Map<dynamic, dynamic> res)
      : productId = res['productId'],
        productName = res['productName'],
        unitTag = res['unitTag'],
        image = res['image'],
        id = res['id'],
        initialPrice = res['initialPrice'],
        productPrice = res['productPrice'],
        quantity = res['quantity'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'unitTag': unitTag,
      'image': image,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity
    };
  }
}
