import 'package:flutter/material.dart';
import 'package:lumiAI/pages/main/main_shell.dart';

class UnifiedAuthPage extends StatelessWidget {
  final dynamic settings;
  const UnifiedAuthPage({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    // Onboarding/WELCOME tamamen kaldırıldı: direkt MainShell
    return MainShell(settings: settings);
  }
}
