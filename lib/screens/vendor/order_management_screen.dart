import 'package:flutter/material.dart';
import '../../models/order.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  // TODO: Replace with actual data from backend
  final List<Order> _orders = [
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
        ),
      ],
      totalAmount: 7.99,
      status: OrderStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Preparing'),
              Tab(text: 'Ready'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrdersList(OrderStatus.pending),
            _buildOrdersList(OrderStatus.preparing),
            _buildOrdersList(OrderStatus.ready),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(OrderStatus status) {
    final filteredOrders =
        _orders.where((order) => order.status == status).toList();

    if (filteredOrders.isEmpty) {
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
              'No ${status.toString().split('.').last.toLowerCase()} orders',
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
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
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
                      child: Row(
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
                    )),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (order.status == OrderStatus.pending)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            // TODO: Update order status in backend
                            order.status = OrderStatus.preparing;
                          });
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Accept'),
                      ),
                    if (order.status == OrderStatus.preparing)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            // TODO: Update order status in backend
                            order.status = OrderStatus.ready;
                          });
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Mark Ready'),
                      ),
                    if (order.status == OrderStatus.ready)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            // TODO: Update order status in backend
                            order.status = OrderStatus.completed;
                          });
                        },
                        icon: const Icon(Icons.done_all),
                        label: const Text('Complete'),
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
