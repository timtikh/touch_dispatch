
import 'dart:ui';

import 'package:animated_flight_paths/animated_flight_paths.dart';

import '../widgets/label.dart';

abstract class Cities {
  static final bangkok = FlightEndpoint(
    offset: const Offset(75, 65),
    label: const Label(text: 'Bangkok'),
  );

  static final buenosAires = FlightEndpoint(
    offset: const Offset(32, 87),
    label: const Label(text: 'Buenos Aires'),
  );

  static final cairo = FlightEndpoint(
    offset: const Offset(56, 58),
    label: const Label(text: 'Cairo'),
  );

  static final capeTown = FlightEndpoint(
    offset: const Offset(53.5, 86),
    label: const Label(text: 'Cape Town'),
  );

  static final losAngeles = FlightEndpoint(
    offset: const Offset(16, 54),
    label: const Label(text: 'Los Angeles'),
  );

  static final london = FlightEndpoint(
    offset: const Offset(48, 45),
    label: const Label(text: 'London'),
  );

  static final newYork = FlightEndpoint(
    offset: const Offset(28, 51),
    label: const Label(text: 'New York'),
  );

  static final paris = FlightEndpoint(
    offset: const Offset(49, 48),
    label: const Label(text: 'Paris'),
  );

  static final sydney = FlightEndpoint(
    offset: const Offset(89, 87),
    label: const Label(text: 'Sydney'),
  );

  static final tokyo = FlightEndpoint(
    offset: const Offset(86, 54),
    label: const Label(text: 'Tokyo'),
  );
}
