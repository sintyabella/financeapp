import 'package:flutter/material.dart';
import '../widgets/grid_menu_item.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';
import '../widgets/atm_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  final List<TransactionModel> transactions = [
    TransactionModel('Doctor Visit', '-Rp120.000', 'Health'),
    TransactionModel('Hospital Checkup', '-Rp220.000', 'Health'),
    TransactionModel('Vacation Ticket', '-Rp450.000', 'Travel'),
    TransactionModel('Flight to Yogyakarta', '-Rp500.000', 'Travel'),
    TransactionModel('Dinner', '-Rp30.000', 'Food'),
    TransactionModel('Breakfast at Cafe', '-Rp65.000', 'Food'),
    TransactionModel('Concert', '-Rp150.000', 'Event'),
    TransactionModel('wedding Gift', '-Rp300.000', 'Event'),
    TransactionModel('Salary', '+Rp7.000.000', 'Income'),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = selectedCategory == 'All'
        ? transactions
        : transactions.where((t) => t.category == selectedCategory).toList();

    const burgundy = Color(0xFF800020);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: burgundy,
        elevation: 0,
        title: const Text(
          'Finance Mate',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const Text(
              'My Cards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  AtmCard(
                    bankName: 'Bank BCA',
                    cardNumber: '**** 2907',
                    balance: 'Rp15.500.000',
                    color1: Color.fromARGB(255, 255, 187, 182),
                    color2: Color.fromARGB(255, 255, 231, 200),
                  ),
                  AtmCard(
                    bankName: 'Bank Mandiri',
                    cardNumber: '**** 2004',
                    balance: 'Rp5.750.000',
                    color1: Color.fromARGB(255, 206, 122, 116),
                    color2: Color.fromARGB(255, 255, 222, 180),
                  ),
                  AtmCard(
                    bankName: 'Bank BRI',
                    cardNumber: '**** 0212',
                    balance: 'Rp1.300.000',
                    color1: Color.fromARGB(255, 255, 187, 182),
                    color2:Color.fromARGB(255, 255, 231, 200)
                  ),
                  AtmCard(
                    bankName: 'Bank BNI',
                    cardNumber: '**** 2023',
                    balance: 'Rp10.000.000',
                    color1: Color.fromARGB(255, 206, 122, 116),
                    color2: Color.fromARGB(255, 255, 222, 180),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 6.0,
              children: [
                _buildSmallCategory(
                  icon: Icons.health_and_safety,
                  label: 'Health',
                  onTap: () => setState(() => selectedCategory = 'Health'),
                ),
                _buildSmallCategory(
                  icon: Icons.travel_explore,
                  label: 'Travel',
                  onTap: () => setState(() => selectedCategory = 'Travel'),
                ),
                _buildSmallCategory(
                  icon: Icons.fastfood,
                  label: 'Food',
                  onTap: () => setState(() => selectedCategory = 'Food'),
                ),
                _buildSmallCategory(
                  icon: Icons.event,
                  label: 'Event',
                  onTap: () => setState(() => selectedCategory = 'Event'),
                ),
              ],
            ),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategory == 'All'
                      ? 'Recent Transactions'
                      : 'Transactions - $selectedCategory',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => setState(() => selectedCategory = 'All'),
                  child: const Text(
                    'View All',
                    style: TextStyle(color: burgundy),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final tx = filteredTransactions[index];
                return TransactionItem(transaction: tx);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: burgundy,
        onPressed: () => setState(() => selectedCategory = 'All'),
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  
  Widget _buildSmallCategory({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    const burgundy = Color(0xFF800020);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: burgundy,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22), 
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
