import 'package:flutter/material.dart';

/// Centralized text styles for Border Buddy app
/// Optimized for mobile screens with consistent sizing
class AppTextStyles {
  // Font family
  static const String primaryFont = 'Gravitas';
  
  // Base colors
  static const Color primaryTextColor = Color.fromARGB(255, 3, 1, 1);
  static const Color secondaryTextColor = Colors.black87;
  static const Color subtitleTextColor = Colors.black54;
  
  // App Bar Titles (used in headers)
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );
  
  // Screen Titles (large headers within screens)
  static const TextStyle screenTitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );
  
  // Section Headers (medium headers for sections)
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: secondaryTextColor,
  );
  
  // Regular Body Text (standard content text)
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryTextColor,
  );
  
  // Subtitle/Caption Text (smaller descriptive text)
  static const TextStyle subtitleText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: subtitleTextColor,
  );
  
  // Button Text (for buttons and interactive elements)
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  // Large Display Text (for major UI elements like currency amounts)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: secondaryTextColor,
  );
  
  // Medium Display Text (for important numbers/values)
  static const TextStyle displayMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: secondaryTextColor,
  );
  
  // Card Title Text (for list items and cards)
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: secondaryTextColor,
  );
  
  // Card Subtitle Text (for secondary info in cards)
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: subtitleTextColor,
  );
  
  // Input Text (for text fields and user input)
  static const TextStyle inputText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: secondaryTextColor,
  );
  
  // Keypad Text (for calculator-style buttons)
  static const TextStyle keypadText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: secondaryTextColor,
  );
  
  // Error Text (for error messages)
  static const TextStyle errorText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );
  
  // Success Text (for success messages)
  static const TextStyle successText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.green,
  );
  
  // Map Marker Text (for map overlays)
  static const TextStyle mapMarkerText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  // Welcome Screen Large Text (special case for welcome)
  static const TextStyle welcomeText = TextStyle(
    fontFamily: primaryFont,
    fontSize: 48, // Reduced from 200 for better mobile compatibility
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );
  
  // Helper methods for responsive sizing based on screen size
  static TextStyle responsiveText(BuildContext context, TextStyle baseStyle, {double scaleFactor = 1.0}) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    
    // Adjust font size based on screen width
    double adjustedFontSize = baseStyle.fontSize ?? 16;
    
    if (screenWidth < 360) {
      // Small screens (older phones)
      adjustedFontSize *= 0.9 * scaleFactor;
    } else if (screenWidth > 600) {
      // Large screens (tablets)
      adjustedFontSize *= 1.1 * scaleFactor;
    } else {
      // Standard screens
      adjustedFontSize *= scaleFactor;
    }
    
    return baseStyle.copyWith(fontSize: adjustedFontSize);
  }
}
