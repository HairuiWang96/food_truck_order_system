import 'food_truck.dart';

class Vendor {
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String profileImage;
  final List<String> foodTruckIds;
  bool isActive;
  final BusinessInfo businessInfo;

  Vendor({
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.profileImage,
    required this.foodTruckIds,
    this.isActive = true,
    required this.businessInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'foodTruckIds': foodTruckIds,
      'isActive': isActive,
      'businessInfo': businessInfo.toJson(),
    };
  }

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImage: json['profileImage'] as String,
      foodTruckIds: List<String>.from(json['foodTruckIds'] as List),
      isActive: json['isActive'] as bool,
      businessInfo:
          BusinessInfo.fromJson(json['businessInfo'] as Map<String, dynamic>),
    );
  }
}

class BusinessInfo {
  final String name;
  final String description;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String cuisine;
  final Map<String, String> openingHours;

  BusinessInfo({
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.cuisine,
    required this.openingHours,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'cuisine': cuisine,
      'openingHours': openingHours,
    };
  }

  factory BusinessInfo.fromJson(Map<String, dynamic> json) {
    return BusinessInfo(
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      cuisine: json['cuisine'] as String,
      openingHours: Map<String, String>.from(json['openingHours'] as Map),
    );
  }
}

class VendorStats {
  final int totalOrders;
  final double totalRevenue;
  final int activeOrders;
  final double averageOrderValue;
  final Map<String, int> ordersByStatus;
  final Map<String, double> revenueByDay;

  VendorStats({
    required this.totalOrders,
    required this.totalRevenue,
    required this.activeOrders,
    required this.averageOrderValue,
    required this.ordersByStatus,
    required this.revenueByDay,
  });

  factory VendorStats.fromJson(Map<String, dynamic> json) {
    return VendorStats(
      totalOrders: json['totalOrders'] as int,
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      activeOrders: json['activeOrders'] as int,
      averageOrderValue: (json['averageOrderValue'] as num).toDouble(),
      ordersByStatus: Map<String, int>.from(json['ordersByStatus']),
      revenueByDay: Map<String, double>.from(json['revenueByDay']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalOrders': totalOrders,
      'totalRevenue': totalRevenue,
      'activeOrders': activeOrders,
      'averageOrderValue': averageOrderValue,
      'ordersByStatus': ordersByStatus,
      'revenueByDay': revenueByDay,
    };
  }
}
