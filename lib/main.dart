import 'package:flutter/material.dart';
import 'pages/main/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LumiApp());
}

class LumiApp extends StatelessWidget {
  const LumiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LumiAI',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0B0F17),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF0B0F17),
          primary: Color(0xFF6E7BFF),
          secondary: Color(0xFF8E5CFF),
        ),
      ),
      home: MainShellPage(),
    );
  }
}
