import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management/Models/patient.dart';

class PatientManagement with ChangeNotifier {
  FirebaseFirestore database = FirebaseFirestore.instance;
  Patient? _patientData;
  Patient? get patientData => _patientData;

  bool _showprogress = false;
  bool get showProgress => _showprogress;

  String _userprogresstext = "";
  String get userProgressText => _userprogresstext;

  void listenToUserUpdates(String id) {
    database.collection("Patients").doc(id).snapshots().listen(
      (event) {
        _patientData = Patient.fromJson(event.data() as Map<String, dynamic>);
        notifyListeners();
      },
      onDone: () async {},
    );
  }

  Future<Patient?> getPatientData(String userID) async {
    _showprogress = true;
    _userprogresstext = '';
    notifyListeners();
    final patientReference = database.collection("Patients").doc(userID);

    try {
      await patientReference.get().then(
        (DocumentSnapshot doc) {
          _patientData = Patient.fromJson(doc.data() as Map<String, dynamic>);
        },
      );
      listenToUserUpdates(userID);
      if (_patientData!.userId == null) {
        await patientReference.set(
          {'User_ID': userID},
          SetOptions(merge: true),
        ).onError((error, stackTrace) {});
      }
    } finally {
      _showprogress = false;
      notifyListeners();
    }

    return _patientData;
  }
}
