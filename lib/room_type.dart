import 'package:flutter/material.dart';

enum RoomPreference {single, double,family}

class RoomType {
  RoomType({
    required this.preference,
    required this.name,
    required this.icon,
    required this.description,
    this.isExpanded = false,
  });
  final RoomPreference preference;
  final String name;
  final IconData icon;
  final String description;
  bool isExpanded;
}
List<RoomType> buildRooms(RoomPreference preferred) {
  return [
    RoomType(
      preference: RoomPreference.single,
      name: 'Single Room',
      icon: Icons.single_bed,
      description: 'One guest, one single bed, garden view. RM 120 per night.',
      isExpanded: preferred == RoomPreference.single,
    ),
    RoomType(
      preference: RoomPreference.double,
      name: 'Double Room',
      icon: Icons.bed,
      description: 'Two guests, one double bed. RM 180 per night.',
      isExpanded: preferred == RoomPreference.double,
    ),
    RoomType(
      preference: RoomPreference.family,
      name: 'Family Room',
      icon: Icons.family_restroom,
      description: 'Four guests, two beds, living area. RM 260 per night.',
      isExpanded: preferred == RoomPreference.family,
    ),
  ];
}