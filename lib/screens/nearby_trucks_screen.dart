import 'package:flutter/material.dart';
import '../models/food_truck.dart';

class NearbyTrucksScreen extends StatefulWidget {
  const NearbyTrucksScreen({super.key});

  @override
  State<NearbyTrucksScreen> createState() => _NearbyTrucksScreenState();
}

class _NearbyTrucksScreenState extends State<NearbyTrucksScreen> {
  List<FoodTruck> _nearbyTrucks = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNearbyTrucks();
  }

  Future<void> _loadNearbyTrucks() async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(
          const Duration(seconds: 1)); // Simulate network delay
      setState(() {
        _nearbyTrucks = [
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
          ),
        ];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load nearby trucks';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Food Trucks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadNearbyTrucks,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_nearbyTrucks.isEmpty) {
      return const Center(
        child: Text('No food trucks found nearby'),
      );
    }

    return ListView.builder(
      itemCount: _nearbyTrucks.length,
      itemBuilder: (context, index) {
        final truck = _nearbyTrucks[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(truck.imageUrl),
            ),
            title: Text(truck.name),
            subtitle: Text(truck.description),
            trailing: Text(
              '${truck.latitude.toStringAsFixed(2)}, ${truck.longitude.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () {
              // TODO: Navigate to truck details
            },
          ),
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // TODO: Add filter options
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        );
      },
    );
  }
}
