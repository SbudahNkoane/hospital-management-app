import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hospital_management/Models/admin.dart';

class AdminManagement with ChangeNotifier {
  FirebaseFirestore database = FirebaseFirestore.instance;
  bool _showprogress = false;
  bool get showProgress => _showprogress;
  Admin? _adminData;
  Admin? get adminData => _adminData;

  String _userprogresstext = "";
  String get userProgressText => _userprogresstext;

  void listenToUserUpdates(String id) {
    database.collection("Admins").doc(id).snapshots().listen(
      (event) {
        _adminData = Admin.fromJson(event.data() as Map<String, dynamic>);
        notifyListeners();
      },
      onDone: () async {},
    );
  }

  Future<Admin?> getAdminData(String userID) async {
    _showprogress = true;
    _userprogresstext = 'Getting data...';
    notifyListeners();
    final patientReference = database.collection("Admins").doc(userID);

    try {
      await patientReference.get().then(
        (DocumentSnapshot doc) {
          _adminData = Admin.fromJson(doc.data() as Map<String, dynamic>);
        },
      );
      listenToUserUpdates(userID);
      if (_adminData!.userId == null) {
        await patientReference.set(
          {'User_ID': userID},
          SetOptions(merge: true),
        ).onError((error, stackTrace) {});
      }
    } finally {
      _showprogress = false;
      notifyListeners();
    }

    return _adminData;
  }
}
