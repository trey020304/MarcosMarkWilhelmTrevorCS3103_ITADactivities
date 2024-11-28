import 'package:flutter/material.dart';
import 'dart:math'; // For rotation

class ImmutableWidget extends StatelessWidget {
  const ImmutableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.green, //center color
            Color.fromARGB(255, 58, 90, 22) //outer
          ],
          radius: 1.0, //radius of the gradient
          center: Alignment.center, //center point of the gradient
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(90),
        child: Transform.rotate(
          angle: pi / 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(255, 4, 21, 32)
                        .withOpacity(0.5), //shadow color
                    offset:
                        const Offset(16, 16), //moving shadow downwards along Y
                    blurRadius: 6,
                    spreadRadius: 1),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: _buildShinyCircle(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShinyCircle() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.lightBlueAccent,
            Colors.blueAccent,
          ],
          center: Alignment(-0.3, -0.5),
        ),
        boxShadow: [
          BoxShadow(blurRadius: 20),
        ],
      ),
    );
  }
}
