import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewBmi extends StatefulWidget {
  static const String id = 'view_bmi';
  @override
  _ViewBmiState createState() => _ViewBmiState();
}

class _ViewBmiState extends State<ViewBmi> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  List Bmi = [];
  List date= [];

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getName() async {
    final response = await _firestore
        .collection('bmi_record')
        .where('uid', isEqualTo: loggedInUser.uid)
        .orderBy('date', descending: true)
        .get();

    final responseData = response.docs;
    for (var data in responseData) {
      final name = data.data()['bmi'];
      final date1 = data.data()['date'];
      date.add(date1);
      Bmi.add(name);
      print(name);
      print(Bmi.length);
    }
    setState(() {});
  }

  @override
  void initState() {
    getCurrentUser();
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your BMI',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade500,
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
              itemCount: Bmi.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date[index]}',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        '${double.parse(Bmi[index].toStringAsFixed(2))}',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
