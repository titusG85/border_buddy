import 'package:add_2_calendar/add_2_calendar.dart' as add2calendar;
import 'package:border_buddy/events/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../events/event_fetcher.dart';
import '../events/event_model.dart';
import '../utils/app_localizations.dart';
import '../utils/text_styles.dart'; 

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late Future<List<Event>> _events = Future.value([]); // Initialize with an empty Future
  String _selectedBadge = '';
  List<String> _availableBadges = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() async {
    final events = await EventFetcher.fetchEvents();
    setState(() {
      _events = Future.value(events);
      _availableBadges = events
          .expand((event) => event.badges)
          .toSet()
          .toList(); // Extract unique badges
    });
  }

  void _filterEventsByBadge(String badge) {
    setState(() {
      _selectedBadge = badge;
    });
  }

  void _addToCalendar(Event event) {
    try {
      // Parse the start and end dates from the ISO 8601 format (yyyy-MM-dd)
      final dateRange = event.date.split(' - ');
      final startDate = DateFormat('yyyy-MM-dd').parse(dateRange[0].trim());
      final endDate = dateRange.length > 1
          ? DateFormat('yyyy-MM-dd').parse(dateRange[1].trim())
          : startDate.add(const Duration(hours: 2)); // Default to 2-hour event if no end date

      final calendarEvent = add2calendar.Event(
        title: event.title,
        description: event.description,
        location: event.location,
        startDate: startDate,
        endDate: endDate,
      );

      add2calendar.Add2Calendar.addEvent2Cal(calendarEvent);
    } catch (e) {
      debugPrint('Error parsing date: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.translate('failed_to_add_event'))), // Localized error message
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('events'), style: AppTextStyles.appBarTitle), // Localized "Events"
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedBadge,
              onChanged: (value) {
                _filterEventsByBadge(value!);
              },
              items: [
                DropdownMenuItem(
                  value: '',
                  child: Text(localizations.translate('all_categories')), // Localized "All Categories"
                ),
                ..._availableBadges.map((badge) {
                  return DropdownMenuItem(
                    value: badge,
                    child: Text(badge),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Event>>(
              future: _events,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${localizations.translate('error')}: ${snapshot.error}')); // Localized error
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(localizations.translate('no_events_found'))); // Localized "No events found"
                } else {
                  final events = snapshot.data!;
                  final filteredEvents = _selectedBadge.isEmpty
                      ? events
                      : events.where((event) => event.badges.contains(_selectedBadge)).toList();

                  return ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return ListTile(
                        leading: event.imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  event.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image, size: 50);
                                  },
                                ),
                              )
                            : const Icon(Icons.image, size: 50),
                        title: Text(
                          event.title,
                          style: AppTextStyles.responsiveText(context, AppTextStyles.cardTitle),
                        ),
                        subtitle: Text(
                          '${localizations.translate('event_date')}: ${event.date}\n${localizations.translate('event_location')}: ${event.location}', // Localized "Date" and "Location"
                          style: AppTextStyles.responsiveText(context, AppTextStyles.cardSubtitle),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _addToCalendar(event),
                          tooltip: localizations.translate('add_to_calendar'), // Localized "Add to Calendar"
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsScreen(event: event),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
