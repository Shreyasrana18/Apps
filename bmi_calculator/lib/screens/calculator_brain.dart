import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  final int height;
  final int weight;

  double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    final now = new DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String formatter = dateFormat.format(now);

    _firestore.collection('bmi_record').add({
      'bmi': _bmi,
      'uid': _auth.currentUser.uid,
      'date': formatter,
    });
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'OverWeight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'UnderWeight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher body weight than normal. Try to exercise more.';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower body weight than normal. Try to eat a bit more.';
    }
  }
}
