import 'package:cloud9toc/screens/login_screen.dart';
import 'package:cloud9toc/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // v2: status bar icons are dark (because screen background is light)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,    // white icons on dark module headers
    systemNavigationBarColor: Color(0xFFFFFFFF),  // white nav bar
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud9',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,   // ← was AppTheme.darkTheme in v1
      home: const LoginScreen(),
    );
  }
  }



