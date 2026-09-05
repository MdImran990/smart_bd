import 'package:flutter/material.dart';

import '../models/nearby_place_model.dart';

class LocalNearbyData {
  LocalNearbyData._();

  static const List<NearbyPlaceModel> places = [
    NearbyPlaceModel(
      id: '1',
      name: 'Square Hospital',
      category: 'Hospital',
      address: 'Panthapath, Dhaka',
      rating: '4.8',
      distance: '1.2 km',
      icon: Icons.local_hospital_outlined,
      isOpen: true,
    ),
    NearbyPlaceModel(
      id: '2',
      name: 'Popular Diagnostic Center',
      category: 'Hospital',
      address: 'Dhanmondi, Dhaka',
      rating: '4.6',
      distance: '2.1 km',
      icon: Icons.local_hospital_outlined,
      isOpen: true,
    ),
    NearbyPlaceModel(
      id: '3',
      name: 'Lazz Pharma',
      category: 'Pharmacy',
      address: 'Mirpur, Dhaka',
      rating: '4.5',
      distance: '1.5 km',
      icon: Icons.local_pharmacy_outlined,
      isOpen: true,
    ),
    NearbyPlaceModel(
      id: '4',
      name: 'Dutch-Bangla ATM',
      category: 'ATM',
      address: 'Uttara, Dhaka',
      rating: '4.4',
      distance: '2.8 km',
      icon: Icons.atm_outlined,
      isOpen: true,
    ),
    NearbyPlaceModel(
      id: '5',
      name: 'Dhanmondi Police Station',
      category: 'Police',
      address: 'Dhanmondi, Dhaka',
      rating: '4.7',
      distance: '3.2 km',
      icon: Icons.local_police_outlined,
      isOpen: true,
    ),
    NearbyPlaceModel(
      id: '6',
      name: 'Fire Service Station',
      category: 'Emergency',
      address: 'Mohammadpur, Dhaka',
      rating: '4.9',
      distance: '4.0 km',
      icon: Icons.fire_truck_outlined,
      isOpen: true,
    ),
    NearbyPlaceModel(
      id: '7',
      name: 'Ibn Sina Hospital',
      category: 'Hospital',
      address: 'Dhanmondi, Dhaka',
      rating: '4.7',
      distance: '2.5 km',
      icon: Icons.local_hospital_outlined,
      isOpen: true,
    ),
    NearbyPlaceModel(
      id: '8',
      name: 'Brac Bank ATM',
      category: 'ATM',
      address: 'Gulshan, Dhaka',
      rating: '4.3',
      distance: '3.0 km',
      icon: Icons.atm_outlined,
      isOpen: false,
    ),
  ];
}