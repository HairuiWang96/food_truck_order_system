class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> categories;
  bool isAvailable;
  final List<CustomizationOption> customizationOptions;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categories,
    this.isAvailable = true,
    this.customizationOptions = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categories': categories,
      'isAvailable': isAvailable,
      'customizationOptions':
          customizationOptions.map((o) => o.toJson()).toList(),
    };
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
      categories: List<String>.from(json['categories'] as List),
      isAvailable: json['isAvailable'] as bool,
      customizationOptions: (json['customizationOptions'] as List)
          .map((o) => CustomizationOption.fromJson(o as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CustomizationOption {
  final String name;
  final List<String> options;
  final bool required;

  CustomizationOption({
    required this.name,
    required this.options,
    this.required = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'options': options,
      'required': required,
    };
  }

  factory CustomizationOption.fromJson(Map<String, dynamic> json) {
    return CustomizationOption(
      name: json['name'] as String,
      options: List<String>.from(json['options'] as List),
      required: json['required'] as bool,
    );
  }
}
