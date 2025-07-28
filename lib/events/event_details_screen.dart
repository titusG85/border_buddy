import 'package:border_buddy/events/event_model.dart';
import 'package:flutter/material.dart';
import '../utils/app_localizations.dart'; // Import localization helper
import '../utils/text_styles.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.title,
          style: AppTextStyles.appBarTitle,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (event.imageUrl.isNotEmpty)
              Image.network(
                event.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            const SizedBox(height: 16),
            Text(
              event.title,
              style: AppTextStyles.responsiveText(context, AppTextStyles.screenTitle),
            ),
            const SizedBox(height: 8),
            Text(
              '${localizations.translate('event_date')}: ${event.date}', // Localized "Date"
              style: AppTextStyles.responsiveText(context, AppTextStyles.bodyText),
            ),
            const SizedBox(height: 8),
            Text(
              '${localizations.translate('event_location')}: ${event.location}', // Localized "Location"
              style: AppTextStyles.responsiveText(context, AppTextStyles.bodyText),
            ),
            const SizedBox(height: 16),
            Text(
              event.description,
              style: AppTextStyles.responsiveText(context, AppTextStyles.bodyText),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
