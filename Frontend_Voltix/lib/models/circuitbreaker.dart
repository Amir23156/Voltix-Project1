class CircuitBreaker {
  final String circuitBreakerName;
  final String circuitBreakerRefrence;

  CircuitBreaker({
    required this.circuitBreakerName,
    required this.circuitBreakerRefrence,
  });

  factory CircuitBreaker.fromJson(Map<String, dynamic> json) {
    return CircuitBreaker(
      circuitBreakerName: json['circuitBreakerName'],
      circuitBreakerRefrence: json['circuitBreakerRefrence'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'circuitBreakerName': circuitBreakerName,
      'circuitBreakerRefrence': circuitBreakerRefrence
    };
  }
}
