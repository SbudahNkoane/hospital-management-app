class Review {
  final String hospitalAttended;
  final String review;

  Review({
    required this.hospitalAttended,
    required this.review,
  });

  Map<String, Object?> toJson() => {
        'Hospital_Attended': hospitalAttended,
        'Review': review,
      };

  static Review fromJson(Map<dynamic, dynamic>? json) => Review(
        hospitalAttended: json!['Hospital_Attended'] as String,
        review: json['Review'] as String,
      );
}
