class CounterHistory {
  final DateTime timestamp;
  final int value;
  final String type; // 'increment', 'decrement', or 'countdown'

  CounterHistory({
    required this.timestamp,
    required this.value,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'value': value,
      'type': type,
    };
  }

  factory CounterHistory.fromJson(Map<String, dynamic> json) {
    return CounterHistory(
      timestamp: DateTime.parse(json['timestamp']),
      value: json['value'],
      type: json['type'],
    );
  }
} 