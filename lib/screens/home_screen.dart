import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/food_truck.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration
    final featuredTrucks = [
      FoodTruck(
        id: '1',
        vendorId: 'v1',
        name: 'Taco Truck',
        description: 'Authentic Mexican street food',
        imageUrl: 'https://example.com/taco.jpg',
        categories: ['Mexican', 'Street Food'],
        latitude: 37.7749,
        longitude: -122.4194,
        branding: FoodTruckBranding(
          primaryColor: '#FF5733',
          secondaryColor: '#33FF57',
        ),
        operatingHours: {
          1: '9:00 AM - 5:00 PM',
          2: '9:00 AM - 5:00 PM',
          3: '9:00 AM - 5:00 PM',
          4: '9:00 AM - 5:00 PM',
          5: '9:00 AM - 5:00 PM',
        },
      ),
      FoodTruck(
        id: '2',
        vendorId: 'v2',
        name: 'Burger Bus',
        description: 'Gourmet burgers on wheels',
        imageUrl: 'https://example.com/burger.jpg',
        categories: ['American', 'Burgers'],
        latitude: 37.7833,
        longitude: -122.4167,
        branding: FoodTruckBranding(
          primaryColor: '#3357FF',
          secondaryColor: '#FF33F6',
        ),
        operatingHours: {
          1: '10:00 AM - 6:00 PM',
          2: '10:00 AM - 6:00 PM',
          3: '10:00 AM - 6:00 PM',
          4: '10:00 AM - 6:00 PM',
          5: '10:00 AM - 6:00 PM',
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Truck(s) Order System'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filters
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Featured Food Trucks',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredTrucks.length,
              itemBuilder: (context, index) {
                return _buildFeaturedTruckCard(context, featuredTrucks[index]);
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Operating Hours',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ...featuredTrucks
              .map((truck) => _buildOperatingHours(context, truck)),
        ],
      ),
    );
  }

  Widget _buildFeaturedTruckCard(BuildContext context, FoodTruck truck) {
    return Card(
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                truck.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant, size: 32),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              truck.name,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              truck.description,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: truck.categories.map((category) {
                return Chip(
                  label: Text(
                    category,
                    style: const TextStyle(fontSize: 10),
                  ),
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperatingHours(BuildContext context, FoodTruck truck) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              truck.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...truck.operatingHours.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        _getDayName(entry.key),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
