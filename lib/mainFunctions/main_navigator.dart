import 'package:border_buddy/mainFunctions/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../map/map_screen.dart';
import '../events/event_screen.dart';
import '../ports/border_list_screen.dart';
import '../currency/currency_screen.dart';
import '../settings/settings_screen.dart';
import '../utils/app_localizations.dart'; // Import localization helper

class MainNavigator extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  const MainNavigator({super.key, required this.onLanguageChange});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 2;

  // Screens are initialized lazily
  final Map<int, Widget> _screenCache = {};

  Widget _getScreen(int index) {
    if (!_screenCache.containsKey(index)) {
      switch (index) {
        case 0:
          _screenCache[index] = const BorderList();
          break;
        case 1:
          _screenCache[index] = const MapScreen();
          break;
        case 2:
          _screenCache[index] = const WelcomeScreen();
          break;
        case 3:
          _screenCache[index] = const EventsScreen();
          break;
        case 4:
          _screenCache[index] = const CurrencyScreen();
          break;
        case 5:
          _screenCache[index] =
              SettingsScreen(onLanguageChange: widget.onLanguageChange);
          break;
      }
    }
    return _screenCache[index]!;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      body: Stack(
        children: List.generate(6, (index) {
          return Offstage(
            offstage: _selectedIndex != index,
            child: TickerMode(
              enabled: _selectedIndex == index,
              child: _getScreen(index),
            ),
          );
        }),
      ),
      extendBody: true,
      bottomNavigationBar: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin:
              const EdgeInsets.only(bottom: 16), // Add spacing from the bottom
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 76, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.list,
                  color: _selectedIndex == 0 ? Colors.white : Colors.white70,
                ),
                onPressed: () => _onItemTapped(0),
                tooltip: localizations.translate('list_of_ports'), // Localized tooltip
              ),
              IconButton(
                icon: Icon(
                  Icons.map,
                  color: _selectedIndex == 1 ? Colors.white : Colors.white70,
                ),
                onPressed: () => _onItemTapped(1),
                tooltip: localizations.translate('ports_of_entry_map'), // Localized tooltip
              ),
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 36, // Make this icon slightly larger
                  color: _selectedIndex == 2
                      ? Colors.white
                      : const Color.fromARGB(179, 177, 157, 157),
                ),
                onPressed: () => _onItemTapped(2),
                tooltip: localizations.translate('welcome_message'), // Localized tooltip
              ),
              IconButton(
                icon: Icon(
                  Icons.event,
                  color: _selectedIndex == 3 ? Colors.white : Colors.white70,
                ),
                onPressed: () => _onItemTapped(3),
                tooltip: localizations.translate('events'), // Localized tooltip
              ),
              IconButton(
                icon: Icon(
                  Icons.attach_money_rounded,
                  color: _selectedIndex == 4 ? Colors.white : Colors.white70,
                ),
                onPressed: () => _onItemTapped(4),
                tooltip: localizations.translate('currency_converter'), // Localized tooltip
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: _selectedIndex == 5 ? Colors.white : Colors.white70,
                ),
                onPressed: () => _onItemTapped(5),
                tooltip: localizations.translate('settings'), // Localized tooltip
              ),
            ],
          ),
        ),
      ),
    );
  }
}
