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
| **Welcome Screen** | ![English Home](https://github.com/user-attachments/assets/635a56ca-6efb-406f-ba34-73518ffd6b50) | ![Spanish Home](https://github.com/user-attachments/assets/a95c7d09-66d1-4247-8dde-a454277f9e0b) |
| **Ports List** | ![Ports List EN](https://github.com/user-attachments/assets/4269d9ce-6834-40a3-b2e0-02d3bfd9a77a) | ![Ports List ES](https://github.com/user-attachments/assets/e3a3fc1c-09d7-4664-b6f8-362a11f652a7) |
| **Wait Times Map** | ![Map EN](https://github.com/user-attachments/assets/6841600d-791e-49bc-aee0-65694e968721) | ![Map ES](https://github.com/user-attachments/assets/19ed896e-a529-41f1-b8a0-221933d5f82d) |
| **Events Tab** | ![Events EN](https://github.com/user-attachments/assets/fc3a15f1-5d76-404e-a2e2-22aa55d39d7c) | ![Events ES](https://github.com/user-attachments/assets/612f807a-9cab-47cd-aecb-3b7c4fb4bdac) |
| **Currency Converter** | ![Currency EN](https://github.com/user-attachments/assets/3413f845-c01d-4c18-8ec9-e67ff8c0a802) | ![Currency ES](https://github.com/user-attachments/assets/8578ea54-2e70-495a-8c5e-12dcbff3be29) |
| **Settings** | ![Settings EN](https://github.com/user-attachments/assets/9df29f16-9a6d-442a-892e-dcb87c8b107a) | ![Settings ES](https://github.com/user-attachments/assets/18b4dae5-984b-4598-af18-a768c99f2e45) |

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
