import 'package:flutter/material.dart';
import '../models/food_truck.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from backend
    final foodTruck = FoodTruck(
      id: '1',
      name: 'Tasty Bites',
      description: 'Serving delicious street food since 2020',
      branding: FoodTruckBranding(
        logoUrl: 'https://picsum.photos/200',
        coverImageUrl: 'https://picsum.photos/800/400',
        primaryColor: '#FF5722',
        secondaryColor: '#FFA726',
        slogan: 'Taste the Street!',
      ),
      categories: ['Burgers', 'Tacos', 'Fries'],
      currentLocation: Location(
        latitude: 37.7749,
        longitude: -122.4194,
        address: '123 Food Street, San Francisco, CA',
      ),
      isOpen: true,
      rating: 4.5,
      reviewCount: 128,
      menuIds: ['1', '2', '3'],
      operatingHours: {
        'Monday': '9:00-17:00',
        'Tuesday': '9:00-17:00',
        'Wednesday': '9:00-17:00',
        'Thursday': '9:00-17:00',
        'Friday': '9:00-20:00',
        'Saturday': '10:00-20:00',
        'Sunday': 'Closed',
      },
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(foodTruck.name),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Image.network(
                  foodTruck.branding.coverImageUrl ??
                      'https://picsum.photos/800/400',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodTruck.branding.slogan ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Location',
                    foodTruck.currentLocation.address ?? 'No address available',
                    Icons.location_on,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoCard(
                    context,
                    'Status',
                    foodTruck.isOpen ? 'Open' : 'Closed',
                    Icons.circle,
                    color: foodTruck.isOpen ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 8),
                  _buildInfoCard(
                    context,
                    'Rating',
                    '${foodTruck.rating} (${foodTruck.reviewCount} reviews)',
                    Icons.star,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Today\'s Hours',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  _buildHoursCard(context, foodTruck),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildHoursCard(BuildContext context, FoodTruck foodTruck) {
    final now = DateTime.now();
    final today = now.weekday.toString().toLowerCase();
    final hours = foodTruck.operatingHours[today] ?? 'Closed';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today: $hours',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Full Schedule:'),
            const SizedBox(height: 4),
            ...foodTruck.operatingHours.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text(entry.value),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
