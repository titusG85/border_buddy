import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void fetchFcmToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      debugPrint('FCM Token: $token');
      // You can show a toast or log the token here
      // Example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('FCM Token: $token')));
    } else {
      debugPrint('Failed to fetch FCM token.');
    }
  } catch (e) {
    debugPrint('Error fetching FCM token: $e');
  }
}