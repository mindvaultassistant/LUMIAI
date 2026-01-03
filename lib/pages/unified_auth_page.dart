import 'package:flutter/material.dart';
import '../core/app_settings_controller.dart';
import 'main/main_shell.dart';

class UnifiedAuthPage extends StatelessWidget {
  final AppSettingsController settings;
  const UnifiedAuthPage({super.key, required this.settings});

  void _goMain(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MainShell(settings: settings)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("UnifiedAuthPage ✅", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await settings.setLastAuth("guest");
                  _goMain(context);
                },
                child: const Text("Continue as Guest"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  // şimdilik stub login
                  await settings.setLastAuth("user");
                  _goMain(context);
                },
                child: const Text("Login (stub)"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
