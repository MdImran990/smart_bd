import 'package:flutter/material.dart';

import '../models/nearby_place_model.dart';

class NearbyRepository {
  Future<List<NearbyPlaceModel>> getNearbyPlaces() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      NearbyPlaceModel(
        id: '1',
        name: 'Dhaka Medical College Hospital',
        category: 'Hospital',
        distance: '1.2 km',
        rating: '4.5',
        address: 'Bakshibazar, Dhaka',
        icon: Icons.local_hospital_outlined,
        isOpen: true,
      ),
      NearbyPlaceModel(
        id: '2',
        name: 'Popular Pharmacy',
        category: 'Pharmacy',
        distance: '0.8 km',
        rating: '4.3',
        address: 'Mirpur, Dhaka',
        icon: Icons.local_pharmacy_outlined,
        isOpen: true,
      ),
      NearbyPlaceModel(
        id: '3',
        name: 'Dutch Bangla Bank',
        category: 'Bank',
        distance: '1.5 km',
        rating: '4.1',
        address: 'Dhanmondi, Dhaka',
        icon: Icons.account_balance_outlined,
        isOpen: true,
      ),
      NearbyPlaceModel(
        id: '4',
        name: 'Dhanmondi Police Station',
        category: 'Police',
        distance: '2.0 km',
        rating: '3.9',
        address: 'Dhanmondi, Dhaka',
        icon: Icons.local_police_outlined,
        isOpen: true,
      ),
      NearbyPlaceModel(
        id: '5',
        name: 'Square Hospital',
        category: 'Hospital',
        distance: '2.3 km',
        rating: '4.7',
        address: 'Panthapath, Dhaka',
        icon: Icons.local_hospital_outlined,
        isOpen: true,
      ),
      NearbyPlaceModel(
        id: '6',
        name: 'Apex Pharmacy',
        category: 'Pharmacy',
        distance: '0.5 km',
        rating: '4.0',
        address: 'Gulshan, Dhaka',
        icon: Icons.local_pharmacy_outlined,
        isOpen: false,
      ),
      NearbyPlaceModel(
        id: '7',
        name: 'Fire Service Station',
        category: 'Fire Service',
        distance: '3.1 km',
        rating: '4.2',
        address: 'Tejgaon, Dhaka',
        icon: Icons.fire_truck_outlined,
        isOpen: true,
      ),
      NearbyPlaceModel(
        id: '8',
        name: 'Islami Bank',
        category: 'Bank',
        distance: '1.8 km',
        rating: '4.3',
        address: 'Motijheel, Dhaka',
        icon: Icons.account_balance_outlined,
        isOpen: true,
      ),
    ];
  }
}