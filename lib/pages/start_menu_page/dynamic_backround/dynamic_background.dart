import 'package:animated_flight_paths/animated_flight_paths.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:touch_dispatch/pages/start_menu_page/dynamic_backround/data/synthwave_colors.dart';

import 'data/flights.dart';

class DynamicBackground extends StatefulWidget {
  const DynamicBackground({super.key});

  @override
  State<DynamicBackground> createState() =>
      _DynamicBackgroundState();
}

class _DynamicBackgroundState extends State<DynamicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(64),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.4, 1],
                colors: [Color(0xff130128), Color(0xff281a45)],
              ),
            ),
            child: ListView(
              children: [
                Center(child: _title),
                const SizedBox(height: 24),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: _animatedFlightPaths,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 24,
            child: Text(
              'v. 0.1 by timtikh',
              style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget get _title => AutoSizeText(
    'TouchDispatch',
    maxLines: 1,
    style: GoogleFonts.montserrat(
      fontSize: 56,
      color: Colors.white70,
    ),
  );

  Widget get _animatedFlightPaths => AnimatedFlightPaths(
    controller: controller,
    debugShowOffsetOnTap: false,
    flightSchedule: FlightSchedule(
      start: DateTime.parse('2025-01-01 00:00:00'),
      end: DateTime.parse('2025-01-01 23:59:00'),
      flights: flights,
    ),
    options: const FlightPathOptions(
      showLabels: true,
      fromEndpointColor: SynthwaveColors.yellow,
      toEndpointColor: SynthwaveColors.yellow,
      flightPathColor: SynthwaveColors.yellow,
      fromEndpointCurve: Curves.easeInOut,
      flightPathCurve: Curves.easeInOutSine,
      toEndpointCurve: Curves.easeInOut,
      flightPathStrokeWidth: 2,
      endpointRadius: 5,
      endpointToLabelSpacing: 12,
      endpointDotAlwaysVisible: false,
      endpointLabelAlwaysVisible: false,
      keepFlightPathsVisible: false,
      curveDepth: 0.5,
      endpointWeight: 0.2,
    ),
    child: const MapSvg(
      map: FlightMap.worldMercatorProjection,
      outlineColor: SynthwaveColors.pink,
      fillColor: SynthwaveColors.black,
    ),
  );
}
