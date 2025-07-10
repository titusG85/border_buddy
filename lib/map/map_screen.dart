import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_screen_controller.dart';
import '../utils/app_localizations.dart'; // Import localization helper

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};
  final PortNodeService _portNodeService = PortNodeService();

  @override
  void initState() {
    super.initState();
    _fetchPortNodes();
  }

  Future<void> _fetchPortNodes() async {
    final markers = await _portNodeService.fetchPortMarkers(context);
    setState(() {
      _markers.addAll(markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('ports_of_entry_map'), // Use localized key
          style: const TextStyle(fontFamily: 'Gravitas'),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(31.761877, -106.485023),
                zoom: 12,
              ),
              markers: _markers,
              liteModeEnabled: false,
            ),
          ),
        ],
      ),
    );
  }
}