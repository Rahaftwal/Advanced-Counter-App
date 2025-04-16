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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Counter Display
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.counterService.count.toString(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 40),
              
              // Counter Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CounterButton(
                    icon: Icons.remove,
                    onPressed: widget.counterService.decrement,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 24),
                  CounterButton(
                    icon: Icons.add,
                    onPressed: widget.counterService.increment,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              
              // Countdown Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Countdown: ${widget.counterService.countdownValue}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _countdownController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Seconds',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
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
              const SizedBox(height: 24),
              
              // Reset Button
              ElevatedButton(
                onPressed: widget.counterService.reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 