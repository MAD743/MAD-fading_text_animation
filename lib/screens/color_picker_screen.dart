import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({super.key});

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  Color _textColor = Colors.black;

  void changeColor(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Picker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pick a Color!',
            style: TextStyle(fontSize: 24, color: _textColor),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Select Text Color"),
                  content: BlockPicker(
                    pickerColor: _textColor,
                    onColorChanged: changeColor,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Done"),
                    ),
                  ],
                ),
              );
            },
            child: const Text("Choose Color"),
          ),
        ],
      ),
    );
  }
}
