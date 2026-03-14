import 'package:flutter/material.dart';

class PpeCategory {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> items;

  const PpeCategory({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.items,
  });
}

final List<PpeCategory> ppeCategories = [
  PpeCategory(
    name: 'Surface',
    subtitle: 'Outdoor work area',
    icon: Icons.wb_sunny_rounded,
    color: Colors.amber,
    items: [
      'Hard hat',
      'Safety glasses with side shields',
      'Steel-toed boots',
      'Coveralls or high viz',
      'Gloves',
      'Hearing protection',
      'FLRA card',
    ],
  ),
  PpeCategory(
    name: 'Underground Shop',
    subtitle: 'Shop & maintenance area',
    icon: Icons.build_rounded,
    color: Colors.amber,
    items: [
      'Hard hat',
      'Safety glasses',
      'Steel-toed boots',
      'Coveralls or high viz',
      'Mine belt',
      'Cap lamp',
      'Gloves',
      'Hearing protection',
      'FLRA card',
    ],
  ),
  PpeCategory(
    name: 'Underground Drift',
    subtitle: 'Active drift & production',
    icon: Icons.explore_rounded,
    color: Colors.amber,
    items: [
      'Hard hat',
      'Safety glasses',
      'Muck boots',
      'Coveralls or diggers',
      'Mine belt',
      'Cap lamp',
      'Gloves',
      'Hearing protection',
      'FLRA card',
    ],
  ),
  PpeCategory(
    name: 'Welding',
    subtitle: 'Hot work & welding tasks',
    icon: Icons.local_fire_department_rounded,
    color: Colors.orange,
    items: [
      'Hard hat',
      'Welding hood',
      'Safety glasses with side shields',
      'Face shield',
      'Welding jacket and FR clothing',
      'Welding gloves',
      'Steel-toed safety boots',
      'High-visibility clothing',
      'Hearing protection',
      'Respiratory protection',
      'Welding screens',
      'Hot work permit',
      'FLRA card',
    ],
  ),
  PpeCategory(
    name: 'Travel Home',
    subtitle: 'End of shift checklist',
    icon: Icons.directions_car_rounded,
    color: Colors.blueGrey,
    items: [
      'Secure personal tools',
      'Mine belt stowed',
      'Remove brass',
      'Pre-trip truck',
      'Badge out',
      'Drive safe',
    ],
  ),
];
