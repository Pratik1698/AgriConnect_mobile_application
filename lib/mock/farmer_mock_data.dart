import '../models/machinery.dart';
import '../models/professional.dart';

/// Mock data for the Farmer Dashboard.
/// Deliberately isolated from UI code so it can be swapped for a real
/// REST API repository later (Stage 13) without touching any screen.
class FarmerMockData {
  FarmerMockData._();

  static const List<Machinery> nearbyMachinery = [
    Machinery(
      name: 'Mahindra Tractor',
      provider: 'Demo Provider',
      distanceLabel: '8.2 km',
      pricePerDay: 2500,
      isAvailable: true,
    ),
    Machinery(
      name: 'Rotavator',
      provider: 'Demo Provider',
      distanceLabel: '5.4 km',
      pricePerDay: 1800,
      isAvailable: true,
    ),
    Machinery(
      name: 'Harvester',
      provider: 'Demo Provider',
      distanceLabel: '11.2 km',
      pricePerDay: 4500,
      isAvailable: false,
    ),
  ];

  static const List<Professional> nearbyProfessionals = [
    Professional(
      name: 'Omkar Magdum',
      specialization: 'Agronomist',
      distanceLabel: '6.4 km',
      rating: 4.8,
      isAvailable: true,
    ),
    Professional(
      name: 'Shreyash Kashid',
      specialization: 'Organic Farming',
      distanceLabel: '8.1 km',
      rating: 4.7,
      isAvailable: true,
    ),
    Professional(
      name: 'Soil Expert',
      specialization: 'Demo Professional',
      distanceLabel: '10.2 km',
      rating: 4.5,
      isAvailable: false,
    ),
  ];
}
