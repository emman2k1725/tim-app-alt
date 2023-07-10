import 'package:flutter/material.dart';
import 'package:tim_app/pages/homepage.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCpEGKr6xqRlgbc5ER3yzhZDkc9j67yERI",
        authDomain: "timdigital-4fe1b.firebaseapp.com",
        projectId: "timdigital-4fe1b",
        storageBucket: "timdigital-4fe1b.appspot.com",
        messagingSenderId: "1040048772960",
        appId: "1:1040048772960:web:3a998f289abfad940db005",
        measurementId: "G-4MZ3MT7SBR"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIM App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
      ),
      home: const Home(),
    );
  }
}
