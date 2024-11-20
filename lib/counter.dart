import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _resetCount = 0;
  List<int> beadPositions = []; // Stores bead positions as counter increases

  void _incrementCounter() {
    setState(() {
      _counter++;
     

      if (_counter == 100) {
       
        _counter = 0;
        _resetCount++;
       
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _resetCount = 0;
      //beadPositions.clear(); // Clear all bead positions on reset
    });
  }

  // Function to get color based on counter value
  Color _getBorderColor() {
    if (_counter < 33) {
      return Colors.red;
    } else if (_counter < 66) {
      return Colors.blue;
    } else if (_counter < 99) {
      return Colors.green;
    } else {
      return Colors.amber; // Golden color at 100
    }
  }

 

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.66; // 66% of screen width
    final double radius = buttonSize / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Hollow Circular Button
            GestureDetector(
              onTap: _incrementCounter,
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getBorderColor(),
                    width: 1, // Width of the hollow circle border
                  ),
                ),
              ),
              
            ),

            // Counter Text in the Center
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: buttonSize * 0.3,
                fontWeight: FontWeight.bold,
                color: _getBorderColor(),
              ),
            ),
            // Animated Beads around the circumference with gaps
            ...beadPositions.map((pos) {
              //final beadOffset = _calculateBeadPosition(pos, radius - 10);
              return Positioned(
            bottom: 56,
            right: 16,
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[600],
              child: Text(
                '$_resetCount',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          FloatingActionButton.large(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
          // Positioned(
          //  // bottom: 56,
          //   //right: 16,
          //   child: CircleAvatar(
          //     radius: 70,
          //     backgroundColor: Colors.grey[600],
          //     child: Text(
          //       '$_resetCount',
          //       style: const TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
