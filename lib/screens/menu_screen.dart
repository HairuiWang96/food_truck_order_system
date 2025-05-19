import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from backend
    final menuItems = [
      MenuItem(
        id: '1',
        name: 'Classic Burger',
        description: 'Juicy beef patty with lettuce, tomato, and special sauce',
        price: 8.99,
        imageUrl: 'https://picsum.photos/400/300?food=1',
        categories: ['Burgers', 'Popular'],
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
        customizationOptions: [
          CustomizationOption(
            name: 'Spice Level',
            options: ['Mild', 'Medium', 'Hot'],
            required: true,
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
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
              // TODO: Show filter options
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _buildMenuItemCard(context, item);
        },
      ),
    );
  }

  Widget _buildMenuItemCard(BuildContext context, MenuItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                if (item.customizationOptions.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Customization Options',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ...item.customizationOptions.map((option) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${option.name}${option.required ? ' *' : ''}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            children: option.options.map((opt) {
                              return ChoiceChip(
                                label: Text(opt),
                                selected: false,
                                onSelected: (selected) {
                                  // TODO: Handle option selection
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: item.isAvailable
                        ? () {
                            // TODO: Add to cart
                          }
                        : null,
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
