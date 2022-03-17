import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference patientCollection = FirebaseFirestore.instance.collection('patients')
;}