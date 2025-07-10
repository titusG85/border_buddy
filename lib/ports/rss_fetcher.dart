// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'port_node.dart';
import 'constants.dart';

class RssFetcher{
  static const String rssUrl = 'https://bwt.cbp.gov/api/bwtRss/HTML/-1/23,24,61,25/-1';

  Future<List<PortNode>> fetchPortNodes() async {
  final response = await http.get(Uri.parse(rssUrl));

  if (response.statusCode == 200) {
    final document = XmlDocument.parse(response.body);
    final items = document.findAllElements('item');
    
    print('Number of items found: ${items.length}'); // Debugging print

    final portNodes = items.map((item) {
      try {
        return PortNode.fromXmlElement(item);
      } catch (e) {
        print('Error parsing item: $e');
        return null;
      }
    }).whereType<PortNode>().toList();

    print('Successfully parsed ${portNodes.length} PortNodes');

    for(int i =0; i<portNodes.length; i++){
      portNodes[i].latitude = portCoordinates[portNodes[i].titleKey]?.latitude ?? 0.0;
      portNodes[i].longitude = portCoordinates[portNodes[i].titleKey]?.longitude ?? 0.0;
    }
    return portNodes;
  } else {
    throw Exception('Failed to load RSS feed');
  }
}

// Function to extract the <pubDate> from the RSS feed
  Future<String?> getLastUpdatedTime() async {
    final response = await http.get(Uri.parse(rssUrl));

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);

      // Find the <pubDate> element
      final pubDateElement = document.findAllElements('pubDate').firstOrNull;

      if (pubDateElement != null) {
        final pubDateText = pubDateElement.innerText; // Get the text content of <pubDate>
        try {
          // Parse the pubDate string into a DateTime object
          final dateTime = DateTime.parse(
            pubDateText.replaceFirst(RegExp(r' [A-Z]+$'), ''), // Remove timezone for parsing
          );

          // Subtract 2 hours to convert from EST to MDT
          final mdtDateTime = dateTime.subtract(const Duration(hours: 2));

          // Format the DateTime back into a readable string
          return '${mdtDateTime.toLocal()} MDT';
        } catch (e) {
          print('Error parsing pubDate: $e');
          return pubDateText; // Return the original text if parsing fails
        }
      } else {
        print('No <pubDate> element found in the RSS feed');
        return null;
      }
    } else {
      throw Exception('Failed to load RSS feed');
    }
  }
}
extension XmlElementExtension on Iterable<XmlElement> {
  XmlElement? get firstOrNull => isEmpty ? null : first;
}