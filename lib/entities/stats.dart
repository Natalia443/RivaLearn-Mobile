class Stats {
  Stats({
    required this.success,
    required this.total,
    this.userId,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      success: json['success'] as int,
      total: json['total'] as int,
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
  final String? userId;
}
