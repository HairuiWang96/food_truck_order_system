import 'package:flutter/material.dart';
import '../../models/menu_item.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  // TODO: Replace with actual data from backend
  final List<MenuItem> _menuItems = [
    MenuItem(
      id: '1',
      name: 'Classic Burger',
      description: 'Juicy beef patty with lettuce, tomato, and special sauce',
      price: 8.99,
      imageUrl: 'https://picsum.photos/400/300?food=1',
      categories: ['Burgers', 'Popular'],
      isAvailable: true,
      customizationOptions: [
        CustomizationOption(
          name: 'Doneness',
          options: ['Medium', 'Well Done'],
          required: true,
        ),
        CustomizationOption(
          name: 'Extras',
          options: ['Cheese', 'Bacon', 'Avocado'],
          required: false,
        ),
      ],
    ),
    MenuItem(
      id: '2',
      name: 'Chicken Tacos',
      description: 'Grilled chicken with fresh vegetables and salsa',
      price: 7.99,
      imageUrl: 'https://picsum.photos/400/300?food=2',
      categories: ['Tacos', 'Popular'],
      isAvailable: true,
      customizationOptions: [
        CustomizationOption(
          name: 'Spice Level',
          options: ['Mild', 'Medium', 'Hot'],
          required: true,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Show sorting options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoriesFilter(),
          Expanded(
            child: ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return _buildMenuItemCard(item);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add/edit menu item screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    // Get unique categories from all menu items
    final categories =
        _menuItems.expand((item) => item.categories).toSet().toList();

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(categories[index]),
              onSelected: (selected) {
                // TODO: Implement category filtering
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItemCard(MenuItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                item.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant, size: 50),
                  );
                },
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: item.isAvailable ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.isAvailable ? 'Available' : 'Unavailable',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: item.categories.map((category) {
                    return Chip(
                      label: Text(category),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // TODO: Navigate to edit menu item
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          // TODO: Update availability in backend
                          item.isAvailable = !item.isAvailable;
                        });
                      },
                      icon: Icon(
                        item.isAvailable
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      label: Text(
                        item.isAvailable
                            ? 'Make Unavailable'
                            : 'Make Available',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
