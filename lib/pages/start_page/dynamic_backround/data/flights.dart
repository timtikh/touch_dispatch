
import 'package:animated_flight_paths/animated_flight_paths.dart';

import 'cities.dart';

final flights = <Flight>[
  Flight(
    from: Cities.paris,
    to: Cities.tokyo,
    departureTime: DateTime.parse('2025-01-01 00:00:00'),
    arrivalTime: DateTime.parse('2025-01-01 14:00:00'),
  ),
  Flight(
    from: Cities.sydney,
    to: Cities.capeTown,
    departureTime: DateTime.parse('2025-01-01 00:00:00'),
    arrivalTime: DateTime.parse('2025-01-01 18:00:00'),
  ),
  Flight(
    from: Cities.buenosAires,
    to: Cities.losAngeles,
    departureTime: DateTime.parse('2025-01-01 06:00:00'),
    arrivalTime: DateTime.parse('2025-01-01 21:00:00'),
  ),
  Flight(
    from: Cities.newYork,
    to: Cities.london,
    departureTime: DateTime.parse('2025-01-01 16:00:00'),
    arrivalTime: DateTime.parse('2025-01-01 23:00:00'),
  ),
  Flight(
    from: Cities.cairo,
    to: Cities.london,
    departureTime: DateTime.parse('2025-01-01 17:00:00'),
    arrivalTime: DateTime.parse('2025-01-01 23:00:00'),
  ),
  Flight(
    from: Cities.bangkok,
    to: Cities.london,
    departureTime: DateTime.parse('2025-01-01 10:00:00'),
    arrivalTime: DateTime.parse('2025-01-01 23:00:00'),
  ),
];
