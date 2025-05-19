class Location {
  final double latitude;
  final double longitude;
  final String? address;

  Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}

class FoodTruckBranding {
  final String? logoUrl;
  final String? coverImageUrl;
  final String? primaryColor; // Hex color code
  final String? secondaryColor; // Hex color code
  final String? fontFamily;
  final String? slogan;

  FoodTruckBranding({
    this.logoUrl,
    this.coverImageUrl,
    this.primaryColor,
    this.secondaryColor,
    this.fontFamily,
    this.slogan,
  });

  factory FoodTruckBranding.fromJson(Map<String, dynamic> json) {
    return FoodTruckBranding(
      logoUrl: json['logoUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      primaryColor: json['primaryColor'] as String?,
      secondaryColor: json['secondaryColor'] as String?,
      fontFamily: json['fontFamily'] as String?,
      slogan: json['slogan'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logoUrl': logoUrl,
      'coverImageUrl': coverImageUrl,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'fontFamily': fontFamily,
      'slogan': slogan,
    };
  }
}

class FoodTruck {
  final String id;
  final String name;
  final String description;
  final FoodTruckBranding branding;
  final List<String> categories;
  final Location currentLocation;
  final bool isOpen;
  final double rating;
  final int reviewCount;
  final List<String> menuIds;
  final Map<String, String> operatingHours; // e.g., {"Monday": "9:00-17:00"}

  FoodTruck({
    required this.id,
    required this.name,
    required this.description,
    required this.branding,
    required this.categories,
    required this.currentLocation,
    required this.isOpen,
    required this.rating,
    required this.reviewCount,
    required this.menuIds,
    required this.operatingHours,
  });

  factory FoodTruck.fromJson(Map<String, dynamic> json) {
    return FoodTruck(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      branding:
          FoodTruckBranding.fromJson(json['branding'] as Map<String, dynamic>),
      categories: List<String>.from(json['categories']),
      currentLocation:
          Location.fromJson(json['currentLocation'] as Map<String, dynamic>),
      isOpen: json['isOpen'] as bool,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      menuIds: List<String>.from(json['menuIds']),
      operatingHours: Map<String, String>.from(json['operatingHours']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'branding': branding.toJson(),
      'categories': categories,
      'currentLocation': currentLocation.toJson(),
      'isOpen': isOpen,
      'rating': rating,
      'reviewCount': reviewCount,
      'menuIds': menuIds,
      'operatingHours': operatingHours,
    };
  }
}
