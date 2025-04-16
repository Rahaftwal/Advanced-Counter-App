// Developer Information
// File: history_screen.dart
// Description: History screen showing counter operations and timestamps
// Author: Rahaf AL-Twal
// Date: 2025
// Version: 1.0.0

import 'package:flutter/material.dart';
import '../models/counter_history.dart';
import '../services/counter_service.dart';

class HistoryScreen extends StatelessWidget {
  final CounterService counterService;

  const HistoryScreen({
    Key? key,
    required this.counterService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: counterService.history.length,
        itemBuilder: (context, index) {
          final history = counterService.history[index];
          return HistoryItem(history: history);
        },
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final CounterHistory history;

  const HistoryItem({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: _getIcon(),
        title: Text(
          'Value: ${history.value}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          _formatDate(history.timestamp),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          _getTypeText(),
          style: TextStyle(
            color: _getTypeColor(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Icon _getIcon() {
    switch (history.type) {
      case 'increment':
        return const Icon(Icons.add, color: Colors.green);
      case 'decrement':
        return const Icon(Icons.remove, color: Colors.red);
      case 'countdown':
        return const Icon(Icons.timer, color: Colors.orange);
      default:
        return const Icon(Icons.history);
    }
  }

  String _getTypeText() {
    switch (history.type) {
      case 'increment':
        return 'Increment';
      case 'decrement':
        return 'Decrement';
      case 'countdown':
        return 'Countdown';
      default:
        return history.type;
    }
  }

  Color _getTypeColor() {
    switch (history.type) {
      case 'increment':
        return Colors.green;
      case 'decrement':
        return Colors.red;
      case 'countdown':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
} 