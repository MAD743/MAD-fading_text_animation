import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 360;
const double windowHeight = 640;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Age Counter');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class Counter with ChangeNotifier {
  int value = 0;
  bool showFrame = false;

  void increment() {
    if (value < 99) {
      value += 1;
      notifyListeners();
    }
  }

  void decrement() {
    if (value > 0) {
      value -= 1;
      notifyListeners();
    }
  }

  void updateAge(int newValue) {
    value = newValue;
    notifyListeners();
  }

  void toggleFrame() {
    showFrame = !showFrame;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Color getBackgroundColor(int age) {
    if (age <= 12) return Colors.lightBlue;
    if (age <= 19) return Colors.lightGreen;
    if (age <= 30) return Colors.amber;
    if (age <= 50) return Colors.orange;
    return Colors.grey;
  }

  String getAgeMessage(int age) {
    if (age <= 12) return "You're a child!";
    if (age <= 19) return "Teenager time!";
    if (age <= 30) return "You're a young adult!";
    if (age <= 50) return "You're an adult now!";
    return "Golden years!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Counter')),
      body: Consumer<Counter>(
        builder: (context, counter, child) {
          return Container(
            color: getBackgroundColor(counter.value),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getAgeMessage(counter.value),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Slider(
                  min: 0,
                  max: 99,
                  value: counter.value.toDouble(),
                  onChanged: (value) {
                    counter.updateAge(value.toInt());
                  },
                ),
                LinearProgressIndicator(
                  value: counter.value / 99,
                  color: counter.value <= 33
                      ? Colors.green
                      : counter.value <= 67
                          ? Colors.yellow
                          : Colors.red,
                  backgroundColor: Colors.grey.shade300,
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: counter.showFrame
                      ? BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        )
                      : null,
                  child: Image.asset('assets/sample_image.png', width: 100, height: 100),
                ),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text('Show Frame'),
                  value: counter.showFrame,
                  onChanged: (bool value) {
                    counter.toggleFrame();
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () => counter.decrement(),
                      tooltip: 'Decrement',
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () => counter.increment(),
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}