import 'package:flutter/material.dart';
import '../models/order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from backend
    final orders = [
      Order(
        id: '1',
        userId: 'user1',
        foodTruckId: 'truck1',
        items: [
          OrderItem(
            menuItemId: '1',
            name: 'Classic Burger',
            quantity: 2,
            price: 8.99,
            customizations: {
              'Doneness': 'Medium',
              'Extras': 'Cheese',
            },
          ),
        ],
        totalAmount: 17.98,
        status: OrderStatus.preparing,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Order(
        id: '2',
        userId: 'user2',
        foodTruckId: 'truck1',
        items: [
          OrderItem(
            menuItemId: '2',
            name: 'Chicken Tacos',
            quantity: 1,
            price: 7.99,
            customizations: {
              'Spice Level': 'Hot',
            },
          ),
        ],
        totalAmount: 7.99,
        status: OrderStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Past'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrdersList(
              context,
              orders
                  .where((order) =>
                      order.status == OrderStatus.pending ||
                      order.status == OrderStatus.preparing ||
                      order.status == OrderStatus.ready)
                  .toList(),
            ),
            _buildOrdersList(
              context,
              orders
                  .where((order) => order.status == OrderStatus.completed)
                  .toList(),
            ),
            _buildOrdersList(
              context,
              orders
                  .where((order) => order.status == OrderStatus.cancelled)
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No orders found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(context, order);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.id}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Placed ${_formatTimeAgo(order.createdAt)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Text(
                  '\$${order.totalAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Items',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                ...order.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${item.quantity}x ${item.name}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Text(
                                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          if (item.customizations != null &&
                              item.customizations!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              children:
                                  item.customizations!.entries.map((entry) {
                                return Chip(
                                  label: Text('${entry.key}: ${entry.value}'),
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    )),
                if (order.specialInstructions != null) ...[
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    'Special Instructions',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.specialInstructions!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (order.status == OrderStatus.pending)
                      TextButton.icon(
                        onPressed: () {
                          // TODO: Cancel order
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                      ),
                    if (order.status == OrderStatus.ready)
                      TextButton.icon(
                        onPressed: () {
                          // TODO: Mark as picked up
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Mark as Picked Up'),
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

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
