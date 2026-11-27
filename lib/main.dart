import 'package:flutter/material.dart';
import 'booking_form_page.dart';

void main() =>
  runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Reservation App',
      theme: ThemeData(
        
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 23, 58, 1)),
        useMaterial3: true,
      ),
      home: const BookingFormPage(),
    );
  }
}

