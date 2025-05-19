import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

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
  final String primaryColor;
  final String secondaryColor;
  final String? fontFamily;
  final String? slogan;

  FoodTruckBranding({
    this.logoUrl,
    this.coverImageUrl,
    required this.primaryColor,
    required this.secondaryColor,
    this.fontFamily,
    this.slogan,
  });

  factory FoodTruckBranding.fromJson(Map<String, dynamic> json) {
    return FoodTruckBranding(
      logoUrl: json['logoUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      primaryColor: json['primaryColor'] as String,
      secondaryColor: json['secondaryColor'] as String,
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
  final String vendorId;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> categories;
  final bool isActive;
  final List<Schedule> schedules;
  final double latitude;
  final double longitude;
  final double serviceRadius;
  final List<String> acceptedPaymentMethods;
  final Map<String, double> deliveryFees;
  final FoodTruckBranding? branding;
  final Map<int, String> operatingHours;

  FoodTruck({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.categories,
    this.isActive = true,
    this.schedules = const [],
    required this.latitude,
    required this.longitude,
    this.serviceRadius = 5.0,
    this.acceptedPaymentMethods = const ['cash', 'card'],
    this.deliveryFees = const {},
    this.branding,
    this.operatingHours = const {},
  });

  bool isCurrentlyOpen() {
    final now = DateTime.now();
    final currentDay = now.weekday;
    final currentTime = TimeOfDay.fromDateTime(now);

    return schedules.any((schedule) {
      if (schedule.dayOfWeek != currentDay) return false;
      return currentTime.hour >= schedule.startTime.hour &&
          currentTime.hour <= schedule.endTime.hour;
    });
  }

  bool isWithinServiceArea(double userLat, double userLng) {
    // Simple distance calculation using the Haversine formula
    const double earthRadius = 6371; // km
    final double lat1 = latitude * (pi / 180);
    final double lat2 = userLat * (pi / 180);
    final double dLat = (userLat - latitude) * (pi / 180);
    final double dLng = (userLng - longitude) * (pi / 180);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLng / 2) * sin(dLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;

    return distance <= serviceRadius;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'categories': categories,
      'isActive': isActive,
      'schedules': schedules.map((s) => s.toJson()).toList(),
      'latitude': latitude,
      'longitude': longitude,
      'serviceRadius': serviceRadius,
      'acceptedPaymentMethods': acceptedPaymentMethods,
      'deliveryFees': deliveryFees,
      'branding': branding?.toJson(),
      'operatingHours': operatingHours,
    };
  }

  factory FoodTruck.fromJson(Map<String, dynamic> json) {
    return FoodTruck(
      id: json['id'],
      vendorId: json['vendorId'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      categories: List<String>.from(json['categories']),
      isActive: json['isActive'] ?? true,
      schedules: (json['schedules'] as List?)
              ?.map((s) => Schedule.fromJson(s))
              .toList() ??
          [],
      latitude: json['latitude'],
      longitude: json['longitude'],
      serviceRadius: json['serviceRadius'] ?? 5.0,
      acceptedPaymentMethods:
          List<String>.from(json['acceptedPaymentMethods'] ?? ['cash', 'card']),
      deliveryFees: Map<String, double>.from(json['deliveryFees'] ?? {}),
      branding: json['branding'] != null
          ? FoodTruckBranding.fromJson(json['branding'])
          : null,
      operatingHours: Map<int, String>.from(json['operatingHours'] ?? {}),
    );
  }
}

class Schedule {
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? location;
  final String? notes;

  Schedule({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.location,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'location': location,
      'notes': notes,
    };
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final startParts = (json['startTime'] as String).split(':');
    final endParts = (json['endTime'] as String).split(':');

    return Schedule(
      dayOfWeek: json['dayOfWeek'],
      startTime: TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      ),
      location: json['location'],
      notes: json['notes'],
    );
  }
}
