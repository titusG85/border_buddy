# 🔧 API Keys Setup Guide

This project requires several API keys to function properly. Follow these steps to configure them:

## 🗝️ Required API Keys

### 1. Google Maps API Key
- Go to [Google Cloud Console](https://console.cloud.google.com/)
- Enable Google Maps SDK for Android and JavaScript Maps API
- Create an API key and restrict it appropriately

### 2. Firebase Configuration
- Go to [Firebase Console](https://console.firebase.google.com/)
- Create a new project or use existing one
- Generate configuration files

## 📝 Configuration Steps

### Android Setup
1. Add your Google Maps API key to your Android configuration
2. Add your `google-services.json` to `android/app/`

### Web Setup  
1. Add your Google Maps API key to web configuration (if implementing web support)

### Firebase Setup
1. Replace placeholders in `lib/firebase_options.dart` with your actual values:
   - `YOUR_FIREBASE_API_KEY_HERE`
   - `YOUR_FIREBASE_APP_ID_HERE` 
   - `YOUR_MESSAGING_SENDER_ID_HERE`
   - `YOUR_PROJECT_ID_HERE`
   - `YOUR_STORAGE_BUCKET_HERE`

### iOS Setup (if applicable)
1. Add `GoogleService-Info.plist` to `ios/Runner/`

## ⚠️ Security Notes

- Never commit actual API keys to version control
- Restrict API keys to specific domains/applications
- Use environment variables for production deployments
- Regularly rotate API keys

## 🚀 Running the Project

After configuring all API keys:
```bash
flutter pub get
flutter run
```
