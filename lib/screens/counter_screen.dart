// Developer Information
// File: counter_screen.dart
// Description: Main counter screen with increment/decrement and countdown functionality
// Author: Rahaf AL-Twal
// Date: 2025
// Version: 1.0.0

import 'package:flutter/material.dart';
import '../services/counter_service.dart';
import '../widgets/counter_button.dart';

class CounterScreen extends StatefulWidget {
  final CounterService counterService;

  const CounterScreen({
    Key? key,
    required this.counterService,
  }) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final TextEditingController _countdownController = TextEditingController();

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Counter'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter Display
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.counterService.count.toString(),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Counter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterButton(
                  icon: Icons.remove,
                  onPressed: widget.counterService.decrement,
                  color: Colors.red,
                ),
                const SizedBox(width: 16),
                CounterButton(
                  icon: Icons.add,
                  onPressed: widget.counterService.increment,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Countdown Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Countdown: ${widget.counterService.countdownValue}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _countdownController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Seconds',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          final seconds = int.tryParse(_countdownController.text);
                          if (seconds != null && seconds > 0) {
                            widget.counterService.startCountdown(seconds);
                          }
                        },
                        child: const Text('Start'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Reset Button
            ElevatedButton(
              onPressed: widget.counterService.reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
} 