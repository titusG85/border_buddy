import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../ports/rss_fetcher.dart';
import '../ports/dialog_util.dart';
import '../utils/app_localizations.dart'; // Import localization helper
import '../utils/text_styles.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class PortNodeService { 
  Future<Set<Marker>> fetchPortMarkers(BuildContext context) async {
    // Get the localization instance before async operations
    final localizations = AppLocalizations.of(context)!;
    
    final rssFetcher = RssFetcher();
    final ports = await rssFetcher.fetchPortNodes();
    final Set<Marker> markers = {};

    for (var port in ports) {
      try {
        // Extract the number of minutes from the generalLanes string
        final regex = RegExp(r'(\d+)\s*min');
        final match = regex.firstMatch(port.generalLanes);
        final waitTime = match != null ? match.group(1) : '0'; // Default to '0' if no match

        // Generate a custom marker icon with the extracted wait time
        final BitmapDescriptor customIcon = await createCustomMarkerIcon(
          '$waitTime', // Use the extracted wait time
        );

        // Fetch the localized title
        final localizedTitle = localizations.translate(port.titleKey);

        markers.add(
          Marker(
            markerId: MarkerId(port.titleKey),
            position: LatLng(port.latitude, port.longitude),
            infoWindow: InfoWindow(
              title: localizedTitle, // Use the localized title
              snippet: '${localizations.translate('wait_time')}: ${port.generalLanes}', // Localized snippet
              onTap: () {
                showPortDetails(context, port); // Pass context explicitly
              },
            ),
            icon: customIcon,
          ),
        );
      } catch (e) {
        print('Error creating marker for ${port.titleKey}: $e');
      }
    }

    return markers;
  }
}

Future<BitmapDescriptor> createCustomMarkerIcon(String waitTime) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  const double markerSize = 50.0;

  // Draw a circle for the marker background
  final Paint paint = Paint()..color = const ui.Color.fromARGB(255, 243, 128, 33);
  canvas.drawCircle(
    const Offset(markerSize / 2, markerSize / 2),
    markerSize / 2,
    paint,
  );

  // Draw the wait time text
  final textPainter = TextPainter(
    text: TextSpan(
      text: waitTime,
      style: AppTextStyles.mapMarkerText.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset(
      (markerSize - textPainter.width) / 2,
      (markerSize - textPainter.height) / 2,
    ),
  );

  // Convert the canvas to an image
  final ui.Image markerAsImage = await pictureRecorder
      .endRecording()
      .toImage(markerSize.toInt(), markerSize.toInt());
  final ByteData? byteData =
      await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List uint8List = byteData!.buffer.asUint8List();

  return BitmapDescriptor.bytes(uint8List);
}