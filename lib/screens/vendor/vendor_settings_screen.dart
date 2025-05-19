import 'package:flutter/material.dart';
import '../../models/vendor.dart';
import '../../models/food_truck.dart';

class VendorSettingsScreen extends StatefulWidget {
  const VendorSettingsScreen({super.key});

  @override
  State<VendorSettingsScreen> createState() => _VendorSettingsScreenState();
}

class _VendorSettingsScreenState extends State<VendorSettingsScreen> {
  // TODO: Replace with actual data from backend
  final _vendor = Vendor(
    id: '1',
    email: 'vendor@example.com',
    name: 'John Doe',
    phoneNumber: '+1234567890',
    profileImage: 'https://picsum.photos/400/400?portrait=1',
    foodTruckIds: ['truck1'],
    isActive: true,
    businessInfo: BusinessInfo(
      name: 'Burger Truck',
      description: 'Serving the best burgers in town',
      address: '123 Food Street',
      city: 'Foodville',
      state: 'CA',
      zipCode: '12345',
      cuisine: 'American',
      openingHours: {
        'Monday': '9:00 AM - 5:00 PM',
        'Tuesday': '9:00 AM - 5:00 PM',
        'Wednesday': '9:00 AM - 5:00 PM',
        'Thursday': '9:00 AM - 5:00 PM',
        'Friday': '9:00 AM - 5:00 PM',
        'Saturday': '10:00 AM - 6:00 PM',
        'Sunday': 'Closed',
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileSection(),
          const SizedBox(height: 24),
          _buildBusinessSection(),
          const SizedBox(height: 24),
          _buildPreferencesSection(),
          const SizedBox(height: 24),
          _buildAccountSection(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_vendor.profileImage),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Name'),
                  subtitle: Text(_vendor.name),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit profile
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(_vendor.email),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit email
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(_vendor.phoneNumber),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit phone
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Business Name'),
                  subtitle: Text(_vendor.businessInfo.name),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit business name
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Description'),
                  subtitle: Text(_vendor.businessInfo.description),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit description
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Address'),
                  subtitle: Text(
                    '${_vendor.businessInfo.address}, ${_vendor.businessInfo.city}, ${_vendor.businessInfo.state} ${_vendor.businessInfo.zipCode}',
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit address
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: const Text('Opening Hours'),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    // TODO: Navigate to edit opening hours
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferences',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Active Status'),
                subtitle: const Text('Accept new orders'),
                value: _vendor.isActive,
                onChanged: (value) {
                  setState(() {
                    // TODO: Update active status in backend
                    _vendor.isActive = value;
                  });
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to notification settings
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Payment Methods'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to payment methods
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Privacy Settings'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to privacy settings
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help & Support'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to help & support
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sign Out'),
                textColor: Colors.red,
                onTap: () {
                  // TODO: Implement sign out
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
