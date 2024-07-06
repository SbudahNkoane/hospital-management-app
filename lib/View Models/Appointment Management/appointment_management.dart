import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hospital_management/Models/appointment.dart';
import 'package:hospital_management/Models/review.dart';

class AppointmentManagement with ChangeNotifier {
  List<Appointment> _myAppointments = [];
  List<Appointment> get myAppointments => _myAppointments;

  List<Appointment> _allAppointments = [];
  List<Appointment> get allAppointments => _allAppointments;

  int? _appointmentClicked;
  int? get appointmentClicked => _appointmentClicked;

  FirebaseFirestore database = FirebaseFirestore.instance;

  bool _showprogress = false;
  bool get showProgress => _showprogress;

  String _userprogresstext = "";
  String get userProgressText => _userprogresstext;

  Future<String> scheduleAppointment(Appointment newAppointment) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Scheduling appointment...';
    notifyListeners();

    try {
      await database
          .collection("Appointments")
          .add(newAppointment.toJson())
          .then((value) async {
        await database.collection("Appointments").doc(value.id).update({
          'Ap_Id': value.id,
        });
      });
    } catch (error) {
      state = error.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }

    return state;
  }

  void trackMyAppoinments(String id) {
    database
        .collection("Appointments")
        .where("Owner_Id", isEqualTo: id)
        .snapshots()
        .listen((event) {
      _myAppointments = [];
      notifyListeners();
      for (var appointment in event.docs) {
        _myAppointments.add(
          Appointment.fromJson(
            appointment.data(),
          ),
        );
      }
      notifyListeners();
    });
  }

  void trackAllAppoinments() {
    database.collection("Appointments").snapshots().listen((event) {
      _allAppointments = [];
      notifyListeners();
      for (var appointment in event.docs) {
        _allAppointments.add(
          Appointment.fromJson(
            appointment.data(),
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<String> deleteAppointment(String appointmentId) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Deleting Appointment';
    notifyListeners();
    try {
      database.collection("Appointments").doc(appointmentId).delete();
    } catch (error) {
      state = error.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }
    return state;
  }

  Future<String> deleteReview(String appointmentId) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Deleting review';
    notifyListeners();
    try {
      await database.collection("Appointments").doc(appointmentId).update({
        'Review': null,
      });
    } catch (error) {
      state = error.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }
    return state;
  }

  Future<String> review(String appointmentId, Review review) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Saving feedback';
    notifyListeners();
    try {
      await database.collection("Appointments").doc(appointmentId).update({
        'Review': review.toJson(),
      });
    } catch (error) {
      state = error.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }
    return state;
  }

  Future<String> getMyAppointments(String id) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Getting your appointment...';
    notifyListeners();

    try {
      await database
          .collection("Appointments")
          .where("Owner_Id", isEqualTo: id)
          .get()
          .then((value) {
        _myAppointments = [];
        for (var appointment in value.docs) {
          _myAppointments.add(
            Appointment.fromJson(
              appointment.data(),
            ),
          );
        }
        trackMyAppoinments(id);
      });
    } catch (error) {
      state = error.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }

    return state;
  }

  Future<String> getAllAppointments() async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Getting appointments...';
    notifyListeners();

    try {
      await database.collection("Appointments").get().then((value) {
        _allAppointments = [];
        for (var appointment in value.docs) {
          _allAppointments.add(
            Appointment.fromJson(
              appointment.data(),
            ),
          );
        }
        trackAllAppoinments();
      });
    } catch (error) {
      state = error.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }

    return state;
  }

  int viewAppointment(int index) {
    _appointmentClicked = index;
    notifyListeners();
    return index;
  }
}
