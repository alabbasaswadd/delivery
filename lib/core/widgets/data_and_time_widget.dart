import 'dart:async';
import 'package:delivery/core/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get formattedDate {
    // مثال: الأربعاء 31 يوليو 2025
    return DateFormat('EEEE d MMMM yyyy', 'ar').format(_now);
  }

  String get formattedTime {
    // مثال: 02:12:45 ص
    return DateFormat('hh:mm:ss a', 'ar').format(_now);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CairoText(
          formattedDate,
          fontSize: 15,
        ),
        const SizedBox(height: 8),
        CairoText(
          formattedTime,
          fontSize: 15,
        ),
      ],
    );
  }
}
