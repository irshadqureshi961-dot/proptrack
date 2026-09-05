import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

const String supabaseUrl = 'https://mqzxkajzyiksibqnkbxa.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1xenhrYWp6eWlrc2licW5rYnhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODg1NzgwNjgsImV4cCI6MjEwNDE1NDA2OH0.AtGDyw5LdS7taQeU3qdY5mIdUWDkRX4AwFwHuRFeiTE';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;
