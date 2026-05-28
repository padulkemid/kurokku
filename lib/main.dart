import 'package:flutter/material.dart';
import 'package:kurokku/clock.dart';
import 'package:kurokku/tick.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: TickingClock(),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text('ROLEX'),
              Text('rejeki orang jelex'),
            ],
          ),
        ),
      ),
    );
  }
}
