import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'second_animation_screen.dart';
import 'color_picker_screen.dart';

class FadingTextScreen extends StatefulWidget {
  const FadingTextScreen({super.key});

  @override
  _FadingTextScreenState createState() => _FadingTextScreenState();
}

class _FadingTextScreenState extends State<FadingTextScreen> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode
                ? Icons.nightlight_round
                : Icons.wb_sunny),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ColorPickerScreen()),
              );
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: toggleVisibility,
        child: Center(
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: const Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SecondAnimationScreen()),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
