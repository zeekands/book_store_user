import 'package:uuid/uuid.dart';

class Cart {
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String image;
  final String type;
  Cart({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.type,
    this.image = "",
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['image'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'image': image,
      'type': type,
    };
  }
}

class Carts {
  final uuid = const Uuid();
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cart) => total += cart.price * cart.quantity);
    return total;
  }

  void addItem(String productId, String title, int price, String image, int qty,
      String type) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (old) => Cart(
          id: old.id,
          title: old.title,
          price: old.price,
          quantity: old.quantity + qty,
          image: old.image,
          type: old.type,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => Cart(
          id: productId,
          title: title,
          price: price,
          quantity: qty,
          image: image,
          type: type,
        ),
      );
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (old) => Cart(
                id: old.id,
                title: old.title,
                price: old.price,
                quantity: old.quantity - 1,
                type: old.type,
              ));
    } else {
      _items.remove(productId);
    }
  }

  void clear() {
    _items = {};
  }
}
