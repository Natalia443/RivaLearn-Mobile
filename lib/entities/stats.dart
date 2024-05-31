class Stats {
  Stats({
    required this.success,
    required this.total,
    required this.userId,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      success: json['success'] as int,
      total: json['total'] as int,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      "total": total,
      "userId": userId,
    };
  }

  final int success;
  final int total;
  final String userId;
}
