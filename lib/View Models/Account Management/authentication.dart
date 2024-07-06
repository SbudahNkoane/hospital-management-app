import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management/Models/admin.dart';
import 'package:hospital_management/Models/patient.dart';

class Authentication with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth authentication = FirebaseAuth.instance;
  bool _showprogress = false;
  bool get showProgress => _showprogress;

  String _userprogresstext = "";
  String get userProgressText => _userprogresstext;

  Future<String> resetPassword(String email) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Reseting password..';
    notifyListeners();

    try {
      authentication.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      state = error.message.toString();
    } catch (error) {
      state = error.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }
    return state;
  }

  Future<String> registerUser(String password,
      [Patient? patient, Admin? admin]) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Creating account...';
    notifyListeners();
    try {
      await authentication
          .createUserWithEmailAndPassword(
        email: patient != null ? patient.emailaddress : admin!.emailaddress,
        password: password,
      )
          .then((registeredUser) async {
        _currentUser = registeredUser.user;
        // check if it is a Patient or Admin Registering
        // If patient is not null-save to Patients table
        // if admin is not null-save to Admins table
        if (patient != null) {
          await database
              .collection('Patients')
              .doc(registeredUser.user!.uid)
              .set(patient.toJson())
              .then((value) async {
            _userprogresstext = 'Saving data...';
            notifyListeners();
            await database
                .collection('Patients')
                .doc(registeredUser.user!.uid)
                .update({'User_ID': registeredUser.user!.uid});
          }).onError((error, stackTrace) {
            state = error.toString();
          });

          // register Admin
        } else if (admin != null) {
          await _currentUser!.updateDisplayName('Administrator');
          await database
              .collection('Admins')
              .doc(registeredUser.user!.uid)
              .set(admin.toJson())
              .then((value) async {
            _userprogresstext = 'Saving data...';
            notifyListeners();
            await database
                .collection('Admins')
                .doc(registeredUser.user!.uid)
                .update({'User_ID': registeredUser.user!.uid});
          }).onError((error, stackTrace) {
            state = error.toString();
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        state = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        state = 'The account already exists for that email.';
      } else {
        state = e.message.toString();
      }
    } catch (e) {
      state = e.toString();
    } finally {
      _showprogress = false;
      notifyListeners();
    }
    return state;
  }

  //========= LOGIN USER ==========
  Future<String> loginUser(String email, String password) async {
    String state = 'OK';
    _showprogress = true;
    _userprogresstext = 'Signing in...';
    notifyListeners();
    try {
      await authentication
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .onError((error, stackTrace) {
        state = error.toString();
        return Future.error(error.toString());
      }).then((value) {
        if (value.user!.emailVerified != false) {
          state = 'Confirm Your email to sign in';
        } else {
          _currentUser = value.user;
        }

        return value;
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        state = 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        state = 'Wrong password provided for that user.';
      } else {
        state = error.message.toString();
      }
    } catch (e) {
      if (e.toString().contains('invalid-credential')) {
        state = 'Incorrect username/password';
      } else if (e.toString().contains('too-many-requests')) {
        state = 'You have sent too many requests, try again later';
      }
    } finally {
      _showprogress = false;
      notifyListeners();
    }
    return state;
  }

  //========= LOG OUT USER ==========
  Future<String> logoutUser() async {
    String state = 'OK';
    try {
      await authentication.signOut();
      _currentUser = null;
    } catch (e) {
      state = e.toString();
    }
    return state;
  }
}
