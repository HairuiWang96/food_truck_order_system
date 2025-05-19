class User {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? profileImage;
  final List<String> favoriteFoodTrucks;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.profileImage,
    this.favoriteFoodTrucks = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      favoriteFoodTrucks: List<String>.from(json['favoriteFoodTrucks'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'favoriteFoodTrucks': favoriteFoodTrucks,
    };
  }
}
