# 📱 Border Buddy App

## 📌 Brief Description

**Border Buddy** is a mobile app built for residents of **El Paso** and **Ciudad Juárez**, offering a simple, bilingual way to:

- Check real-time **border crossing info**  
- Browse **local events** in El Paso  
- Use a live **USD ⇄ MXN currency converter**

---

## 🚀 Key Features

### 🗺️ Interactive Map of Ports of Entry
- Real-time wait times for:
  - **Ready Lane**
  - **SENTRI**
  - **Pedestrian**
  - **Cargo lanes**
- Lane status and hours
- Map view of all El Paso–Juárez ports

### 📆 Local Events Calendar
- Weekly listings of local events  
- Filter by categories: music, food, sports, culture  
- One-tap calendar integration

### 🌐 Language Support
- Fully bilingual interface: **English & Spanish**

### 🔔 Push Notifications
- Weekly reminders to explore new local events

### 💱 Currency Converter
- Real-time USD ⇄ MXN exchange rates  
- Easy bidirectional conversion

---

## 🖼️ Sample Screens

| 📱 Screen | English | Spanish |
|----------|---------|---------|
| **Welcome Screen** | ![English Home](https://github.com/user-attachments/assets/38fd3b3a-5855-462d-81d9-714a96ec2d51) | ![Spanish Home](https://github.com/user-attachments/assets/016a9b9b-5a8a-41d6-b83a-32eaa4b68ec6) |
| **Ports List** | ![Ports List EN](https://github.com/user-attachments/assets/6c917e1b-c45d-4537-99ac-4f465dca48af) | ![Ports List ES](https://github.com/user-attachments/assets/19d0308e-e5bf-4fb5-afa4-4701614d7cee) |
| **Wait Times Map** | ![Map EN](https://github.com/user-attachments/assets/8c683c14-02dc-4398-8646-9bd80356b1ba) | ![Map ES](https://github.com/user-attachments/assets/096eaae7-6006-4171-9774-11242193e47b) |
| **Events Tab** | ![Events EN](https://github.com/user-attachments/assets/4ad8ef94-4027-4646-8398-bc43f0514467) | ![Events ES](https://github.com/user-attachments/assets/42c7943d-a986-4c20-b70c-3b7b21ceb165) |
| **Currency Converter** | ![Currency EN](https://github.com/user-attachments/assets/9168910c-40ae-441a-a961-3635d4e07508) | ![Currency ES](https://github.com/user-attachments/assets/e992cbd2-5b03-4771-b576-fdc6c173a522) |
| **Settings** | ![Settings EN](https://github.com/user-attachments/assets/57ed280f-8f18-44ad-b328-33e347e0bd21) | ![Settings ES](https://github.com/user-attachments/assets/3616aa9c-b4fa-4c12-a9b4-9c9fbfc7812b) |

---

## 🧩 Development Challenges

### 🔔 Push Notifications
- Implemented using **Firebase Cloud Messaging**
- Weekly triggers remind users to check for events

### 🗺️ Google Maps Integration
- Used `google_maps_flutter` for map views
- Integrated live port wait times using external data sources

---

## 📚 Libraries Used

| Library | Purpose |
|--------|---------|
| `google_maps_flutter` | Interactive map integration |
| `add_2_calendar` | Event reminders on native calendar |
| `intl`, `flutter_localizations` | Formatting and i18n |
| `cupertino_icons` | iOS-style UI icons |
| `firebase_messaging`, `firebase_core` | Notifications and Firebase integration |
| `flutter` | App framework |
| `xml`, `http`, `html` | Parsing for RSS/event feeds |
| `connectivity_plus` | Offline/network awareness |

---

## 📊 Project Complexity

- 📦 **Code Size:** ~764.8 MB  
- 🧱 **Classes:** 17  
- 📁 **Files in `lib/`:** 21  
- 📄 **Lines of Dart Code:** 1,610  
