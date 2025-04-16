import 'dart:async';
import 'package:shared_preferences.dart';
import '../models/counter_history.dart';

class CounterService {
  int _count = 0;
  int _countdownValue = 0;
  Timer? _countdownTimer;
  final List<CounterHistory> _history = [];
  final SharedPreferences _prefs;

  CounterService(this._prefs) {
    _loadState();
  }

  int get count => _count;
  int get countdownValue => _countdownValue;
  List<CounterHistory> get history => List.unmodifiable(_history);

  void increment() {
    _count++;
    _addToHistory('increment');
    _saveState();
  }

  void decrement() {
    _count--;
    _addToHistory('decrement');
    _saveState();
  }

  void startCountdown(int seconds) {
    _countdownValue = seconds;
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownValue > 0) {
        _countdownValue--;
        _addToHistory('countdown');
        _saveState();
      } else {
        timer.cancel();
      }
    });
  }

  void stopCountdown() {
    _countdownTimer?.cancel();
    _countdownValue = 0;
    _saveState();
  }

  void reset() {
    _count = 0;
    _countdownValue = 0;
    _countdownTimer?.cancel();
    _history.clear();
    _saveState();
  }

  void _addToHistory(String type) {
    _history.add(CounterHistory(
      timestamp: DateTime.now(),
      value: type == 'countdown' ? _countdownValue : _count,
      type: type,
    ));
  }

  Future<void> _saveState() async {
    await _prefs.setInt('count', _count);
    await _prefs.setInt('countdownValue', _countdownValue);
    final historyJson = _history.map((h) => h.toJson()).toList();
    await _prefs.setStringList('history', historyJson.map((h) => h.toString()).toList());
  }

  Future<void> _loadState() async {
    _count = _prefs.getInt('count') ?? 0;
    _countdownValue = _prefs.getInt('countdownValue') ?? 0;
    final historyJson = _prefs.getStringList('history') ?? [];
    _history.clear();
    _history.addAll(historyJson.map((h) => CounterHistory.fromJson(h as Map<String, dynamic>)));
  }
} 