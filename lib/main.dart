// Developer Information
// File: main.dart
// Description: Main application entry point and navigation setup
// Author: Rahaf AL-Twal
// Date: 2025
// Version: 1.0.0

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/counter_screen.dart';
import 'screens/history_screen.dart';
import 'services/counter_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final counterService = CounterService(prefs);
  
  runApp(MyApp(counterService: counterService));
}

class MyApp extends StatelessWidget {
  final CounterService counterService;

  const MyApp({
    Key? key,
    required this.counterService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MainScreen(counterService: counterService),
    );
  }
}

class MainScreen extends StatefulWidget {
  final CounterService counterService;

  const MainScreen({
    Key? key,
    required this.counterService,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          CounterScreen(counterService: widget.counterService),
          HistoryScreen(counterService: widget.counterService),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
