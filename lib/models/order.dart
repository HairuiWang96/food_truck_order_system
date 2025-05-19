enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  completed,
  cancelled,
}

class OrderItem {
  final String menuItemId;
  final String name;
  final int quantity;
  final double price;
  final Map<String, String>? customizations;

  OrderItem({
    required this.menuItemId,
    required this.name,
    required this.quantity,
    required this.price,
    this.customizations,
  });

  Map<String, dynamic> toJson() {
    return {
      'menuItemId': menuItemId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'customizations': customizations,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      menuItemId: json['menuItemId'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as double,
      customizations: json['customizations'] != null
          ? Map<String, String>.from(json['customizations'] as Map)
          : null,
    );
  }
}

class Order {
  final String id;
  final String userId;
  final String foodTruckId;
  final List<OrderItem> items;
  final double totalAmount;
  OrderStatus status;
  final DateTime createdAt;
  DateTime? completedAt;
  final String? specialInstructions;

  Order({
    required this.id,
    required this.userId,
    required this.foodTruckId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.specialInstructions,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foodTruckId': foodTruckId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'specialInstructions': specialInstructions,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      foodTruckId: json['foodTruckId'] as String,
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalAmount: json['totalAmount'] as double,
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      specialInstructions: json['specialInstructions'] as String?,
    );
  }
}
