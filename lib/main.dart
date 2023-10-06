
import 'package:flutter/material.dart';
import 'package:bloodgroup/project-1/Homepage.dart';
import 'package:bloodgroup/project-1/AddButton.dart';
import 'package:bloodgroup/project-1/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     routes: {
        '/':(context)=>Homepage(),
       '/AddButton':(context)=>AddButton(),
       '/update' : (context) => updateDonor(),
     },
      initialRoute: '/',
    );
  }
}
