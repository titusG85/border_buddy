import 'package:flutter/material.dart';
import '../utils/app_localizations.dart'; // Import the localization helper

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Repeats the animation back and forth

    _bounceAnimation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get the localized strings

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.9,
            image: AssetImage('assets/background/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Text(
                    localizations.translate('welcome_message'), // Use the localized key
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 200,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 3, 1, 1),
                      fontFamily: 'Gravitas',
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _bounceAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/mascot/mascot.png',
                  width: 500, // Set a base width for the mascot
                  height: 500, // Set a base height for the mascot
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}