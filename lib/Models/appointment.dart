import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hospital_management/Models/review.dart';

class Appointment {
  final String? apId;
  final String ownerId;
  final Timestamp appointmentTime;
  final String appointmentReason;
  final Review? review;

  Appointment({
    required this.review,
    required this.ownerId,
    this.apId,
    required this.appointmentTime,
    required this.appointmentReason,
  });

  Map<String, Object?> toJson() => {
        'Appointment_Time': appointmentTime,
        'Appointment_Reason': appointmentReason,
        'Owner_Id': ownerId,
        'Review': review,
      };

  static Appointment fromJson(Map<dynamic, dynamic>? json) => Appointment(
        appointmentTime: json!['Appointment_Time'] as Timestamp,
        appointmentReason: json['Appointment_Reason'] as String,
        apId: json['Ap_Id'] as String?,
        ownerId: json['Owner_Id'] as String,
        review: json['Review'] == null
            ? null
            : Review.fromJson(json['Review'] as Map?),
      );
}
