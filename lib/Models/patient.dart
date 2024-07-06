import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String? userId;
  final String firstName;
  final String surname;
  final String idNumber;
  final String emailaddress;
  final Timestamp dateOfBirth;
  final String contactNumber;
  final String role;

  Patient({
    required this.firstName,
    required this.surname,
    required this.idNumber,
    required this.emailaddress,
    required this.dateOfBirth,
    required this.contactNumber,
    required this.role,
    this.userId,
  });

  Map<String, Object?> toJson() => {
        'First_Name': firstName,
        'Surname': surname,
        'Id_Number': idNumber,
        'Email_Address': emailaddress,
        'Date_Of_Birth': dateOfBirth,
        'Contact_Number': contactNumber,
        'Role': role,
      };

  static Patient fromJson(Map<dynamic, dynamic>? json) => Patient(
      firstName: json!['First_Name'] as String,
      surname: json['Surname'] as String,
      idNumber: json['Id_Number'] as String,
      emailaddress: json['Email_Address'] as String,
      dateOfBirth: json['Date_Of_Birth'] as Timestamp,
      contactNumber: json['Contact_Number'] as String,
      role: json['Role'] as String,
      userId: json['User_ID'] as String);
}
