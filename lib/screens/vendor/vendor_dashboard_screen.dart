import 'package:flutter/material.dart';
import '../../models/vendor.dart';
import '../../models/order.dart';

class VendorDashboardScreen extends StatelessWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from backend
    final vendorStats = VendorStats(
      totalOrders: 156,
      totalRevenue: 2345.67,
      activeOrders: 3,
      averageOrderValue: 15.04,
      ordersByStatus: {
        'pending': 2,
        'preparing': 1,
        'ready': 0,
      },
      revenueByDay: {
        'Monday': 450.25,
        'Tuesday': 380.50,
        'Wednesday': 420.75,
        'Thursday': 510.00,
        'Friday': 584.17,
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to vendor settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(context, vendorStats),
            const SizedBox(height: 16),
            _buildOrdersOverview(context, vendorStats),
            const SizedBox(height: 16),
            _buildRevenueChart(context, vendorStats),
            const SizedBox(height: 16),
            _buildActiveOrders(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to menu management
        },
        icon: const Icon(Icons.restaurant_menu),
        label: const Text('Manage Menu'),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, VendorStats stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Active Orders',
                    stats.activeOrders.toString(),
                    Icons.receipt_long,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Total Revenue',
                    '\$${stats.totalRevenue.toStringAsFixed(2)}',
                    Icons.attach_money,
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Avg. Order',
                    '\$${stats.averageOrderValue.toStringAsFixed(2)}',
                    Icons.trending_up,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOrdersOverview(BuildContext context, VendorStats stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders by Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...stats.ordersByStatus.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      entry.value.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart(BuildContext context, VendorStats stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Revenue by Day',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...stats.revenueByDay.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '\$${entry.value.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOrders(BuildContext context) {
    // TODO: Replace with actual active orders
    final activeOrders = [
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
          ),
        ],
        totalAmount: 17.98,
        status: OrderStatus.preparing,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Orders',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to all orders
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...activeOrders.map(
              (order) => ListTile(
                title: Text('Order #${order.id}'),
                subtitle: Text(
                  '${order.items.length} items • \$${order.totalAmount.toStringAsFixed(2)}',
                ),
                trailing: Chip(
                  label: Text(
                    order.status.toString().split('.').last.toUpperCase(),
                  ),
                  backgroundColor: _getStatusColor(order.status),
                ),
                onTap: () {
                  // TODO: Navigate to order details
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.preparing:
        return Colors.purple;
      case OrderStatus.ready:
        return Colors.green;
      case OrderStatus.completed:
        return Colors.grey;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }
}
