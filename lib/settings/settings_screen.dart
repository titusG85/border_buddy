import 'package:flutter/material.dart';
import '../utils/app_localizations.dart'; // Import localization helper
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  const SettingsScreen({super.key, required this.onLanguageChange});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Locale _selectedLocale = const Locale('en'); // Default to English
  bool _notificationsEnabled = false; // Track notification preference

  void _changeLanguage(Locale locale) {
    setState(() {
      _selectedLocale = locale; // Update the selected locale in the settings screen
    });
    widget.onLanguageChange(locale); // Notify the parent widget to update the app's locale
  }

  void _updateNotificationPreference(bool enabled) async {
    if (enabled) {
      await FirebaseMessaging.instance.subscribeToTopic('weekly_notifications');
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic('weekly_notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('settings'), // Localized "Settings"
          style: const TextStyle(fontFamily: 'Gravitas'), // Apply "Gravitas" font
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Apply color scheme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.translate('choose_language'), // Localized "Choose Language"
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(localizations.translate('English')), // Localized "English"
              leading: Radio<Locale>(
                value: const Locale('en'),
                groupValue: _selectedLocale,
                onChanged: (Locale? value) {
                  if (value != null) _changeLanguage(value);
                },
              ),
            ),
            ListTile(
              title: Text(localizations.translate('Espanol')), // Localized "Español"
              leading: Radio<Locale>(
                value: const Locale('es'),
                groupValue: _selectedLocale,
                onChanged: (Locale? value) {
                  if (value != null) _changeLanguage(value);
                },
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(localizations.translate('weekly_notifications')), // Localized "Weekly Notifications"
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _updateNotificationPreference(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}