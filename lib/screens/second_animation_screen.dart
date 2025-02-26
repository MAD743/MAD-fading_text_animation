import 'package:flutter/material.dart';

class SecondAnimationScreen extends StatefulWidget {
  const SecondAnimationScreen({super.key});

  @override
  _SecondAnimationScreenState createState() => _SecondAnimationScreenState();
}

class _SecondAnimationScreenState extends State<SecondAnimationScreen> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Animation Screen')),
      body: Center(
        child: GestureDetector(
          onTap: toggleVisibility,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(seconds: 3), // Longer duration
            child: const Text(
              'Flutter Animations!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
