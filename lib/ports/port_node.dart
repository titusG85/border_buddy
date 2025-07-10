// ignore_for_file: avoid_print

import 'package:xml/xml.dart';

class PortNode {
  final String titleKey; // Use a key for localization instead of a raw title
  final String hours;
  final String date;
  final String maxLanes;
  final String generalLanes;
  final String sentriLanes;
  final String readyLanes;
  final String borderNotice;
  double _latitude = 0.0;
  double _longitude = 0.0;

  PortNode({
    required this.titleKey, // Updated field name
    required this.hours,
    required this.date,
    required this.maxLanes,
    required this.generalLanes,
    required this.sentriLanes,
    required this.readyLanes,
    required this.borderNotice,
    required double latitude,
    required double longitude,
  })  : _latitude = latitude,
        _longitude = longitude;

  factory PortNode.fromXmlElement(XmlElement element) {
    // Map raw titles to localization keys
    final rawTitle = element.findElements('title').single.innerText.trim();
    final titleKey = _mapTitleToKey(rawTitle); // Map the raw title to a localization key

    final descriptionXml = element.findElements('description').single.innerXml;
    final parsedDesc = _parseDescription(descriptionXml);

    return PortNode(
      titleKey: titleKey, // Use the mapped key
      hours: parsedDesc['Hours'] ?? 'N/A',
      date: parsedDesc['Date'] ?? 'N/A',
      maxLanes: parsedDesc['Maximum Lanes'] ?? 'N/A',
      generalLanes: parsedDesc['General Lanes'] ?? 'N/A',
      sentriLanes: parsedDesc['Sentri Lanes'] ?? 'N/A',
      readyLanes: parsedDesc['Ready Lanes'] ?? 'N/A',
      borderNotice: parsedDesc['Border Notice'] ?? 'N/A',
      latitude: 0.0,
      longitude: 0.0,
    );
  }

  double get latitude => _latitude;
  double get longitude => _longitude;

  set latitude(double value) {
    _latitude = value;
  }

  set longitude(double value) {
    _longitude = value;
  }

  static Map<String, String> _parseDescription(String descriptionXml) {
    final Map<String, String> extracted = {};
    final lines = descriptionXml.split('<br/>').map((line) => line.trim()).toList();

    for (var line in lines) {
      final match = RegExp(r'^(.*?):\s?(.*)$').firstMatch(line);
      if (match != null) {
        extracted[match.group(1)!.trim()] = match.group(2)!.trim();
      }
    }

    // Handle <b>Border Notice:</b> separately
    final borderMatch = RegExp(r'<b>Border Notice:\s?</b>(.*?)$').firstMatch(descriptionXml);
    if (borderMatch != null) {
      extracted['Border Notice'] = borderMatch.group(1)!.trim();
    }

    return extracted;
  }

  // Map raw titles to localization keys
  static String _mapTitleToKey(String rawTitle) {
    const titleMapping = {
      'El Paso - Bridge of the Americas (BOTA)': 'el_paso_bota',
      'El Paso - Paso Del Norte (PDN)': 'el_paso_pdn',
      'El Paso - Stanton DCL': 'el_paso_stanton',
      'El Paso - Ysleta': 'el_paso_ysleta',
    };

    return titleMapping[rawTitle] ?? rawTitle; // Return the key or the raw title if no match
  }

  // Helper function to extract wait time from the general lanes description
  String getWaitTime(String generalLanes) {
    final regex = RegExp(r'(\d+)\s*min'); // Match "X min" in the string
    final match = regex.firstMatch(generalLanes);
    return match != null ? match.group(1)! : 'N/A'; // Return the wait time or "N/A"
  }
}



