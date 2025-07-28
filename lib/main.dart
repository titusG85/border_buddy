import 'package:border_buddy/mainFunctions/main_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/app_localizations.dart';
import 'utils/text_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'utils/firebase_util.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert'; // For decoding JSON data

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Fetch FCM token after Firebase initialization
  fetchFcmToken();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle foreground notifications
    if (message.notification != null) {
      showNotification(message.notification!);
    }

    if (message.data.containsKey('events')) {
      // Optionally handle the events data
      debugPrint('Foreground notification data: ${message.data['events']}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle notification tap
    if (message.data['screen'] == 'events_screen') {
      final eventsJson = message.data['events'];
      if (eventsJson != null) {
        final List<dynamic> events = json.decode(eventsJson);
        // TODO: Navigate to events screen with the provided events data
        debugPrint('Opened app from notification with events: $events');
      }
    }
  });

  runApp(const MyApp());
}

void showNotification(RemoteNotification notification) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'default_channel', // Channel ID
    'Default', // Channel name
    channelDescription: 'Default channel for notifications',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    notification.title,
    notification.body,
    platformChannelSpecifics,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // Default to English

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale; // Update the app's locale
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Border Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 180, 104, 5)),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayLarge,
          displayMedium: AppTextStyles.displayMedium,
          headlineLarge: AppTextStyles.screenTitle,
          headlineMedium: AppTextStyles.sectionHeader,
          titleLarge: AppTextStyles.cardTitle,
          titleMedium: AppTextStyles.appBarTitle,
          bodyLarge: AppTextStyles.bodyText,
          bodyMedium: AppTextStyles.subtitleText,
          labelLarge: AppTextStyles.buttonText,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: AppTextStyles.appBarTitle,
        ),
      ),
      locale: _locale, // Use the updated locale
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MainNavigator(onLanguageChange: _changeLanguage), // Pass the callback
    );
  }
}


