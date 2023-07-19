import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/homepage.dart';
import 'package:tim_app/utils/appTheme_style.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'backend/firebase/UserDataProvider.dart';
import 'controllers/menuAppController.dart';
import 'package:tim_app/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCpEGKr6xqRlgbc5ER3yzhZDkc9j67yERI",
        authDomain: "timdigital-4fe1b.firebaseapp.com",
        projectId: "timdigital-4fe1b",
        storageBucket: "timdigital-4fe1b.appspot.com",
        messagingSenderId: "1040048772960",
        appId: "1:1040048772960:web:3a998f289abfad940db005",
        measurementId: "G-4MZ3MT7SBR"),
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ChangeNotifierProvider<UserDataProvider>(
          create: (_) => UserDataProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = createRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TIM App',
      theme: AppTheme.lightTheme,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
    );
  }
}
