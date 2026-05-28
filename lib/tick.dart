import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kurokku/clock.dart';

class TickingClock extends StatefulWidget {
  const TickingClock({super.key});

  @override
  State<TickingClock> createState() => _TickingClockState();
}

class _TickingClockState extends State<TickingClock>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<DateTime> timeNotifier = ValueNotifier(DateTime.now());
  late final Ticker ticker;

  @override
  void initState() {
    ticker = createTicker((_) {
      timeNotifier.value = DateTime.now();
    });

    ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.dispose();
    timeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Clock(
        timeNotifier: timeNotifier,
      ),
    );
  }
}
