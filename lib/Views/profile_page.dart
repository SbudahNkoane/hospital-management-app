// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management/Models/admin.dart';
import 'package:hospital_management/Models/patient.dart';
import 'package:hospital_management/View%20Models/Account%20Management/authentication.dart';
import 'package:hospital_management/View%20Models/Admin%20Management/admin_management.dart';
import 'package:hospital_management/View%20Models/Patient%20Management/patient_management.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstnameController;
  late TextEditingController _surnameController;
  late TextEditingController _idNumberController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _contactNumberController;
  final GlobalKey<FormState> _editProfileFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstnameController = TextEditingController();
    _surnameController = TextEditingController();
    _contactNumberController = TextEditingController();
    _dateOfBirthController = TextEditingController();

    _idNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _surnameController.dispose();
    _firstnameController.dispose();
    _contactNumberController.dispose();
    _dateOfBirthController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: const Color(0xFF2C3847),
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: context.read<Authentication>().currentUser!.displayName == null
            ? Selector<PatientManagement, Patient>(
                selector: (p0, p1) => p1.patientData!,
                builder: (context, value, child) => Container(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            showBottomSheet(
                              enableDrag: false,
                              context: context,
                              builder: (context) => Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Form(
                                      key: _editProfileFormKey,
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your name';
                                          } else if (value.length < 2) {
                                            return 'Please enter valid name';
                                          }
                                          return null;
                                        },
                                        controller: _firstnameController,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 251, 0, 0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 250, 20, 3),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFD9458D),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 59, 59, 59),
                                            ),
                                          ),
                                          prefixIcon:
                                              const Icon(Icons.person_3),
                                          labelText: 'First Name',
                                          labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF2C3847),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            fixedSize: const Size(100, 50),
                                            foregroundColor:
                                                const Color(0xFFFFFFFF),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 0, 0),
                                          ),
                                          onPressed: () {
                                            _firstnameController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            fixedSize: const Size(100, 50),
                                            foregroundColor:
                                                const Color(0xFFFFFFFF),
                                            backgroundColor:
                                                const Color(0xFF2C3847),
                                          ),
                                          onPressed: () async {
                                            if (_editProfileFormKey
                                                .currentState!
                                                .validate()) {
                                              FirebaseFirestore database =
                                                  FirebaseFirestore.instance;
                                              if (context
                                                      .read<Authentication>()
                                                      .currentUser!
                                                      .displayName !=
                                                  null) {
                                                database
                                                    .collection("Admins")
                                                    .doc(value.userId)
                                                    .update({
                                                  'First_Name':
                                                      _firstnameController.text
                                                          .trim()
                                                });
                                              } else {
                                                await database
                                                    .collection("Patients")
                                                    .doc(value.userId)
                                                    .update({
                                                  'First_Name':
                                                      _firstnameController.text
                                                          .trim()
                                                });
                                              }
                                              _firstnameController.clear();
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text("Done"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        leading: const Icon(Icons.person_2),
                        title: Text(
                          "First Name:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.firstName,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your surname';
                                            } else if (value.length < 2) {
                                              return 'Please enter valid surname';
                                            }
                                            return null;
                                          },
                                          controller: _surnameController,
                                          keyboardType: TextInputType.name,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.person_3),
                                            labelText: 'Surname',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _surnameController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Surname':
                                                        _surnameController.text
                                                            .trim()
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Surname':
                                                        _surnameController.text
                                                            .trim()
                                                  });
                                                }
                                                _surnameController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        leading: const Icon(Icons.person_3),
                        title: Text(
                          "Surname:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.surname,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.alternate_email),
                        title: Text(
                          "Email Address:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.emailaddress,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your id number';
                                            } else if (value.length < 13) {
                                              return 'Please enter valid id number';
                                            }
                                            return null;
                                          },
                                          controller: _idNumberController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.remember_me),
                                            labelText: 'Id Number',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                          maxLength: 13,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _idNumberController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Id_Number':
                                                        _idNumberController.text
                                                            .trim()
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Id_Number':
                                                        _idNumberController.text
                                                            .trim()
                                                  });
                                                }
                                                _idNumberController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        leading: const Icon(Icons.remember_me),
                        title: Text(
                          "ID Number:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.idNumber,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          keyboardType: TextInputType.datetime,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your date of birth';
                                            } else if (value.length < 10) {
                                              return 'Please enter valid date of birth';
                                            }
                                            return null;
                                          },
                                          controller: _dateOfBirthController,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon: const Icon(
                                                Icons.calendar_month),
                                            suffix: const Text("dd/mm/yyyy"),
                                            labelText: 'Date Of Birth',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _dateOfBirthController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Date_Of_Birth':
                                                        Timestamp.fromDate(
                                                      DateTime(
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(6, 10),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(3, 5),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(0, 2),
                                                        ),
                                                      ),
                                                    ),
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Date_Of_Birth':
                                                        Timestamp.fromDate(
                                                      DateTime(
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(6, 10),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(3, 5),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(0, 2),
                                                        ),
                                                      ),
                                                    ),
                                                  });
                                                }
                                                _dateOfBirthController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        leading: const Icon(Icons.calendar_month),
                        title: Text(
                          "Date Of Birth:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          "${value.dateOfBirth.toDate().year} - ${value.dateOfBirth.toDate().day} - ${value.dateOfBirth.toDate().month}",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.call),
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          maxLength: 10,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your contact number';
                                            } else if (value.length < 10) {
                                              return 'Please enter valid contact number';
                                            }
                                            return null;
                                          },
                                          controller: _contactNumberController,
                                          keyboardType: TextInputType.phone,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon: const Icon(Icons.call),
                                            labelText: 'Contact Number',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _contactNumberController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Contact_Number':
                                                        _contactNumberController
                                                            .text
                                                            .trim()
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Contact_Number':
                                                        _contactNumberController
                                                            .text
                                                            .trim()
                                                  });
                                                }
                                                _contactNumberController
                                                    .clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        title: Text(
                          "Contact Number:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.contactNumber,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            : Selector<AdminManagement, Admin>(
                selector: (p0, p1) => p1.adminData!,
                builder: (context, value, child) => Container(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            showBottomSheet(
                              enableDrag: false,
                              context: context,
                              builder: (context) => Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Form(
                                      key: _editProfileFormKey,
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your name';
                                          } else if (value.length < 2) {
                                            return 'Please enter valid name';
                                          }
                                          return null;
                                        },
                                        controller: _firstnameController,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(fontSize: 14),
                                        decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 251, 0, 0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 250, 20, 3),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFD9458D),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 59, 59, 59),
                                            ),
                                          ),
                                          prefixIcon:
                                              const Icon(Icons.person_3),
                                          labelText: 'First Name',
                                          labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF2C3847),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            fixedSize: const Size(100, 50),
                                            foregroundColor:
                                                const Color(0xFFFFFFFF),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 0, 0),
                                          ),
                                          onPressed: () {
                                            _firstnameController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            fixedSize: const Size(100, 50),
                                            foregroundColor:
                                                const Color(0xFFFFFFFF),
                                            backgroundColor:
                                                const Color(0xFF2C3847),
                                          ),
                                          onPressed: () async {
                                            if (_editProfileFormKey
                                                .currentState!
                                                .validate()) {
                                              FirebaseFirestore database =
                                                  FirebaseFirestore.instance;
                                              if (context
                                                      .read<Authentication>()
                                                      .currentUser!
                                                      .displayName !=
                                                  null) {
                                                database
                                                    .collection("Admins")
                                                    .doc(value.userId)
                                                    .update({
                                                  'First_Name':
                                                      _firstnameController.text
                                                          .trim()
                                                });
                                              } else {
                                                await database
                                                    .collection("Patients")
                                                    .doc(value.userId)
                                                    .update({
                                                  'First_Name':
                                                      _firstnameController.text
                                                          .trim()
                                                });
                                              }
                                              _firstnameController.clear();
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text("Done"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        leading: const Icon(Icons.person_2),
                        title: Text(
                          "First Name:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.firstName,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your surname';
                                            } else if (value.length < 2) {
                                              return 'Please enter valid surname';
                                            }
                                            return null;
                                          },
                                          controller: _surnameController,
                                          keyboardType: TextInputType.name,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.person_3),
                                            labelText: 'Surname',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _surnameController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Surname':
                                                        _surnameController.text
                                                            .trim()
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Surname':
                                                        _surnameController.text
                                                            .trim()
                                                  });
                                                }
                                                _surnameController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        leading: const Icon(Icons.person_3),
                        title: Text(
                          "Surname:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.surname,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.alternate_email),
                        title: Text(
                          "Email Address:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.emailaddress,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your id number';
                                            } else if (value.length < 13) {
                                              return 'Please enter valid id number';
                                            }
                                            return null;
                                          },
                                          controller: _idNumberController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.remember_me),
                                            labelText: 'Id Number',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                          maxLength: 13,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _idNumberController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Id_Number':
                                                        _idNumberController.text
                                                            .trim()
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Id_Number':
                                                        _idNumberController.text
                                                            .trim()
                                                  });
                                                }
                                                _idNumberController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        leading: const Icon(Icons.remember_me),
                        title: Text(
                          "ID Number:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.idNumber,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          keyboardType: TextInputType.datetime,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your date of birth';
                                            } else if (value.length < 10) {
                                              return 'Please enter valid date of birth';
                                            }
                                            return null;
                                          },
                                          controller: _dateOfBirthController,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon: const Icon(
                                                Icons.calendar_month),
                                            suffix: const Text("dd/mm/yyyy"),
                                            labelText: 'Date Of Birth',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _dateOfBirthController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Date_Of_Birth':
                                                        Timestamp.fromDate(
                                                      DateTime(
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(6, 10),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(3, 5),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(0, 2),
                                                        ),
                                                      ),
                                                    ),
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Date_Of_Birth':
                                                        Timestamp.fromDate(
                                                      DateTime(
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(6, 10),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(3, 5),
                                                        ),
                                                        int.parse(
                                                          _dateOfBirthController
                                                              .text
                                                              .trim()
                                                              .substring(0, 2),
                                                        ),
                                                      ),
                                                    ),
                                                  });
                                                }
                                                _dateOfBirthController.clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        leading: const Icon(Icons.calendar_month),
                        title: Text(
                          "Date Of Birth:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          "${value.dateOfBirth.toDate().year} - ${value.dateOfBirth.toDate().day} - ${value.dateOfBirth.toDate().month}",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.call),
                        trailing: IconButton(
                            onPressed: () {
                              showBottomSheet(
                                enableDrag: false,
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Form(
                                        key: _editProfileFormKey,
                                        child: TextFormField(
                                          maxLength: 10,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your contact number';
                                            } else if (value.length < 10) {
                                              return 'Please enter valid contact number';
                                            }
                                            return null;
                                          },
                                          controller: _contactNumberController,
                                          keyboardType: TextInputType.phone,
                                          style: const TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 251, 0, 0),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 250, 20, 3),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFD9458D),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 59, 59, 59),
                                              ),
                                            ),
                                            prefixIcon: const Icon(Icons.call),
                                            labelText: 'Contact Number',
                                            labelStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF2C3847),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 255, 0, 0),
                                            ),
                                            onPressed: () {
                                              _contactNumberController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              fixedSize: const Size(100, 50),
                                              foregroundColor:
                                                  const Color(0xFFFFFFFF),
                                              backgroundColor:
                                                  const Color(0xFF2C3847),
                                            ),
                                            onPressed: () async {
                                              if (_editProfileFormKey
                                                  .currentState!
                                                  .validate()) {
                                                FirebaseFirestore database =
                                                    FirebaseFirestore.instance;
                                                if (context
                                                        .read<Authentication>()
                                                        .currentUser!
                                                        .displayName !=
                                                    null) {
                                                  database
                                                      .collection("Admins")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Contact_Number':
                                                        _contactNumberController
                                                            .text
                                                            .trim()
                                                  });
                                                } else {
                                                  await database
                                                      .collection("Patients")
                                                      .doc(value.userId)
                                                      .update({
                                                    'Contact_Number':
                                                        _contactNumberController
                                                            .text
                                                            .trim()
                                                  });
                                                }
                                                _contactNumberController
                                                    .clear();
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text("Done"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit)),
                        title: Text(
                          "Contact Number:",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C3847),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text(
                          value.contactNumber,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD9458D),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
