import 'dart:async';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_screen.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      runApp(ErrorApp(error: details.exceptionAsString(), stack: details.stack.toString()));
    };

    try {
      runApp(const PropTrackApp());
    } catch (e, stack) {
      runApp(ErrorApp(error: e.toString(), stack: stack.toString()));
    }
  }, (Object error, StackTrace stack) {
    runApp(ErrorApp(error: error.toString(), stack: stack.toString()));
  });
}

class PropTrackApp extends StatefulWidget {
  const PropTrackApp({super.key});

  @override
  State<PropTrackApp> createState() => _PropTrackAppState();
}

class _PropTrackAppState extends State<PropTrackApp> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PropTrack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: _isLoggedIn
          ? const DashboardScreen()
          : LoginScreen(
              onLoginSuccess: () {
                setState(() {
                  _isLoggedIn = true;
                });
              },
            ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String error;
  final String stack;
  const ErrorApp({super.key, required this.error, required this.stack});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('RUNTIME ERROR DETECTED', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(error, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  const SizedBox(height: 10),
                  Text(stack, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
