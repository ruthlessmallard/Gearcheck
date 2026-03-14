import 'package:flutter/material.dart';
import '../models/ppe_data.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.security, color: Colors.black, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'PPE Reminder',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Text(
              'Select your work area to begin your safety check.',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: ppeCategories.length,
              itemBuilder: (context, index) {
                final category = ppeCategories[index];
                final isLastItem = index == ppeCategories.length - 1;
                return _CategoryCard(
                  category: category,
                  isEndOfShift: isLastItem,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final PpeCategory category;
  final bool isEndOfShift;

  const _CategoryCard({
    required this.category,
    required this.isEndOfShift,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isEndOfShift ? Colors.blueGrey[400]! : Colors.amber;
    final cardColor = isEndOfShift
        ? const Color(0xFF263238)
        : const Color(0xFF2C2C2E);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryScreen(category: category),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(category.icon, color: accentColor, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        category.subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.45),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${category.items.length}',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white24,
                      size: 22,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
