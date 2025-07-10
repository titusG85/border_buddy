import 'event_model.dart';
import 'package:html/parser.dart' as parse;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; 

abstract class EventFetcher {
  static Future<List<Event>> fetchEvents() async {
    final url = 'https://visitelpaso.com/events';
    final response = await http.get(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to load events: ${response.statusCode}');
    }

    print('Response body: ${response.body}');
    final document = parse.parse(response.body);
    final eventCards = document.querySelectorAll('.event-card');

    if (eventCards.isEmpty) {
      print('No event cards found.');
      return [];
    }

    final events = eventCards.map((card) {
      final titleElement = card.querySelector('.event-card__title a');
      final dateElement = card.querySelector('.event-card__date');
      final locationElement = card.querySelector('.event-card__location');
      final descriptionElement = card.querySelector('.mt-2 p');
      final imageElement = card.querySelector('img');
      final badges = card.querySelectorAll('.badge').map((badge) {
        return badge.text.trim();
      }).toList();

      // Clean and parse the date
      String rawDate = dateElement?.text.trim() ?? 'No Date';
      rawDate = rawDate.replaceAll(RegExp(r'\s+'), ' '); // Remove extra spaces
      String parsedDate = 'Invalid Date';
      try {
        // Adjust the date format to match the actual format in the HTML
        final dateFormat = DateFormat('MMMM d, yyyy'); // Matches "May 8, 2025"
        final parsedDateTime = dateFormat.parse(rawDate);
        parsedDate = DateFormat('yyyy-MM-dd').format(parsedDateTime); // Store in ISO 8601 format
      } catch (e) {
        print('Error parsing date: $e');
      }

      final event = Event(
        id: titleElement?.attributes['href'] ?? '',
        title: titleElement?.text.trim() ?? 'No Title',
        description: descriptionElement?.text.trim() ?? 'No Description',
        date: parsedDate, // Use the parsed date
        location: locationElement?.text.trim() ?? 'No Location',
        imageUrl: imageElement?.attributes['src'] ?? '',
        badges: badges,
      );

      return event;
    }).toList();

    return events;
  }
}
